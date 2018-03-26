declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace saxon="http://saxon.sf.net/";
declare option saxon:output "indent=yes";

(: Copied from Hebrew, needs adapting to work with Senmai :)

declare function local:logging($level, $msg, $values)
{
    (: Trick XQuery into doing trace() to output message to STDERR but not insert it into the XML :)
    substring(trace('', concat(upper-case($level), '	', $msg, '	', string-join($values, '	'), '	')), 0, 0)
};

declare function local:generateVariations($name as xs:string) as xs:string*
{
    let $variations1 := (
        replace($name, '\.', ''),
        replace($name, ',', ''),
        replace($name, '[\-–—]', ''),
        replace($name, '[\.,\-–—]', ''),
        replace(replace(replace(replace($name, "[ʻ’'ʻ‘]", "'"), 'ʻ̐', "'"), 'ʹ̨', "'"), 'ʻ̨', "'"),
        replace(replace(replace(replace($name, "[ʻ’'ʻ‘]" ,""), 'ʻ̐', ''), 'ʹ̨', ''), 'ʻ̨', ''),
        replace($name, 'ʺ', '"'),
        replace($name, '["ʺ]', '')
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
            lower-case($v),
            upper-case($v)
        )
    let $variations5 := for $v in distinct-values($variations4)
        return (
            $v,
            normalize-space($v),
            replace($v, '\s', '')
        )
    return distinct-values($variations5[not(. eq $name)])
};

processing-instruction xml-model {'href="http://www.tei-c.org/release/xml/tei/custom/schema/relaxng/tei_all.rng" type="application/xml" schamtypens="http://relaxng.org/ns/structure/1.0"'},
processing-instruction xml-model {'href="http://www.tei-c.org/release/xml/tei/custom/schema/relaxng/tei_all.rng" type="application/xml" schamtypens="http://purl.oclc.org/dsdl/schematron"'},
processing-instruction xml-model {'href="authority-schematron.sch" type="application/xml" schamtypens="http://purl.oclc.org/dsdl/schematron"'},
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
            <listPerson>
{

    let $collection := collection('../../collections/?select=*.xml;recurse=yes')

    let $skipkeys := ()
    
    (: First, extract all names of people from the TEI files and build in-memory XML structure, 
       doing some string manipulations to anticipate potential different versions of the same name :)
    
    let $allpeople := (
    
        for $p in $collection//(tei:author|tei:persName)[not(ancestor::tei:revisionDesc or ancestor::tei:respStmt)]
            let $name := normalize-space(string-join($p//text(), ' '))
            return
            if ($p/@key eq $skipkeys) then
                ()
            else if (string-length($name) eq 0) then
                ()
            else
                (: In senmai, there are no alternate versions of authors marked up as child persName elements. Possibly
                   sibling author elements are the same person's name in different languages, but there is no semantic
                   basis for assuming such a relationship, so just take all the text nodes within each author :)
                <person>
                    <name>{ $name }</name>
                    {
                    (: Generate variations. These aren't to be indexed, they're to increase the chance of matching this name with 
                       the same person just with a slightly different name (e.g. due to transliteration or punctuation differences :)
                    for $v in local:generateVariations($name)
                        return <alt>{ $v }</alt>
                    }
                    <ref>{ concat(substring-after(base-uri($p), 'collections/'), '#', $p/ancestor::*[@xml:id][1]/@xml:id) }</ref>
                </person>
    )
    
    (: Now de-duplicate, generating keys, and putting the names in alphabetical order :)
    
    let $dedupedpeople := (
    
        for $t at $pos in distinct-values($allpeople/name)
            order by lower-case($t)
            let $variations := distinct-values(($t, $allpeople[name = $t]/alt))
            let $variationsofvariations := distinct-values(($variations, $allpeople[name = $variations or alt = $variations]/(name|alt)))
            let $variants := for $n in distinct-values(($t, $allpeople[name = $variationsofvariations or alt = $variationsofvariations]/name)) order by $n return $n
            return
            if (count($variants) gt 1) then
            
                (: This name matches a variation of a name elsewhere, or it has a variation that 
                   matches another name, so pick this one if it comes first alphabetically :)
                
                if (index-of($variants, $t) eq 1) then
                    <person xml:id="{ concat('person_', $pos) }">
                        <persName type="display">{ $t }</persName>
                        {
                        for $a in subsequence($variants, 2)
                            return
                            <persName type="variant">{ $a }</persName>
                        }
                        {
                        for $r in distinct-values($allpeople[name = $variants]/ref)
                            order by $r
                            return
                            comment{concat(' ../collections/', $r, ' ')}
                        }
                    </person>
                else
                    ()                  
            else
            
                (: There are no variants of this name elsewhere :)
                
                <person xml:id="{ concat('person_', $pos) }">
                    <persName type="display">{ $t }</persName>
                    
                    {
                    for $r in distinct-values($allpeople[name = $t]/ref)
                        order by $r
                        return
                        comment{concat(' ../collections/', $r, ' ')}
                    }
                </person>
    )
    
    (: Output the authority file :)
    
    return $dedupedpeople

}
            </listPerson>
        </body>
    </text>
</TEI>




        
