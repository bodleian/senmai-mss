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
    
    <xsl:template match="tei:msContents/tei:textLang[not(*)]">
        <!-- All manuscripts also have textLangs in msItems, so convert these ones in the msContent into summaries
             prepending the physical form to make it more useful -->
        <summary>
            <xsl:attribute name="change" select="'#fix-langs'"/>
            <xsl:variable name="physform" select="lower-case(/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:physDesc/tei:objectDesc/@form)"/>
            <xsl:choose>
                <xsl:when test="$physform = ('concertina_book','concertina__book')">
                    <xsl:text>Concertina book </xsl:text>
                </xsl:when>
                <xsl:when test="$physform = 'rolled_book'">
                    <xsl:text>Rolled book </xsl:text>
                </xsl:when>
                <xsl:when test="$physform = 'palm_leaf'">
                    <xsl:text>Palm leaf </xsl:text>
                </xsl:when>
                <xsl:when test="$physform = 'modern_notebook'">
                    <xsl:text>Modern notebook </xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>Manuscript </xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:value-of select="lower-case(.)"/>
        </summary>
    </xsl:template>

    <xsl:template match="tei:msContents[not(tei:textLang)]">
        <!-- There are 35 without duplicate textlangs, so construction a summary -->
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <summary>
                <xsl:attribute name="change" select="'#fix-langs'"/>
                <xsl:variable name="physform" select="lower-case(/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:physDesc/tei:objectDesc/@form)"/>
                <xsl:choose>
                    <xsl:when test="$physform = ('concertina_book','concertina__book')">
                        <xsl:text>Concertina book</xsl:text>
                    </xsl:when>
                    <xsl:when test="$physform = 'rolled_book'">
                        <xsl:text>Rolled book</xsl:text>
                    </xsl:when>
                    <xsl:when test="$physform = 'palm_leaf'">
                        <xsl:text>Palm leaf</xsl:text>
                    </xsl:when>
                    <xsl:when test="$physform = 'modern_notebook'">
                        <xsl:text>Modern notebook</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>Manuscript</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:text> written in </xsl:text>
                <xsl:choose>
                    <xsl:when test="//msItem/textLang">
                        <xsl:value-of select="(//msItem/textLang)[1]/text()"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>shan</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:text> script</xsl:text>
            </summary>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="tei:msItem/tei:textLang">
        <!-- None of these have otherLangs attributes, despite the text containing lists of languages -->
        <xsl:variable name="textval" select="normalize-space(string-join(.//text(), ' '))"/>
        <xsl:variable name="otherlangs" select="tokenize($textval, ',')[not(. = ('shan', 'tai mao'))]"/>
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <!-- All of these textLangs already have a mainLang attribute of "shn". None have an otherLang. 
                 It is possible the mainLang of "shn" came from a template, and is sometimes incorrect, but
                 this is no way to know, so leaving it as-is. -->
            <xsl:if test="count($otherlangs) gt 0">
                <xsl:attribute name="otherLangs">
                    <xsl:for-each select="$otherlangs">
                        <xsl:choose>
                            <xsl:when test=". eq 'pali'">pli</xsl:when>
                            <xsl:when test=". eq 'khuen'">khf</xsl:when>
                            <xsl:when test=". eq 'burmese'">mya</xsl:when>
                            <xsl:when test=". eq 'tai lue'">khb</xsl:when>
                            <xsl:when test=". eq 'pa-o'">blk</xsl:when>
                            <xsl:when test=". eq 'lanna'">nod</xsl:when>
                        </xsl:choose>
                        <xsl:if test="position() ne last()"><xsl:text> </xsl:text></xsl:if>
                    </xsl:for-each>
                </xsl:attribute>
                <xsl:attribute name="change" select="'#fix-langs'"/>
            </xsl:if>
            <xsl:choose>
                <xsl:when test="string-length($textval) gt 0">
                    <xsl:apply-templates/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="change" select="'#fix-langs'"/>
                    <xsl:text>shan</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:revisionDesc">
        <!-- Prepend a new change element -->
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:value-of select="$newline"/>
            <xsl:text>         </xsl:text>
            <change when="{ format-date(current-date(), '[Y0001]-[M01]-[D01]') }" xml:id="fix-langs">
                <xsl:value-of select="$newline"/>
                <xsl:text>            </xsl:text>
                <persName>
                    <xsl:text>Andrew Morrison</xsl:text>
                </persName>
                <xsl:text> </xsl:text>
                <xsl:text>Modified languages using </xsl:text>
                <ref target="https://github.com/bodleian/senmai-mss/tree/master/processing/batch_conversion/fix-langs.xsl">fix-langs.xsl</ref>
                <xsl:value-of select="$newline"/>
                <xsl:text>         </xsl:text>
            </change>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>