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

	<xsl:template match="/">
	   <xsl:apply-templates/>
	   <xsl:value-of select="$newline"/>
	</xsl:template>
    
    <xsl:template match="processing-instruction('xml-model')">
        <xsl:value-of select="$newline"/>
        <xsl:copy/>
        <xsl:if test="preceding::processing-instruction('xml-model')"><xsl:value-of select="$newline"/></xsl:if>
    </xsl:template>
    
    <xsl:template match="text()|comment()|processing-instruction()">
        <xsl:copy/>
    </xsl:template>
    
    <xsl:template match="*"><xsl:copy><xsl:copy-of select="@*"/><xsl:apply-templates/></xsl:copy></xsl:template>
    
    <xsl:template match="*[not(descendant-or-self::tei:origin) and not(.//comment()) and not(.//@*[not(name()='xml:lang')]) and string-length(normalize-space(string-join(.//text(), ''))) eq 0]">
        <!-- Remove any element (except the origin) that is self-closing, or just contains whitespace, 
             or contains nothing but child elements which themselves contains nothing. Attributes are
             counted as something worth keeping, unless they are xml:langs. These all look like they
             were part of some template, but in most cases content has been added instead of replacing
             the empty elements, hence a lot of pointless cruft that produces ugliness when converted to HTML. -->
    </xsl:template>
    
    <xsl:template match="tei:origin[not(.//tei:origDate)]">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:value-of select="$newline"/>
            <xsl:text>                     </xsl:text>
            <xsl:comment>
<xsl:value-of select="$newline"/>
<xsl:text>                        When adding dates, normalize attributes to the Gregorian calendar
                        e.g. &lt;origDate notBefore="1875" notAfter="1876"&gt;1237 in the sakkaraja era&lt;/origDate&gt;
</xsl:text>
            <xsl:text>                     </xsl:text></xsl:comment><xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:revisionDesc">
        <!-- Prepend a new change element -->
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:value-of select="$newline"/>
            <xsl:text>         </xsl:text>
            <change when="{ format-date(current-date(), '[Y0001]-[M01]-[D01]') }">
                <xsl:value-of select="$newline"/>
                <xsl:text>            </xsl:text>
                <persName>
                    <xsl:text>Andrew Morrison</xsl:text>
                </persName>
                <xsl:text> </xsl:text>
                <xsl:text>Removed empty elements using </xsl:text>
                <ref target="https://github.com/bodleian/senmai-mss/tree/master/processing/batch_conversion/remove-empty-elements.xsl">remove-empty-elements.xsl</ref>
                <xsl:value-of select="$newline"/>
                <xsl:text>         </xsl:text>
            </change>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>