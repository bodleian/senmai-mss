import module namespace bod = "http://www.bodleian.ox.ac.uk/bdlss" at "https://raw.githubusercontent.com/bodleian/consolidated-tei-schema/master/msdesc2solr.xquery";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare option saxon:output "indent=yes";


<add>
{
    for $x in collection('../collections/?select=*.xml;recurse=yes')
    
        let $msid := $x//tei:TEI/@xml:id/data()
        let $subfolders := string-join(tokenize(substring-after(base-uri($x), 'collections/'), '/')[position() lt last()], '/')
        let $htmlfilename := concat($x//tei:sourceDesc/tei:msDesc[1]/@xml:id/data(), '.html')
        let $htmldoc := doc(concat("html/", $subfolders, '/', $htmlfilename))
        
        let $repository := normalize-space($x//tei:msDesc/tei:msIdentifier/tei:repository[1]/text())
        let $institution := normalize-space($x//tei:msDesc/tei:msIdentifier/tei:institution/text())
        let $shelfmark := normalize-space($x//tei:msDesc/tei:msIdentifier/tei:idno[1]/text())
        let $normalizedshelfmark := replace($shelfmark, '\W', ' ')
        let $sortshelfmark := upper-case(replace($normalizedshelfmark, '\s', ''))
        let $title := concat($shelfmark, ' (', $institution, ')')
        
        let $languages2index := ('shn','en','shn-Latn-x-lc')
        (:
            Guide to Solr field naming conventions:
                ms_ = manuscript index field
                _i = integer field
                _b = boolean field
                _s = string field (tokenized)
                _t = text field (not tokenized)
                _?m = multiple field (typically facets)
                *ni = not indexed (except _tni fields which are copied to the fulltext index)
        :)
            
        return <doc>
            <field name="type">manuscript</field>
            <field name="pk">{ $msid }</field>
            <field name="id">{ $msid }</field>
            <field name="filename_sni">{ base-uri($x) }</field>
            { bod:one2one($x//tei:msDesc/tei:msIdentifier/tei:collection, 'ms_collection_s', 'Not specified') }
            { bod:one2one($x//tei:msDesc/tei:msIdentifier/tei:institution, 'institution_sm', 'Not specified') }
            { bod:one2one($x//tei:msDesc/tei:msIdentifier/tei:idno[@type="shelfmark"], 'ms_shelfmark_s') }
            { bod:one2one($x//tei:msDesc/tei:msIdentifier/tei:idno[@type="shelfmark"], 'ms_shelfmark_sort') }
            { bod:one2one($x//tei:msDesc/tei:msIdentifier/tei:idno, 'ms_shelfmark_s') }
            { bod:one2one($x//tei:msDesc/tei:msIdentifier/tei:idno, 'ms_shelfmark_sort') }
            { bod:string2one($title, 'title') }
            { bod:many2one($x//tei:msDesc/tei:msIdentifier/tei:repository, 'ms_repository_s') }
            { bod:many2many($x//tei:msContents/tei:msItem/tei:author/tei:persName, 'ms_authors_sm') }
            { bod:many2many($x//tei:sourceDesc//tei:name[@type="corporate"]/tei:persName, 'ms_corpnames_sm') }
            { bod:many2many($x//tei:sourceDesc//tei:persName, 'ms_persnames_sm') }
            { bod:many2many($x//tei:physDesc//tei:extent, 'ms_extents_sm') }
            { bod:many2many($x//tei:physDesc//tei:layout, 'ms_layout_sm') }
            { bod:many2many($x//tei:msContents/tei:msItem/tei:note, 'ms_notes_sm') }
            { bod:many2many($x//tei:msContents/tei:summary, 'ms_summary_sni') }
            { bod:many2many($x//tei:msContents/tei:msItem/tei:title, 'ms_works_sm') }
            { for $lang in $languages2index
                return bod:many2many($x//tei:msContents/tei:msItem/tei:title[@xml:lang = $lang], concat('ms_works_', $lang, '_sm'))
            }
            { bod:physForm($x//tei:physDesc/tei:objectDesc, 'ms_physform_sm', 'Not specified') }
            { bod:languages($x//tei:sourceDesc//tei:textLang, 'lang_sm', 'Not specified') }
            { bod:centuries($x//tei:origin//tei:origDate, 'ms_date_sm', 'Not specified') }
            { bod:indexHTML($htmldoc, 'ms_textcontent_tni') }
            { bod:displayHTML($htmldoc, 'display') }
        </doc>
}
</add>


