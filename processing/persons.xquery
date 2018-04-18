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
        
        let $mss := $collection//tei:TEI[.//(tei:persName|tei:author)[@key = $id]]
        
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
                let $roles := if ($isauthor) then 'author' else () (: Senmai has only marked up authors. Add lookup for @role values in $collection if/when they are added. :)
                for $role in $roles
                    order by $role
                    return <field name="pp_roles_sm">{ bod:personRoleLookup($role) }</field>    
                }
                {
                for $ms in $mss
                    let $msid := $ms/string(@xml:id)
                    let $url := concat("/catalog/", $msid[1])
                    let $classmark := $ms//tei:msDesc/tei:msIdentifier/tei:altIdentifier[1]/tei:idno[1]/text()
                    let $institution := normalize-space($ms//tei:msDesc/tei:msIdentifier/tei:institution[1]/text())
                    let $linktext := concat($classmark, ' (', $institution, ')')
                    order by $institution, $classmark
                    return <field name="link_manuscripts_smni">{ concat($url, "|", $linktext[1]) }</field>
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

