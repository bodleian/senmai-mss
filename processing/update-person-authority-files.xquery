declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace saxon="http://saxon.sf.net/";
declare option saxon:output "indent=yes";

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
            replace(replace(replace(translate($v, 'āṅñèṃīṇū', 'anneminu'), 'o̐', 'o'), 'ą̄', 'a'), 'ą̄', 'a')
        )
    let $variations4 := for $v in distinct-values($variations3)
        return replace(lower-case($v), '\s', '')
        
    return distinct-values($variations4[not(. eq $name)])
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

    let $collection := collection('../../fihrist-mss/collections/?select=*.xml;recurse=yes')
    let $currentpeople := doc('../../fihrist-mss/authority/persons.xml')//tei:person
    let $currentpeoplenamevariations := distinct-values(for $n in $currentpeople//tei:persName/text() return ($n, local:generateVariations($n)))
    let $currentkeys := $currentpeople//@xml:id/data()
    let $highestcurrentkey := max((for $k in $currentkeys return xs:integer(replace($k, '\D', ''))))
    let $linebreak := '&#10;&#10;'
    
    (: Look for people not already in the authority file :)
    let $newpeople := (
        for $p in $collection//(tei:author|tei:editor|tei:persName[not(parent::author)])[not(@key) and not(ancestor::tei:revisionDesc or ancestor::tei:respStmt)]
            let $name := normalize-space(string-join($p//text(), ' '))
            return
            if (string-length($name) eq 0) then
                ()
            else if ($p/@key = $currentkeys) then
                ()
            else if (some $v in ($name, local:generateVariations($name)) satisfies $v = $currentpeoplenamevariations) then
                ()
            else
                (: This person's name is not in the authority file :)
                <newperson>
                    <name>{ $name }</name>
                    <file>{ tokenize(base-uri($p), '/')[last()] }</file>
                    {
                    comment{concat(' ../collections/', substring-after(base-uri($p), 'collections/'), '#', $p/ancestor::*[@xml:id][1]/@xml:id, ' ')}
                    }
                </newperson>
    )
    
    (: De-duplicate :)
    let $uniquenewpeople := (
        for $n in distinct-values($newpeople//name)
            return
            <newperson>
                <name>{ $n }</name>
                {
                $newpeople[name = $n]/comment()
                }
            </newperson>
    )
    
    let $newentries := (
        for $p at $pos in $uniquenewpeople
            order by $p/name[1]/text()
            return
            <person xml:id="{ concat('person_', ($highestcurrentkey + $pos)) }">
                {
                for $n at $i in $p/name/text()
                    return
                    if ($i eq 1) then
                        <persName type="display">{ $n }</persName>
                    else
                        <persName type="variant">{ $n }</persName>
                }
                {
                for $c in $p/comment()
                    order by $c
                    return $c
                }
            </person>
    )
    
    (: Output the new authority file :)
    return ($linebreak, doc('../authority/persons_additions.xml')//tei:person, $linebreak, for $e in $newentries return ($e, $linebreak))

}
            </listPerson>
        </body>
    </text>
</TEI>




        
