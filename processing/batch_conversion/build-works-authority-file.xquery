declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace saxon="http://saxon.sf.net/";
declare option saxon:output "indent=yes";

(: Copied from Hebrew, needs adapting to work with Senmai :)

declare function local:logging($level, $msg, $values)
{
    (: Trick XQuery into doing trace() to output message to STDERR but not insert it into the XML :)
    substring(trace('', concat(upper-case($level), '	', $msg, '	', string-join($values, '	'), '	')), 0, 0)
};

declare function local:generateVariations($title as xs:string) as xs:string*
{
    let $variations1 := (
        replace($title, '\.', ''),
        replace($title, ',', ''),
        replace($title, '[\-–—]', ''),
        replace($title, '[\.,\-–—]', ''),
        replace(replace(replace(replace($title, "[ʻ’'ʻ‘]", "'"), 'ʻ̐', "'"), 'ʹ̨', "'"), 'ʻ̨', "'"),
        replace(replace(replace(replace($title, "[ʻ’'ʻ‘]" ,""), 'ʻ̐', ''), 'ʹ̨', ''), 'ʻ̨', ''),
        replace($title, 'ʺ', '"'),
        replace($title, '["ʺ]', '')
    )
    let $variations2 := for $v in distinct-values($variations1)
        return (
            $v,
            replace($v , '\(.*\)', ''),
            replace($v, '[\(\)]', ''),
            replace($v, '\[.*\]', ''),
            replace($v, '[\[\]]', '')
        )
    let $variations3 := for $v in distinct-values($variations2)
        return (
            $v,
            replace(replace(replace(translate($v, 'āṅñèṃīṇ', 'annemin'), 'o̐', 'o'), 'ą̄', 'a'), 'ą̄', 'a')
        )
    let $variations4 := for $v in distinct-values($variations3)
        return (
            $v,
            replace($v, '^(the|a|an) ', '')
        )
    let $variations5 := for $v in distinct-values($variations4)
        return (
            $v,
            replace($v, ',.*Fascicle.*$', '')
        )
    let $variations6 := for $v in distinct-values($variations5)
        return (
            $v,
            lower-case($v),
            upper-case($v)
        )
    let $variations7 := for $v in distinct-values($variations6)
        return (
            $v,
            normalize-space($v),
            replace($v, '\s', '')
        )
    return distinct-values($variations7[not(. eq $title)])
};

