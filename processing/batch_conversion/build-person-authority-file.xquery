declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace saxon="http://saxon.sf.net/";
declare option saxon:output "indent=yes";

declare function local:logging($level, $msg, $values)
{
    (: Trick XQuery into doing trace() to output message to STDERR but not insert it into the XML :)
    substring(trace('', concat(upper-case($level), '	', $msg, '	', string-join($values, '	'), '	')), 0, 0)
};

declare function local:normalize4Crossrefing($name as xs:string) as xs:string
{
    let $normalized1 := replace(normalize-unicode($name, 'NFKD'), '^(the|a|an) ', '', 'i')
    let $normalized2 := 
        translate(
            translate(
                replace(
                    replace(
                        replace(
                            lower-case($normalized1), 
                            '[^\p{L}\d]', ''
                        ),
                    'æ', 'ae'),
                'œ', 'oe'),
            'áąāḍèęēġįīḷṁṃńñṅṇöǫōṗśṭųūư', 'aaadeeegiilmmnnnnooopstuuu'),
        'ʼ', '')
    let $normalized3 := replace(replace(replace(replace(replace($normalized2, "[ʻ’'ʻ‘ʺʹ]" ,""), 'ʻ̐', ''), 'ʹ̨', ''), 'ʻ̨', ''), '"', '')
    return $normalized3
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
    let $linebreak := '&#10;&#10;'
    
    (: First, extract all names of people from the TEI files and build in-memory XML structure, 
       doing some string manipulations to anticipate potential different versions of the same name :)
    let $allpeople as element()* := (
    
        for $p in $collection//(tei:author|tei:persName)[not(ancestor::tei:revisionDesc or ancestor::tei:respStmt)]
            let $name as xs:string := normalize-space(string-join($p//text(), ' '))
            return
            if (string-length($name) eq 0) then
                ()
            else
                (: In senmai, there are no alternate versions of authors marked up as child persName elements. Possibly
                   sibling author elements are the same person's name in different languages, but there is no semantic
                   basis for assuming such a relationship, so just take all the text nodes within each author :)
                <person>
                    <name>{ $name }</name>
                    <norm>{ local:normalize4Crossrefing($name) }</norm>
                    <ref>{ concat(substring-after(base-uri($p), 'collections/'), '#', $p/ancestor::*[@xml:id][1]/@xml:id) }</ref>
                </person>
    )
    
    (: Now de-duplicate, generating keys, and putting the names in alphabetical order :)
    
    let $dedupedpeople as element()* := (
    
        for $t at $pos in distinct-values($allpeople/name)
            order by lower-case($t)
            let $variations := distinct-values(($t, $allpeople[name = $t]/norm))
            let $variationsofvariations := distinct-values(($variations, $allpeople[name = $variations or norm = $variations]/(name|norm)))
            let $variants := for $n in distinct-values(($t, $allpeople[name = $variationsofvariations or norm = $variationsofvariations]/name)) order by $n return $n
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
    
    (: Output the authority file. The persNames of type "crossref" are for cross-referencing in 
       the future, when updating the authority file for new works, and won't be indexed. :)
    for $b in $dedupedpeople
        return
        (
        $linebreak,
        <person xml:id="{ $b/@xml:id }">
            { $b/persName }
            {
            for $t in distinct-values(for $v in $b/persName/text() return local:normalize4Crossrefing($v))
                return
                <persName type="crossref">{ $t }</persName>
            }
            { $b/comment() }
        </person>
        )

}
            </listPerson>
        </body>
    </text>
</TEI>




        
