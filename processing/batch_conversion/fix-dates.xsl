<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.tei-c.org/ns/1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:tei="http://www.tei-c.org/ns/1.0"
	xmlns:bod="https://www.bodleian.ox.ac.uk/bdlss"
	exclude-result-prefixes="xs tei bod"
	version="2.0">
    
    <!-- DON'T FORGET TO SET XSLT TRANSFORMER TO IGNORE THE SCHEMA (TO AVOID ADDING DEFAULT ATTRIBUTES) -->

	<xsl:output method="xml" encoding="UTF-8"/>

	<xsl:variable name="newline" select="'&#10;'"/>
    
    <xsl:function name="bod:year2str" as="xs:string*">
        <xsl:param name="years" as="xs:integer*"/>
        <xsl:variable name="years2" as="xs:integer*" select="if ($years = 0) then ($years, 1, -1) else $years"/>
        <xsl:variable name="stryears" as="xs:string*" select="
            for $year in (min($years2), max($years2))
                return 
                if ($year lt -999) then xs:string($year)
                else if ($year lt -99) then concat('-0', xs:string(abs($year)))
                else if ($year lt -9) then concat('-00', xs:string(abs($year)))
                else if ($year lt 0) then concat('-000', xs:string(abs($year)))
                else if ($year lt 10) then concat('000', xs:string($year)) 
                else if ($year lt 100) then concat('00', xs:string($year)) 
                else if ($year lt 1000) then concat('0', xs:string($year)) 
                else xs:string($year)"/>
        <xsl:copy-of select="distinct-values($stryears)"/>
    </xsl:function>
    
	<xsl:template match="/">
	    
	    <!-- First pass fixes dates -->
	    <xsl:variable name="firstpass">
	        <xsl:apply-templates/>
	    </xsl:variable>
	    
	    <!-- Second pass logs changes in revisionDesc -->
	    <xsl:apply-templates select="$firstpass" mode="updatechangelog"/>
	    <xsl:value-of select="$newline"/>
	    
	</xsl:template>
    
    <!-- The following templates do the first pass -->
    
    <xsl:template match="processing-instruction('xml-model')">
        <xsl:value-of select="$newline"/>
        <xsl:copy/>
        <xsl:if test="preceding::processing-instruction('xml-model')"><xsl:value-of select="$newline"/></xsl:if>
    </xsl:template>
    
    <xsl:template match="text()|comment()|processing-instruction()">
        <xsl:copy/>
    </xsl:template>
    
    <xsl:template match="*"><xsl:copy><xsl:copy-of select="@*"/><xsl:apply-templates/></xsl:copy></xsl:template>
    
    <xsl:template match="tei:origDate[text() = 'Gregorian']"><!-- Strip out useless placeholder origDate elements --></xsl:template>

    <xsl:template match="tei:origin[exists(tei:p[not(*) and matches(text(), '\d\d\d')]) and exists(tei:p[matches(text(), '(sakkaraja|buddhist) era')])]">
		<xsl:copy>
			<xsl:copy-of select="@*[not(name()='change')]"/>
		    <xsl:attribute name="change" select="'#fix-dates'"/>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>
    
    <xsl:template match="tei:origin/tei:p[not(*) and matches(text(), '\d\d\d') and contains(preceding-sibling::tei:p[1]/text(), 'sakkaraja era')]">
        <!-- Date calculation based on interpreting these as being the Burmese Era, with an epochal date of 22 March 638 CE, obtained from 
             https://en.wikipedia.org/wiki/Buddhist_calendar#History because that fits the equivalency established in WATJ337.xml -->
        <xsl:variable name="datetype" as="xs:string" select="if (contains(text(), 'composition')) then 'composition' else if (contains(text(), 'copying')) then 'copying' else 'unknown'"/>
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:analyze-string select="text()" regex="(\d?\d\d\d)">
                <xsl:matching-substring>
                    <xsl:variable name="sakkarajayear" as="xs:integer" select="xs:integer(regex-group(1))"/>
                    <xsl:variable name="gregorianyears" as="xs:integer*" select="($sakkarajayear + 639, $sakkarajayear + 638)"/>
                    <xsl:variable name="gregorianyearsstr" as="xs:string*" select="bod:year2str($gregorianyears)"/>
                    <origDate notBefore="{ $gregorianyearsstr[1] }" notAfter="{ $gregorianyearsstr[2] }" type="{ $datetype }">
                        <xsl:value-of select="."/>
                    </origDate>
                </xsl:matching-substring>
                <xsl:non-matching-substring>
                    <xsl:value-of select="."/>
                </xsl:non-matching-substring>
            </xsl:analyze-string>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:origin/tei:p[not(*) and matches(text(), '\d\d\d') and contains(preceding-sibling::tei:p[1]/text(), 'buddhist era')]">
        <!-- Date calculation based on interpreting these as being the Buddhist Era, with an epochal date of 12 May 522 BCE, obtained from 
             https://en.wikipedia.org/wiki/Buddhist_calendar#History because that fits the equivalency established in WATJ337.xml -->
        <xsl:variable name="datetype" as="xs:string" select="if (contains(text(), 'composition')) then 'composition' else if (contains(text(), 'copying')) then 'copying' else 'unknown'"/>
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:analyze-string select="text()" regex="(\d?\d\d\d)">
                <xsl:matching-substring>
                    <xsl:variable name="buddhistyear" as="xs:integer" select="xs:integer(regex-group(1))"/>
                    <xsl:variable name="gregorianyears" as="xs:integer*" select="($buddhistyear - 544, $buddhistyear - 543)"/>
                    <xsl:variable name="gregorianyearsstr" as="xs:string*" select="bod:year2str($gregorianyears)"/>
                    <origDate notBefore="{ $gregorianyearsstr[1] }" notAfter="{ $gregorianyearsstr[2] }" type="{ $datetype }">
                        <xsl:value-of select="."/>
                    </origDate>
                </xsl:matching-substring>
                <xsl:non-matching-substring>
                    <xsl:value-of select="."/>
                </xsl:non-matching-substring>
            </xsl:analyze-string>
        </xsl:copy>
    </xsl:template>
    	
    <!-- The following templates perform the second pass, to add a change elements to the revisionDesc -->
    
    <xsl:template match="text()|comment()|processing-instruction()" mode="updatechangelog">
        <xsl:copy/>
    </xsl:template>
    
    <xsl:template match="*" mode="updatechangelog"><xsl:copy><xsl:copy-of select="@*"/><xsl:apply-templates mode="updatechangelog"/></xsl:copy></xsl:template>
    
    <xsl:template match="tei:revisionDesc" mode="updatechangelog">
        <!-- Prepend a new change element, if the document has actually been changed (addition of XML comments not counted) -->
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:variable name="changes" select="//*[@change = '#fix-dates']"/>
            <xsl:if test="exists($changes)">
                <xsl:value-of select="$newline"/>
                <xsl:text>         </xsl:text>
                <change when="{ format-date(current-date(), '[Y0001]-[M01]-[D01]') }" change="fix-dates">
                    <xsl:value-of select="$newline"/>
                    <xsl:text>            </xsl:text>
                    <persName>
                        <xsl:text>Andrew Morrison</xsl:text>
                    </persName>
                    <xsl:text> </xsl:text>
                    <xsl:text>Added origDate tags with attributes normalized to the Gregorian calendar so dates can be indexed using </xsl:text>
                    <ref target="https://github.com/bodleian/senmai-mss/tree/master/processing/batch_conversion/fix-dates.xsl">fix-dates.xsl</ref>
                    <xsl:value-of select="$newline"/>
                    <xsl:text>         </xsl:text>
                </change>
            </xsl:if>
            <xsl:apply-templates mode="updatechangelog"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>