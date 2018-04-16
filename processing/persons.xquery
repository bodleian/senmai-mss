import module namespace bod = "http://www.bodleian.ox.ac.uk/bdlss" at "https://raw.githubusercontent.com/bodleian/consolidated-tei-schema/master/msdesc2solr.xquery";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare option saxon:output "indent=yes";


<add>
{
    let $doc := doc("../authority/persons.xml")
    let $collection := collection("../collections?select=*.xml;recurse=yes")
    let $people := $doc//tei:person

    for $person in $people
    
        let $id := $person/@xml:id/string()
        let $name := normalize-space($person//tei:persName[@type = 'display' or (@type = 'variant' and not(preceding-sibling::tei:persName))][1]/string())
        let $isauthor := boolean($collection//tei:author[@key = $id or .//persName/@key = $id])
        (: Uncomment this if persNames start appearing inside titles: let $issubject := boolean($collection//tei:msItem/tei:title//tei:persName[not(@role) and @key = $id]) :)
        
        let $mss1 := $collection//tei:TEI[.//(tei:persName)[@key = $id]]/concat('/catalog/', string(@xml:id), '|', (./tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:msIdentifier/tei:idno)[1]/text())
        let $mss2 := $collection//tei:TEI[.//(tei:author)[@key = $id]]/concat('/catalog/', string(@xml:id), '|', (./tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:msIdentifier/tei:idno)[1]/text())
        let $mss := distinct-values(($mss1, $mss2))
        
        let $variants := $person/tei:persName[@type="variant"]

        return if (count($mss) gt 0) then 
            <doc>
                <field name="type">person</field>
                <field name="pk">{ $id }</field>
                <field name="id">{ $id }</field>
                <field name="title">{ $name }</field>
                <field name="alpha_title">{  bod:alphabetize($name) }</field>
                <field name="pp_name_s">{ $name }</field>
                {
                for $variant in $variants
                    let $vname := normalize-space($variant/string())
                    order by $vname
                    return <field name="pp_variant_sm">{ $vname }</field>
                }
                {
                let $roles := if ($isauthor) then 'author' else () (: Add lookup for @role values in $collection if/when they are added. :)
                for $role in $roles
                    order by $role
                    return <field name="pp_roles_sm">{ bod:personRoleLookup($role) }</field>    
                }
                {
                for $ms in $mss
                    order by $ms
                    return <field name="link_manuscripts_smni">{ $ms }</field>
                }
                {
                for $relatedid in distinct-values((tokenize(translate($person/@corresp, '#', ''), ' '), tokenize(translate($person/@sameAs, '#', ''), ' ')))
                    let $url := concat("/catalog/", $relatedid)
                    let $linktext := $doc//tei:listBibl/tei:bibl[@xml:id = $relatedid]/tei:persName[@type = 'display' or (@type = 'variant' and not(preceding-sibling::tei:persName))][1]/string()
                    return
                    <field name="link_related_smni">{ concat($url, "|", $linktext) }</field>
            }
            </doc>
        else
            ()
}

</add>

