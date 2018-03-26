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
	    
	    <!-- First pass adds summaries -->
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

	<xsl:template match="tei:author | tei:persName">
		<xsl:copy>
			<xsl:copy-of select="@*[not(name()=('key','change'))]"/>
		    <xsl:choose>
                <xsl:when test="self::tei:author">
		            <xsl:variable name="thisval" select="normalize-space(string-join(.//text(), ' '))"/>
		            <xsl:if test="$thisval = $people/tei:persName">
		                <xsl:attribute name="key" select="$people[tei:persName = $thisval]/@xml:id"/>
		                <xsl:attribute name="change" select="'#add-person-keys'"/>
		            </xsl:if>
		        </xsl:when>
		        <xsl:when test="self::tei:persName">
		            <xsl:variable name="thisval" select="normalize-space(string-join(.//text(), ' '))"/>
		            <xsl:if test="$thisval = $people/tei:persName">
		                <xsl:attribute name="key" select="$people[tei:persName = $thisval]/@xml:id"/>
		                <xsl:attribute name="change" select="'#add-person-keys'"/>
		            </xsl:if>
		        </xsl:when>
		    </xsl:choose>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>
    	
    <!-- The following templates perform the second pass, to add a change elements to the revisionDesc -->
    
    <xsl:template match="text()|comment()|processing-instruction()" mode="updatechangelog">
        <xsl:copy/>
    </xsl:template>
    
    <xsl:template match="*" mode="updatechangelog"><xsl:copy><xsl:copy-of select="@*"/><xsl:apply-templates mode="updatechangelog"/></xsl:copy></xsl:template>
    
    <xsl:template match="tei:author | tei:persName" mode="updatechangelog">
        <xsl:copy>
            <!-- Take out the change attribute on second pass, as they are probably more clutter than is needed, and not actually changing the content -->
            <xsl:copy-of select="@*[not(name()='change')]"/>
            <xsl:apply-templates mode="updatechangelog"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:revisionDesc" mode="updatechangelog">
        <!-- Prepend a new change element, if the document has actually been changed (addition of XML comments not counted) -->
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:variable name="changes" select="//*[@change = '#add-person-keys']"/>
            <xsl:if test="exists($changes)">
                <xsl:value-of select="$newline"/>
                <xsl:text>         </xsl:text>
                <change when="{ format-date(current-date(), '[Y0001]-[M01]-[D01]') }"><!-- Do not use add xml:id for this change -->
                    <xsl:value-of select="$newline"/>
                    <xsl:text>            </xsl:text>
                    <persName>
                        <xsl:text>Andrew Morrison</xsl:text>
                    </persName>
                    <xsl:text> </xsl:text>
                    <xsl:text>Added person key attributes using </xsl:text>
                    <ref target="https://github.com/bodleian/senmai-mss/tree/master/processing/batch_conversion/add-person-keys.xsl">add-person-keys.xsl</ref>
                    <xsl:value-of select="$newline"/>
                    <xsl:text>         </xsl:text>
                </change>
            </xsl:if>
            <xsl:apply-templates mode="updatechangelog"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>