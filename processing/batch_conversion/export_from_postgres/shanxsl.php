<?php

function dateLang () {
        return strftime("%A");
}


$handle = opendir('/home/shanadmin/xmlfile/');
while(false !== ($entry = readdir($handle))){
if(fnmatch("ms*.xml",$entry)){
$shanvar[] = $entry;
}
}

$counter = count($shanvar);

for($y=0;$y<$counter; $y++){
$xfilename = $shanvar[$y];
$inputdom = new DomDocument();
$inputdom->load('/home/shanadmin/xmlfile/'.$xfilename);
$xsl = new DomDocument();
$xsl->load("/home/shanadmin/xmlfile/shan.xsl");


// Load the documents and process using $xslt
//$xsl = $proc->importStylesheet($xsl);

$proc = new XsltProcessor();
$proc->registerPhpFunctions();
$proc->importStyleSheet($xsl);
$newdom =  $proc->transformToDoc($inputdom);
//$lentest = strlen($shanvar[$y]);
//$lenpos = $lentest-(strpos($shanvar[$y],'.xml'));
//$test = substr($shanvar[$y],0,$lenpos);
$newone = str_replace(".xml","_tei.xml",($shanvar[$y]));
$newdom->save('/home/shanadmin/xmlfile/tei/'.$newone);
/* transform and output the xml document */
//$newdom = $proc->transformToDoc($inputdom);

//print $newdom->saveXML();
//$newone = $shanvar[$y].'tei.xml';
//$newdom->save($newone);
}

?>


