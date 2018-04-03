declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace saxon="http://saxon.sf.net/";
declare option saxon:output "indent=yes";

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
        return replace(lower-case($v), '\s', '')
        
    return distinct-values($variations5[not(. eq $title)])
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
            <listBibl>
{

    let $collection := collection('../../fihrist-mss/collections/?select=*.xml;recurse=yes')
    let $currentworks := doc('../../fihrist-mss/authority/works.xml')//tei:bibl
    let $currentids := $currentworks//tei:ref/@target/data()
    let $currentkeys := $currentworks//@xml:id/data()
    let $highestcurrentkey := max((for $k in $currentkeys return xs:integer(replace($k, '\D', ''))))
    let $linebreak := '&#10;&#10;'
    
    (: Look for works not already in the authority file :)
    let $newworks := (
        for $w in $collection//tei:msItem[@xml:id and tei:title and not(@n) and not(lower-case(normalize-space(string-join(tei:title, ''))) = ('none', 'unknown', 'unknown.', ''))]
            return
            if ($w/@xml:id/data() = $currentids) then
                ( )
            else
                let $titles := for $t in $w/tei:title return normalize-space(string-join($t//text(), ' '))
                let $sharestitleswith := $currentworks[(for $t in tei:title/text() return ($t, local:generateVariations($t))) = (for $t in $titles return ($t, local:generateVariations($t)))]
                return
                if ( count($sharestitleswith) gt 0 ) then
                    (: This work appears to be another copy of an existing work :)
                    <work>
                        {
                        for $t in $titles return <title>{ $t }</title>
                        }
                        {
                        for $o in $sharestitleswith
                            return
                            <instanceof>{ $o/@xml:id/data() }</instanceof>
                        }
                        <id infile="{ tokenize(base-uri($w), '/')[last()] }">{ $w/@xml:id/data() }</id>
                    </work>
                else
                    (: This work's title is not in the authority file :)
                    <work>
                        {
                        for $t in $titles return <title>{ $t }</title>
                        }
                        <id infile="{ tokenize(base-uri($w), '/')[last()] }">{ $w/@xml:id/data() }</id>
                    </work>
    )
    
    let $newentries := (
        (
        for $w at $pos in $newworks[not(instanceof)]
            order by $w/title[1]/text()
            (:order by :)
            return
            <bibl xml:id="{ concat('work_', $highestcurrentkey + $pos) }">
                {
                for $t at $i in $w/title/text()
                    return
                    if ($i eq 1) then
                        <title type="uniform">{ $t }</title>
                    else
                        <title type="variant">{ $t }</title>
                }
                {
                for $id in $w/id
                    return (
                    <ref target="{ $id/text() }"/>
                    ,
                    comment{concat(' ../collections/', $id/@infile/data(), '#', $id/text(), ' ')}
                    )
                }
            </bibl>
        ),(
        for $w in $newworks[instanceof]
            order by $w/title[1]/text()
            return
            <bibl copyOf="{ string-join($w/instanceof/text(), ' ') }">
                {
                for $t at $i in $w/title/text()
                    return
                    if ($i eq 1) then
                        <title type="uniform">{ $t }</title>
                    else
                        <title type="variant">{ $t }</title>
                }
                {
                for $id in $w/id
                    return (
                    <ref target="{ $id/text() }"/>
                    ,
                    comment{concat(' ../collections/', $id/@infile/data(), '#', $id/text(), ' ')}
                    )
                }
            </bibl>
        )
    )
    
    (: Output the new authority file :)
    return ($linebreak, doc('../authority/works_additions.xml')//tei:bibl, $linebreak, for $e in $newentries return ($e, $linebreak))

}
            </listBibl>
        </body>
    </text>
</TEI>




        