processing-instruction xml-model {'href="http://www.tei-c.org/release/xml/tei/custom/schema/relaxng/tei_all.rng" type="application/xml" schamtypens="http://relaxng.org/ns/structure/1.0"'},
processing-instruction xml-model {'href="http://www.tei-c.org/release/xml/tei/custom/schema/relaxng/tei_all.rng" type="application/xml" schamtypens="http://purl.oclc.org/dsdl/schematron"'},
processing-instruction xml-model {'href="authority-schematron.sc" type="application/xml" schamtypens="http://purl.oclc.org/dsdl/schematron"'},
<TEI xmlns="http://www.tei-c.org/ns/1.0">
    <teiHeader>
        <fileDesc>
            <titleStmt>
                <title>Title</title>
            </titleStmt>
            <publicationStmt>
                <p>Publication Information</p>
            </publicationStmt>
            <sourceDesc>
                <p>Information about the source</p>
            </sourceDesc>
        </fileDesc>
    </teiHeader>
    <text>
        <body>
            <listBibl>
{

    let $collection := collection('../../collections/?select=*.xml;recurse=yes')
    let $newline := '&#10;'
    let $skipids := ()
    
    (: First, extract all title from identifiable works in the TEI files and build in-memory XML structure, 
       doing some string manipulations to anticipate potential different versions of the same title :)
    
    let $allworks := (
    
        for $msitem in $collection//tei:msItem[@xml:id]
            let $titles as xs:string* := (for $t in $msitem/title[not(@type='alt')] return normalize-space(string-join($t//text(), ' ')))[string-length(.) gt 0][not(upper-case(.) = 'NONE' or starts-with(upper-case(.), 'UNKNOWN'))]
            let $alttitles as xs:string* := (for $t in $msitem/title[@type='alt'] return normalize-space(string-join($t//text(), ' ')))[string-length(.) gt 0]
            return
            if ($msitem/@xml:id eq $skipids) then
                ()
            else if (count($titles) eq 0 and not($msitem/tei:author)) then
                local:logging('warn', 'Cannot do anything with untitled work', $msitem)
            else if (count($titles) eq 0 and $msitem/tei:author[string-length(normalize-space(string-join(.//text(), ''))) gt 0]) then
                let $title := concat('Untitled work by ', normalize-space(string-join($msitem/tei:author[1]//text(), ' ')))
                return
                
                <work>
                    <title n="{ $msitem/@n }">{ $title }</title>
                    {
                    (: Generate variations. These aren't to be indexed, they're to increase the chance of matching this title with 
                       the same work just with a slightly different title (e.g. due to transliteration or punctuation differences :)
                    for $v in local:generateVariations($title)
                        return <alt>{ $v }</alt>
                    }
                    <ref>{ concat(substring-after(base-uri($msitem), 'collections/'), '#', $msitem/@xml:id) }</ref>
                </work>
            else
                (: In senmai, there are multiple titles in most works :)
                <work>
                    {
                    for $title in $titles
                        return
                        (
                        <title n="{ $msitem/@n }">{ $title }</title>
                        ,
                        for $v in local:generateVariations($title)
                            return <alt>{ $v }</alt>
                        )
                    }
                    {
                    (: A very small number have a type attribute of "alt". Handle these separately so they don't get chosen as the title to be displayed :)
                    for $title in $alttitles
                        return
                        (
                        <alt n="{ $msitem/@n }">{ $title }</alt>
                        ,
                        for $v in local:generateVariations($title)
                            return <alt>{ $v }</alt>
                        )
                    }
                    <ref>{ concat(substring-after(base-uri($msitem), 'collections/'), '#', $msitem/@xml:id) }</ref>
                </work>
    )
    
    (: Now de-duplicate, generating keys, and putting the titles in alphabetical order :)
    
    let $dedupedworks := (
    
        for $t at $pos in distinct-values($allworks/title)
            order by lower-case($t)
            let $variations := distinct-values(($t, $allworks[title = $t]/alt))
            let $variationsofvariations := distinct-values(($variations, $allworks[title = $variations or alt = $variations]/(title|alt)))
            let $variants := for $n in distinct-values(($t, $allworks[title = $variationsofvariations or alt = $variationsofvariations]/title)) order by $n return $n
            return
            if (count($variants) gt 1) then
            
                (: This title matches a variation of a title elsewhere, or it has a variation that 
                   matches another title, so pick this one if it comes first alphabetically :)
                
                if (index-of($variants, $t) eq 1) then
                    <bibl xml:id="{ concat('work_', $pos) }">
                        <title type="uniform">{ $t }</title>
                        {
                        for $a in subsequence($variants, 2)
                            return
                            <title type="variant">{ $a }</title>
                        }
                        {
                        for $a in distinct-values($allworks[title = $variationsofvariations or alt = $variationsofvariations]/alt[@n])
                            return
                            <title type="variant">{ $a }</title>
                        }
                        {
                        for $r in distinct-values($allworks[title = $variants]/ref)
                            order by $r
                            return
                            (<ref target="{ substring-after($r, '#') }"/>, comment{concat(' ../collections/', $r, ' ')})
                        }
                    </bibl>
                else
                    ()                  
            else
            
                (: There are no variants of this title elsewhere :)
                
                <bibl xml:id="{ concat('work_', $pos) }">
                    <title type="uniform">{ $t }</title>
                    
                    {
                    for $r in distinct-values($allworks[title = $t]/ref)
                        order by $r
                        return
                        (<ref target="{ substring-after($r, '#') }"/>, comment{concat(' ../collections/', $r, ' ')})
                    }
                </bibl>
    )
    
    (: Output the authority file :)
    
    return $dedupedworks

}
            </listBibl>
        </body>
    </text>
</TEI>




        
