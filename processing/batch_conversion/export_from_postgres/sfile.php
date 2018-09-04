<?php
header('Content-Type: application/xml');

function xmlEscape($string) {
    return str_replace(array('&', '<', '>', '\'', '"'), array('&amp;', '&lt;', '&gt;', '&apos;', '&quot;'), $string);
}

//$out = fopen("out.txt", "w");


$counter = array();
$stack = array();

include '/home/shanadmin/config.php';

$msallquery = "select msid from ms order by msid";
$msallresult = pg_query($msallquery) or die('query failed');




while($row = pg_fetch_assoc($msallresult)){
$msid = $row['msid'];
array_push($counter,$msid);
}


$wkquery = pg_prepare($dbb, "wkquery", "select msid, array_agg(loc_text_temple) as loctexttemple, array_agg(date_comp_era) as datecompera, array_agg(date_comp_year) as datecompyear, array_agg(date_copying_era) as datecopyingera, array_agg(date_copying_year) as datecopyingyear, array_agg(lines) as lines, array_agg(number_pages) as numberpages, array_agg(o_donor) as odonor, array_agg(o_donor_s) as odonors, array_agg(o_donor_slang::text) as odonorslang, array_agg(o_donor_ic::text) as odonoric, array_agg(o_donation_place) as odonationplace, array_agg(o_donation_place_s) as odonationplaces, array_agg(o_donation_place_slang::text) as odonationplaceslang, array_agg(o_donation_place_ic::text) as odonationplaceic from mswork, wk where mswork.wkid=wk.wkid and msid=$1 group by msid");

$wkgroupquery = pg_prepare($dbb, "wkgroupquery","select wk.wkid, title_translit, title_translat, title_s, title_slang, lang_text, author_translit, author_s, author_slang, altauthor1, altauthor2, altauthor3, text_descriptor, subject, subject_comments, rhyming, rhyming_s, rhyming_slang, complete, variant_title, variant_title_s, variant_title_slang, introduction, colophon, colophon_type, colophon_text, ornamentation, diagrams, pictures, remarks, text_otherloc, summary_intro, summary_intro_s, summary_intro_slang, summarymain, summarymain_s, summarymain_slang, additional_colophon, incipit, explicit from mswork,wk where mswork.wkid=wk.wkid and msid=$1");

$msquery = pg_prepare($dbb,"msquery","select msid, location_id, former_owner, former_owner_s, former_owner_slang, msnumber, msnumber_s, script, mstype, appearance_writing, appearance_paper, appearance_comments, materialms, size_width, size_length, covers, cover_emb, cover_col, cover_mat, numbering, condition, damage, p_copy_donor, p_copy_donor_s, p_copy_donor_slang, p_copy_ic, place_pcopy, place_pcopy_s, place_pcopy_slang, place_pcopy_ic, size_depth, history_comments,imagelink from ms where msid=$1 order by msid");


$i=0;

