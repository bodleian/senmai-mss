<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.tei-c.org/ns/1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:tei="http://www.tei-c.org/ns/1.0"
	exclude-result-prefixes="xs tei"
	version="2.0">
    
    <!-- DON'T FORGET TO SET XSLT TRANSFORMER TO IGNORE THE SCHEMA (TO AVOID ADDING DEFAULT ATTRIBUTES) -->

	<xsl:output method="xml" encoding="UTF-8"/>

	<xsl:variable name="newline" select="'&#10;'"/>
    
	<xsl:variable name="people" select="document('../../authority/persons_base.xml')//tei:TEI/tei:text/tei:body/tei:listPerson/tei:person"/>
	
	<xsl:template match="/">
	    <xsl:apply-templates/>
	    <xsl:copy-of select="$newline"/>
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

	<xsl:template match="tei:author | tei:persName">
		<xsl:copy>
			<xsl:copy-of select="@*[not(name()='key')]"/>
		    <xsl:choose>
                <xsl:when test="self::tei:author">
		            <xsl:variable name="thisval" select="normalize-space(string-join(.//text(), ' '))"/>
		            <xsl:if test="$thisval = $people/tei:persName">
		                <xsl:attribute name="key" select="$people[tei:persName = $thisval]/@xml:id"/>
		            </xsl:if>
		        </xsl:when>
		        <xsl:when test="self::tei:persName">
		            <xsl:variable name="thisval" select="normalize-space(string-join(.//text(), ' '))"/>
		            <xsl:if test="$thisval = $people/tei:persName">
		                <xsl:attribute name="key" select="$people[tei:persName = $thisval]/@xml:id"/>
		            </xsl:if>
		        </xsl:when>
		    </xsl:choose>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>