foreach($counter as $value){
$filen = "/home/shanadmin/xmlfile/ms.".strtolower($value).".xml";
$out = fopen($filen, "w");
$initial = '<?xml version="1.0" encoding="UTF-8"?><shan>'.PHP_EOL;
fwrite ($out,$initial);

        	$msresult = pg_execute($dbb,"msquery",array($value));
                $wkresult = pg_execute($dbb,"wkquery",array($value));  
		$wkgroupresult = pg_execute($dbb,"wkgroupquery",array($value));


		while($row = pg_fetch_assoc($msresult)){

                $msvar = '<msid>'.xmlEscape($row['msid']).'</msid>'.PHP_EOL.
                $msvar = '<locationid>'.xmlEscape($row['location_id']).'</locationid>'.PHP_EOL.
                $msvar = '<formerowner>'.xmlEscape($row['former_owner']).'</formerowner>'.PHP_EOL.
                $msvar = '<formerownershan>'.xmlEscape($row['former_owner_s']).'</formerownershan>'.PHP_EOL.
                $msvar = '<formerownershanlang>'.xmlEscape(preg_replace('/[{"}]/','',$row['former_owner_slang'])).'</formerownershanlang>'.PHP_EOL.
                $msvar = '<msnumber>'.xmlEscape($row['msnumber']).'</msnumber>'.PHP_EOL.
                $msvar = '<msnumbershan>'.xmlEscape($row['msnumber_s']).'</msnumbershan>'.PHP_EOL.
                $msvar = '<script>'.xmlEscape(preg_replace('/[{"}]/','',$row['script'])).'</script>'.PHP_EOL.
                $msvar = '<mstype>'.xmlEscape($row['mstype']).'</mstype>'.PHP_EOL.
                $msvar = '<appearancewriting>'.xmlEscape($row['appearance_writing']).'</appearancewriting>'.PHP_EOL.
                $msvar = '<appearancepaper>'.xmlEscape($row['appearance_paper']).'</appearancepaper>'.PHP_EOL.
                $msvar = '<appearancecomments>'.xmlEscape($row['appearance_comments']).'</appearancecomments>'.PHP_EOL.
                $msvar = '<materialms>'.xmlEscape($row['materialms']).'</materialms>'.PHP_EOL.
                $msvar = '<sizewidth>'.xmlEscape($row['size_width']).'</sizewidth>'.PHP_EOL.
                $msvar = '<sizelength>'.xmlEscape($row['size_length']).'</sizelength>'.PHP_EOL.
                $msvar = '<covers>'.xmlEscape($row['covers']).'</covers>'.PHP_EOL.
                $msvar = '<coveremb>'.xmlEscape(preg_replace('/[{"}]/','',$row['cover_emb'])).'</coveremb>'.PHP_EOL.
                $msvar = '<covercol>'.xmlEscape(preg_replace('/[{"}]/','',$row['cover_col'])).'</covercol>'.PHP_EOL.
                $msvar = '<covermat>'.xmlEscape($row['cover_mat']).'</covermat>'.PHP_EOL.
                $msvar = '<numbering>'.xmlEscape($row['numbering']).'</numbering>'.PHP_EOL.
                $msvar = '<condition>'.xmlEscape($row['condition']).'</condition>'.PHP_EOL.
                $msvar = '<damage>'.xmlEscape(preg_replace('/[{"}]/','',$row['damage'])).'</damage>'.PHP_EOL.
                $msvar = '<pcopydonor>'.xmlEscape($row['p_copy_donor']).'</pcopydonor>'.PHP_EOL.
                $msvar = '<pcopydonorshan>'.xmlEscape($row['p_copy_donor_s']).'</pcopydonorshan>'.PHP_EOL.
                $msvar = '<pcopydonorshanlang>'.xmlEscape(preg_replace('/[{"}]/','',$row['p_copy_donor_slang'])).'</pcopydonorshanlang>'.PHP_EOL.
                $msvar = '<pcopyic>'.xmlEscape(preg_replace('/[{"}]/','',$row['p_copy_ic'])).'</pcopyic>'.PHP_EOL.
                $msvar = '<placepcopy>'.xmlEscape($row['place_pcopy']).'</placepcopy>'.PHP_EOL.
                $msvar = '<placepcopyshan>'.xmlEscape($row['place_pcopy_s']).'</placepcopyshan>'.PHP_EOL.
                $msvar = '<placepcopyshanlang>'.xmlEscape(preg_replace('/[{"}]/','',$row['place_pcopy_slang'])).'</placepcopyshanlang>'.PHP_EOL.
                $msvar = '<placepcopyic>'.xmlEscape(preg_replace('/[{"}]/','',$row['place_pcopy_ic'])).'</placepcopyic>'.PHP_EOL.
                $msvar = '<sizedepth>'.xmlEscape($row['size_depth']).'</sizedepth>'.PHP_EOL.
                $msvar = '<historycomments>'.xmlEscape($row['history_comments']).'</historycomments>'.PHP_EOL.
                $msvar = '<imagelink>'.xmlEscape($row['imagelink']).'</imagelink>'.PHP_EOL;


                fwrite($out,$msvar);
                }
                while($row = pg_fetch_assoc($wkresult)){
                $wkvar = '<loctexttemple>'.xmlEscape(preg_replace('/[{"}]/','',$row['loctexttemple'])).'</loctexttemple>'.PHP_EOL.
                $wkvar = '<datecompera>'.xmlEscape(preg_replace('/[{"}]/','',$row['datecompera'])).'</datecompera>'.PHP_EOL.
                $wkvar = '<datecompyear>'.xmlEscape(preg_replace('/[{"}]/','',$row['datecompyear'])).'</datecompyear>'.PHP_EOL.
                $wkvar = '<datecopyingera>'.xmlEscape(preg_replace('/[{"}]/','',$row['datecopyingera'])).'</datecopyingera>'.PHP_EOL.
                $wkvar = '<datecopyingyear>'.xmlEscape(preg_replace('/[{"}]/','',$row['datecopyingyear'])).'</datecopyingyear>'.PHP_EOL.
                $wkvar = '<lines>'.xmlEscape(preg_replace('/[{"}]/','',$row['lines'])).'</lines>'.PHP_EOL.
                $wkvar = '<odonor>'.xmlEscape(preg_replace('/[{"}]/','',$row['odonor'])).'</odonor>'.PHP_EOL.
                $wkvar = '<odonors>'.xmlEscape(preg_replace('/[{"}\\\\]/','',$row['odonors'])).'</odonors>'.PHP_EOL.
                $wkvar = '<odonorslang>'.xmlEscape(preg_replace('/[{"}\\\\]/','',$row['odonorslang'])).'</odonorslang>'.PHP_EOL.
                $wkvar = '<odonoric>'.xmlEscape(preg_replace('/[{"}\\\\]/','',$row['odonoric'])).'</odonoric>'.PHP_EOL.
                $wkvar = '<odonationplace>'.xmlEscape(preg_replace('/[{"}\\\\]/','',$row['odonationplace'])).'</odonationplace>'.PHP_EOL.
                $wkvar = '<odonationplaces>'.xmlEscape(preg_replace('/[{"}\\\\]/','',$row['odonationplaces'])).'</odonationplaces>'.PHP_EOL.
                $wkvar = '<odonationplaceslang>'.xmlEscape(preg_replace('/[{"}\\\\]/','',$row['odonationplaceslang'])).'</odonationplaceslang>'.PHP_EOL.
                $wkvar = '<odonationplaceic>'.xmlEscape(preg_replace('/[{"}\\\\]/','',$row['odonationplaceic'])).'</odonationplaceic>'.PHP_EOL.
                $wkvar = '<numberpages>'.xmlEscape(preg_replace('/[{"}]/','',$row['numberpages'])).'</numberpages>'.PHP_EOL;

                fwrite($out,$wkvar);

		} 
		while($row = pg_fetch_assoc($wkgroupresult)){
		$grpvar = '<group>'.PHP_EOL.
		$grpvar = '<wkid>'.xmlEscape($row['wkid']).'</wkid>'.PHP_EOL.
	        $grpvar	= '<titletranslit>'.xmlEscape($row['title_translit']).'</titletranslit>'.PHP_EOL.
		$grpvar = '<titletranslat>'.xmlEscape($row['title_translat']).'</titletranslat>'.PHP_EOL.
		$grpvar = '<titleshan>'.xmlEscape($row['title_s']).'</titleshan>'.PHP_EOL.
		$grpvar = '<titleslang>'.xmlEscape($row['title_slang']).'</titleslang>'.PHP_EOL.
		$grpvar = '<langtext>'.xmlEscape($row['lang_text']).'</langtext>'.PHP_EOL.
		$grpvar = '<authortranslit>'.xmlEscape($row['author_translit']).'</authortranslit>'.PHP_EOL.
		$grpvar = '<authorshan>'.xmlEscape($row['author_s']).'</authorshan>'.PHP_EOL.
		$grpvar = '<authorslang>'.xmlEscape($row['author_slang']).'</authorslang>'.PHP_EOL.
		$grpvar = '<altauthor1>'.xmlEscape($row['altauthor1']).'</altauthor1>'.PHP_EOL.
		$grpvar = '<altauthor2>'.xmlEscape($row['altauthor2']).'</altauthor2>'.PHP_EOL.
		$grpvar = '<altauthor3>'.xmlEscape($row['altauthor3']).'</altauthor3>'.PHP_EOL.
		$grpvar = '<textdescriptor>'.xmlEscape($row['text_descriptor']).'</textdescriptor>'.PHP_EOL.
		$grpvar = '<subject>'.xmlEscape($row['subject']).'</subject>'.PHP_EOL.
		$grpvar = '<subjectcomments>'.xmlEscape($row['subject_comments']).'</subjectcomments>'.PHP_EOL.
		$grpvar = '<rhyming>'.xmlEscape($row['rhyming']).'</rhyming>'.PHP_EOL.	
		$grpvar = '<rhymingshan>'.xmlEscape($row['rhyming_s']).'</rhymingshan>'.PHP_EOL.
		$grpvar = '<rhymingslang>'.xmlEscape($row['rhyming_slang']).'</rhymingslang>'.PHP_EOL.
		$grpvar = '<complete>'.xmlEscape($row['complete']).'</complete>'.PHP_EOL.
		$grpvar = '<varianttitle>'.xmlEscape($row['variant_title']).'</varianttitle>'.PHP_EOL.
		$grpvar = '<varianttitleshan>'.xmlEscape($row['variant_title_s']).'</varianttitleshan>'.PHP_EOL.
		$grpvar = '<varianttitleslang>'.xmlEscape($row['variant_title_slang']).'</varianttitleslang>'.PHP_EOL.
 		$grpvar = '<introduction>'.xmlEscape($row['introduction']).'</introduction>'.PHP_EOL.
 		$grpvar = '<colophon>'.xmlEscape($row['colophon']).'</colophon>'.PHP_EOL.
 		$grpvar = '<colophontype>'.xmlEscape($row['colophon_type']).'</colophontype>'.PHP_EOL.
 		$grpvar = '<colophontext>'.xmlEscape($row['colophon_text']).'</colophontext>'.PHP_EOL.
 		$grpvar = '<ornamentation>'.xmlEscape($row['ornamentation']).'</ornamentation>'.PHP_EOL.
 		$grpvar = '<diagrams>'.xmlEscape($row['diagrams']).'</diagrams>'.PHP_EOL.
 		$grpvar = '<pictures>'.xmlEscape($row['pictures']).'</pictures>'.PHP_EOL.
 		$grpvar = '<remarks>'.xmlEscape($row['remarks']).'</remarks>'.PHP_EOL.
 		$grpvar = '<textotherloc>'.xmlEscape($row['text_otherloc']).'</textotherloc>'.PHP_EOL.
 		$grpvar = '<summaryintro>'.xmlEscape($row['summary_intro']).'</summaryintro>'.PHP_EOL.
 		$grpvar = '<summaryintros>'.xmlEscape($row['summary_intro_s']).'</summaryintros>'.PHP_EOL.
 		$grpvar = '<summaryintroslang>'.xmlEscape($row['summary_intro_slang']).'</summaryintroslang>'.PHP_EOL.
 		$grpvar = '<summarymain>'.xmlEscape($row['summarymain']).'</summarymain>'.PHP_EOL.
 		$grpvar = '<summarymainshan>'.xmlEscape($row['summarymain_s']).'</summarymainshan>'.PHP_EOL.
 		$grpvar = '<summarymainslang>'.xmlEscape($row['summarymain_slang']).'</summarymainslang>'.PHP_EOL.
 		$grpvar = '<additionalcolophon>'.xmlEscape($row['additional_colophon']).'</additionalcolophon>'.PHP_EOL.
 		$grpvar = '<incipit>'.xmlEscape($row['incipit']).'</incipit>'.PHP_EOL.
	 	$grpvar = '<explicit>'.xmlEscape($row['explicit']).'</explicit>'.PHP_EOL.


		$grpvar = '</group>'.PHP_EOL;
		fwrite($out,$grpvar);	

		}

$endbit = '</shan>';

fwrite($out,$endbit);

fclose($out);
$i++;


}






//fclose($out);
?>


