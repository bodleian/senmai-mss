<?oxygen RNGSchema="enrich-wamcp.rnc" type="contact"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
<TEI xmlns="http://www.tei-c.org/ns/1.0">   
<teiHeader xmlns="http://www.tei-c.org/ns/1.0">   
<fileDesc>
    <titleStmt>
        <title></title>
        <funder>Dhammakaya Foundation</funder>
      <principal>Gillian Evison</principal>  
    </titleStmt>
	<xsl:text>&#xa;</xsl:text>
    <publicationStmt>
        <date calendar="Gregorian"></date>
		<xsl:text>&#xa;</xsl:text>
<publisher><xsl:value-of select="shan/locationid"/></publisher>
<xsl:text>&#xa;</xsl:text>
        <pubPlace>
            <address>
          <addrLine/>
            <addrLine/>
            <street/>
            <settlement>
       		<xsl:choose>
		<xsl:when test="shan/locationid='OXFOR'">
                <xsl:text>Bodleian Library, Oxford University</xsl:text>
		</xsl:when>
		 <xsl:when test="shan/locationid='Lash2'">
                <xsl:text>Lashio</xsl:text>
                </xsl:when>
 		<xsl:when test="shan/locationid='WAT_J'">
                <xsl:text>Wat Jong Klang</xsl:text>
                </xsl:when>
 		<xsl:when test="shan/locationid='WAT_T'">
                <xsl:text>Wat Tiyasathan</xsl:text>
                </xsl:when>
        	<xsl:when test="shan/locationid='CAMBR'">
                <xsl:text>University Library, Cambridge University</xsl:text>
                </xsl:when>
        	<xsl:when test="shan/locationid='LASHI'">
                <xsl:text>Lashio</xsl:text>
                </xsl:when>
  		<xsl:when test="shan/locationid='LN_SO'">
                <xsl:text>SOAS Library, School of Oriental and African Studies</xsl:text>
                </xsl:when>
  		<xsl:when test="shan/locationid='LN_BL'">
                <xsl:text>London BL</xsl:text>
                </xsl:when>
  		<xsl:when test="shan/locationid='IRELA'">
                <xsl:text>Ireland</xsl:text>
                </xsl:when>
  		<xsl:when test="shan/locationid='WAT_PA'">
                <xsl:text>Wat Pang Mu</xsl:text>
                </xsl:when>
  		<xsl:when test="shan/locationid='WAT_PH'">
                <xsl:text>Wat Pha Nuan</xsl:text>
                </xsl:when>
		<xsl:otherwise>
		<xsl:text>Unspecified</xsl:text>
		</xsl:otherwise>
		</xsl:choose>
            </settlement>
            <postCode/>
            <addrLine>
                <ref target="http://www.bodleian.ox.ac.uk/bodley/finding-resources/special/projects/hidden-collections">Revealing Hidden Collections: Buddhist Literature in UK and SE Asian collections</ref>
            </addrLine>
<addrLine>
    <email>andrew.skilton@bodleian.ox.ac.uk</email>
</addrLine>
            </address>
        </pubPlace>
		<xsl:text>&#xa;</xsl:text>
        <idno>
            <xsl:value-of select="shan/locationid"/>
        </idno>
		<xsl:text>&#xa;</xsl:text>
    </publicationStmt>  
	<xsl:text>&#xa;</xsl:text>
    <sourceDesc>
	<xsl:text>&#xa;</xsl:text>
        <msDesc xmlns="http://www.tei-c.org/ns/1.0" xml:id="OCIMO" xml:lang="en">
		<xsl:text>&#xa;</xsl:text>
            <msIdentifier>
			<xsl:text>&#xa;</xsl:text>
                <settlement>
                	<xsl:choose>
                		<xsl:when test="shan/locationid='OXFOR'">
                			<xsl:text>Bodleian Library, Oxford University</xsl:text>
                		</xsl:when>
                		<xsl:when test="shan/locationid='Lash2'">
                			<xsl:text>Lashio</xsl:text>
                		</xsl:when>
                		<xsl:when test="shan/locationid='WAT_J'">
                			<xsl:text>Wat Jong Klang</xsl:text>
                		</xsl:when>
                		<xsl:when test="shan/locationid='WAT_T'">
                			<xsl:text>Wat Tiyasathan</xsl:text>
                		</xsl:when>
                		<xsl:when test="shan/locationid='CAMBR'">
                			<xsl:text>University Library, Cambridge University</xsl:text>
                		</xsl:when>
                		<xsl:when test="shan/locationid='LASHI'">
                			<xsl:text>Lashio</xsl:text>
                		</xsl:when>
                		<xsl:when test="shan/locationid='LN_SO'">
                			<xsl:text>SOAS Library, School of Oriental and African Studies</xsl:text>
                		</xsl:when>
                		<xsl:when test="shan/locationid='LN_BL'">
                			<xsl:text>London BL</xsl:text>
                		</xsl:when>
                		<xsl:when test="shan/locationid='IRELA'">
                			<xsl:text>Ireland</xsl:text>
                		</xsl:when>
                		<xsl:when test="shan/locationid='WAT_PA'">
                			<xsl:text>Wat Pang Mu</xsl:text>
                		</xsl:when>
                		<xsl:when test="shan/locationid='WAT_PH'">
                			<xsl:text>Wat Pha Nuan</xsl:text>
                		</xsl:when>
                		<xsl:otherwise>
                			<xsl:text>Unspecified</xsl:text>
                		</xsl:otherwise>
                	</xsl:choose>
                </settlement>
				<xsl:text>&#xa;</xsl:text>
                <institution>
		<xsl:choose>
		<xsl:when test="shan/locationid='OXFOR'">
                <xsl:text>Bodleian Library, Oxford University</xsl:text>
		</xsl:when>
		 <xsl:when test="shan/locationid='Lash2'">
                <xsl:text>Lashio</xsl:text>
                </xsl:when>
 		<xsl:when test="shan/locationid='WAT_J'">
                <xsl:text>Wat Jong Klang</xsl:text>
                </xsl:when>
 		<xsl:when test="shan/locationid='WAT_T'">
                <xsl:text>Wat Tiyasathan</xsl:text>
                </xsl:when>
        	<xsl:when test="shan/locationid='CAMBR'">
                <xsl:text>University Library, Cambridge University</xsl:text>
                </xsl:when>
        	<xsl:when test="shan/locationid='LASHI'">
                <xsl:text>Lashio</xsl:text>
                </xsl:when>
  		<xsl:when test="shan/locationid='LN_SO'">
                <xsl:text>SOAS Library, School of Oriental and African Studies</xsl:text>
                </xsl:when>
  		<xsl:when test="shan/locationid='LN_BL'">
                <xsl:text>London BL</xsl:text>
                </xsl:when>
  		<xsl:when test="shan/locationid='IRELA'">
                <xsl:text>Ireland</xsl:text>
                </xsl:when>
  		<xsl:when test="shan/locationid='WAT_PA'">
                <xsl:text>Wat Pang Mu</xsl:text>
                </xsl:when>
  		<xsl:when test="shan/locationid='WAT_PH'">
                <xsl:text>Wat Pha Nuan</xsl:text>
                </xsl:when>
		<xsl:otherwise>
		<xsl:text>Unspecified</xsl:text>
		</xsl:otherwise>
		</xsl:choose>
                </institution>
				<xsl:text>&#xa;</xsl:text>
                <repository>
 		<xsl:choose>
                <xsl:when test="shan/locationid='OXFOR'">
                <xsl:text>Oxford, United Kingdom</xsl:text>
                </xsl:when>
                <xsl:when test="shan/locationid='CAMBR'">
                <xsl:text>Cambridge, United Kingdom</xsl:text>
                </xsl:when>
                <xsl:when test="shan/locationid='LN_SO'">
                <xsl:text>London, United Kingdom</xsl:text>
                </xsl:when>
                <xsl:when test="shan/locationid='Lash2'">
                <xsl:text>Burma, Shan State (north)</xsl:text>
                </xsl:when>
                <xsl:when test="shan/locationid='WAT_J'">
                <xsl:text>Thailand, Maehongson (province), Maehongson (town)</xsl:text>
                </xsl:when>
                <xsl:when test="shan/locationid='WAT_T'">
                <xsl:text>Thailand, Chiang Mai (province), Maeteng (district)</xsl:text>
                </xsl:when>
                <xsl:when test="shan/locationid='LASHI'">
                <xsl:text>Burma, Shan State (north)</xsl:text>
                </xsl:when>
                <xsl:when test="shan/locationid='WAT_PA'">
                <xsl:text>Thailand, Maehongson (province), Pang Mu (town)</xsl:text>
                </xsl:when>
                <xsl:when test="shan/locationid='WAT_PH'">
                <xsl:text>Thailand, Maehongson (province), Maehongson (town)</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                <xsl:text>Library</xsl:text>
                </xsl:otherwise>
                </xsl:choose>
		</repository>
		<xsl:text>&#xa;</xsl:text>
		<xsl:choose>
		<xsl:when test="shan/loctexttemple">
                <collection>
                	<xsl:choose>
                	<xsl:when test="shan/loctexttemple[contains(text(),',')]">
						<xsl:call-template name="tmpSplitString">
             	<xsl:with-param name="stringtosplit" select="shan/loctexttemple"/>
						</xsl:call-template>
                	</xsl:when>
                	<xsl:otherwise>
                		<xsl:choose>
                			<xsl:when test="string-length(shan/loctexttemple) > 1">
                		<xsl:value-of select="shan/loctexttemple"/>
                			</xsl:when>
                			<xsl:otherwise>
                				<xsl:text>Unknown</xsl:text>
                			</xsl:otherwise>
                		</xsl:choose>
                		</xsl:otherwise>
                	</xsl:choose>
                </collection>
		</xsl:when>
		<xsl:otherwise>
		<collection>Unknown</collection>
		</xsl:otherwise>
		</xsl:choose>
		<xsl:text>&#xa;</xsl:text>
                <idno>
                    <xsl:value-of select="shan/msid"/>
                </idno>
				<xsl:text>&#xa;</xsl:text>
                <altIdentifier type="other">
                    <idno>
                        <xsl:value-of select="shan/msnumber"/>
                    </idno>
                </altIdentifier>
				<xsl:text>&#xa;</xsl:text>
                <altIdentifier type="other">
                	<idno><foreign xml:lang="shn">
                    <xsl:value-of select="shan/msnumbershan"/></foreign>
                        </idno>
                </altIdentifier>
				<xsl:text>&#xa;</xsl:text>
            </msIdentifier>
			<xsl:text>&#xa;</xsl:text>
            <msContents>
                <summary></summary>
				<xsl:text>&#xa;</xsl:text>
                <textLang>
							  <xsl:if test="string-length(shan/script) >1">
									<xsl:text>Written in</xsl:text><xsl:text disable-output-escaping="yes">&#160;</xsl:text> <xsl:value-of select="shan/script"/><xsl:text disable-output-escaping="yes">&#160;</xsl:text><xsl:text>script</xsl:text>
								</xsl:if>
</textLang>
		         <xsl:for-each select="shan/group"><xsl:text>&#xa;</xsl:text>
                <msItem>
                    <xsl:attribute name="n">
                        <xsl:value-of select="wkid"/>
                    </xsl:attribute>
					<xsl:text>&#xa;</xsl:text>
                    <author>
                        <persName xml:lang="shn-Latn-x-lc">
                            <xsl:value-of select="authortranslit"/>
                        </persName>
                    </author>
					<xsl:text>&#xa;</xsl:text>
                    <author>
                        <persName xml:lang="shn-Latn-x-lc">
                        	<foreign xml:lang="shn">
                            <xsl:value-of select="authorshan"/>
                        		</foreign>
                        </persName>
                    </author>
					<xsl:text>&#xa;</xsl:text>
                    <author>
                        <persName xml:lang="shn-Latn-x-lc">
                        	<foreign xml:lang="shn">
                            <xsl:value-of select="altauthor1"/>
                        		</foreign>
                        </persName>
                    </author>
					<xsl:text>&#xa;</xsl:text>
                    <author>
                        <persName xml:lang="shn-Latn-x-lc">
                        	<foreign xml:lang="shn">
                            <xsl:value-of select="altauthor2"/>
                        		</foreign>
                        </persName>
                    </author>
					<xsl:text>&#xa;</xsl:text>
                    <author>
                        <persName xml:lang="shn-Latn-x-lc">
                        	<foreign xml:lang="shn">
                            <xsl:value-of select="altauthor3"/>
                        		</foreign>
                        </persName>
                    </author>
					<xsl:text>&#xa;</xsl:text>
                    <title xml:lang="shn-Latn-x-lc">
                        <xsl:value-of select="titletranslit"/>
                    </title>
					<xsl:text>&#xa;</xsl:text>
                    <title xml:lang="shn-Latn-x-lc">
                        <xsl:value-of select="titletranslat"/>
                    </title>
					<xsl:text>&#xa;</xsl:text>
                    <title xml:lang="shan-Latn-x-lc">                     
                    	<foreign xml:lang="shn">
                        <xsl:value-of select="titleshan"/>
                    		</foreign>
                    </title>
					<xsl:text>&#xa;</xsl:text>
                    <title xml:lang="eng" type="alt">
                        <xsl:value-of select="varianttitle"/>
                    </title>
					<xsl:text>&#xa;</xsl:text>
                    <title xml:lang="shn-Latn-x-lc">
                        <xsl:attribute name="xsi:type" namespace="http://www.w3.org/1999/XMLSchema-instance">
                            <xsl:text>alt</xsl:text>
                        </xsl:attribute>
                    	<foreign xml:lang="shn">
                        <xsl:value-of select="varianttitleshan"/>
                    		</foreign>
                    </title>
					<xsl:text>&#xa;</xsl:text>
                    <decoDesc>
                        <decoNote>
		           		  <xsl:if test="string-length(ornamentation) >1">		
                            <p><xsl:text>Illustrated (ornamentation):</xsl:text> <xsl:text disable-output-escaping="yes">&#160;</xsl:text>
                            <xsl:value-of select="ornamentation"/></p> 
								</xsl:if>
		            			  <xsl:if test="string-length(diagrams) >1"> 	
                            <p><xsl:text> Illustrated (diagrams):</xsl:text><xsl:text disable-output-escaping="yes">&#160;</xsl:text>
                            <xsl:value-of select="diagrams"/></p>
							</xsl:if> 
			    			  <xsl:if test="string-length(pictures) >1">
                              <p><xsl:text>Illustrated (pictures):</xsl:text><xsl:text disable-output-escaping="yes">&#160;</xsl:text>
                            <xsl:value-of select="pictures"/></p>
			    </xsl:if>  
                        </decoNote>
                    </decoDesc>
					<xsl:text>&#xa;</xsl:text>
                    <note>
							<xsl:if test="string-length(textdescriptor) >1">
								<xsl:text>Shan text descriptor:</xsl:text><xsl:text disable-output-escaping="yes">&#160;</xsl:text>
								<xsl:variable name="td" select="textdescriptor"/>
								<xsl:call-template name="tokenize">
								<xsl:with-param name="textdescriptor" select="translate($td,'{}&#34;',' ')"/>
								</xsl:call-template>
								<xsl:text>&#xa;</xsl:text>
						</xsl:if>
							  <xsl:if test="string-length(rhyming) >1">
								<xsl:text>Rhyming system:</xsl:text><xsl:text disable-output-escaping="yes">&#160;</xsl:text>
								<xsl:value-of select="rhyming"/>
								<xsl:text>&#xa;</xsl:text>
						</xsl:if>
						  <xsl:if test="string-length(rhymingshan) >1">
                        <xsl:text>Rhyming system (shan):</xsl:text><xsl:text disable-output-escaping="yes">&#160;</xsl:text>
						  	<foreign xml:lang="shn">
						  	<xsl:value-of select="rhymingshan"/>
						  		</foreign>
							<xsl:variable name="rhymingslangvar" select="rhymingslang"/>
							<xsl:value-of select="translate($rhymingslangvar,'{}&#34;',' ')"/>
							<xsl:text>&#xa;</xsl:text>
					</xsl:if>
					  <xsl:if test="string-length(introduction) >1">
                        <xsl:text>Introduction:</xsl:text><xsl:text disable-output-escaping="yes">&#160;</xsl:text>
							<xsl:value-of select="introduction"/>
							<xsl:text>&#xa;</xsl:text>
					</xsl:if>
						  <xsl:if test="string-length(textotherloc) >1">
                        <xsl:text>Text at other location:</xsl:text><xsl:text disable-output-escaping="yes">&#160;</xsl:text>
							<xsl:value-of select="textotherloc"/>
								 <xsl:text>&#xa;</xsl:text>
					 </xsl:if>
	                 </note>
						  <xsl:if test="string-length(remarks) >1">
                    <note>
							<xsl:text>General remarks on work:</xsl:text><xsl:text disable-output-escaping="yes">&#160;</xsl:text>
							<xsl:value-of select="remarks"/>    
                    </note>
						</xsl:if>
					<xsl:text>&#xa;</xsl:text>
                    <note>
								  <xsl:if test="string-length(summaryintro) >1">
								<xsl:text>Summary intro:</xsl:text> <xsl:text disable-output-escaping="yes">&#160;</xsl:text>
								<xsl:value-of select="summaryintro"/>
							</xsl:if>
                    </note>
					<xsl:text>&#xa;</xsl:text>
                    <note xml:lang="shn">
                       <!--<xsl:attribute name="xml:lang">
						<xsl:variable name="summaryintroslangvar" select="summaryintroslang"/>
							<xsl:value-of select="translate($summaryintroslangvar,'{}&#34;',' ')"/>
                        </xsl:attribute>-->
									  <xsl:if test="string-length(summaryintroshan) >1">
									<xsl:text>Summary (main text) (shan):</xsl:text><xsl:text disable-output-escaping="yes">&#160;</xsl:text>
									  	<foreign xml:lang="shn">
									  	<xsl:value-of select="summaryintroshan"/>
									  		</foreign>
								</xsl:if>
                    </note>
					<xsl:text>&#xa;</xsl:text>
                    <note>
                    <xsl:value-of select="summarymain"/>
                    </note>
					<xsl:text>&#xa;</xsl:text>
                    <note xml:lang="shn">
                    <!--<xsl:attribute name="xml:lang">
					<xsl:variable name="summarymainslangvar" select="summarymainslang"/>
							<xsl:value-of select="translate($summarymainslangvar,'{}&#34;',' ')"/>
                      </xsl:attribute>-->
					  			  <xsl:if test="string-length(summarymainshan) >1">
								<xsl:text>Summary (main text) (shan):</xsl:text><xsl:text disable-output-escaping="yes">&#160;</xsl:text>
					  			  	<foreign xml:lang="shn">
					  			  	<xsl:value-of select="summarymainshan"/> 
					  			  		</foreign>
							</xsl:if>
                    </note>
					<xsl:text>&#xa;</xsl:text>
						  <xsl:if test="string-length(subject) >1">
                    <note>
								<xsl:text>Subject:</xsl:text><xsl:text disable-output-escaping="yes">&#160;</xsl:text>
								<xsl:variable name="subjectvar" select="subject"/>
								<xsl:value-of select="translate($subjectvar,'{}&#34;',' ')"/>
								<xsl:text disable-output-escaping="yes">&#160;</xsl:text>
                    	<xsl:if test="string-length(subjectcomments) >1">
								<xsl:text>Subject comments:</xsl:text><xsl:text disable-output-escaping="yes">&#160;</xsl:text>
								<xsl:value-of select="subjectcomments"/>
                    	</xsl:if>	
						</note>
						</xsl:if>
					<xsl:text>&#xa;</xsl:text>
                    <incipit>
                        <xsl:value-of select="incipit"/> 
                    </incipit>
					<xsl:text>&#xa;</xsl:text>
                    <explicit>
                        <xsl:value-of select="explicit"/> 
                    </explicit>
					<xsl:text>&#xa;</xsl:text>
                    <colophon>
                        <xsl:value-of select="colophontext"/>
							  <xsl:if test="string-length(colophon) >1">
							<xsl:text>Colophon:</xsl:text> <xsl:value-of select="colophon"/><xsl:text disable-output-escaping="yes">&#160;</xsl:text>
						</xsl:if>
							  <xsl:if test="string-length(colophontype) >1">
							<xsl:text>Colophon type:</xsl:text> <xsl:value-of select="colophontype"/><xsl:text disable-output-escaping="yes">&#160;</xsl:text>
						</xsl:if>
							  <xsl:if test="string-length(additionalcolophon) >1">
							<xsl:text>Additional colophon:</xsl:text> <xsl:value-of select="additionalcolophon"/> <xsl:text disable-output-escaping="yes">&#160;</xsl:text>
						</xsl:if>
                    </colophon>
					<xsl:text>&#xa;</xsl:text>
                    <listBibl></listBibl>
					<xsl:text>&#xa;</xsl:text>
                    <textLang mainLang="shn">
					<xsl:variable name="langtextvar" select="langtext"/>
							<xsl:value-of select="translate($langtextvar,'{}&#34;',' ')"/>
                      </textLang>
					<xsl:text>&#xa;</xsl:text>
                    <note>
                    <xsl:text>Work ID:</xsl:text> <xsl:text disable-output-escaping="yes">&#160;</xsl:text>
                    <xsl:value-of select="wkid"/>
                    </note>
					<xsl:text>&#xa;</xsl:text>
                </msItem>
                    </xsl:for-each>
					<xsl:text>&#xa;</xsl:text>
            </msContents>
			<xsl:text>&#xa;</xsl:text>
            <physDesc>
                <objectDesc>
                    <xsl:attribute name="form">
                        <xsl:value-of select="shan/mstype"/>
                    </xsl:attribute> 
                    <supportDesc>
                      <xsl:attribute name="material">
                        <xsl:value-of select="shan/materialms"/>  
                      </xsl:attribute>  
                   <xsl:text>&#xa;</xsl:text>
                    <extent>
					<xsl:call-template name="tmpSplitString">
             	<xsl:with-param name="stringtosplit" select="shan/numberpages"/>
        	</xsl:call-template>
							  <xsl:if test="string-length(shan/numbering) >1">
                        <xsl:text>pp/ff (</xsl:text><xsl:value-of select="shan/numbering"/><xsl:text> numbering)</xsl:text>
						     <xsl:text>&#xa;</xsl:text>
						 </xsl:if>
                    <dimensions type="written" unit="cm">
                     <height>
                     <xsl:value-of select="shan/length"/>    
                     </height>
                     <width>
                     <xsl:value-of select="shan/width"/>    
                     </width>
                     <depth>
                     <xsl:value-of select="shan/depth"/>    
                     </depth>   
                    </dimensions>
					 <xsl:text>&#xa;</xsl:text>
                    <foliation>
						  <xsl:if test="string-length(shan/lines) >1">
                    <p><xsl:text>Lines (per folio:)</xsl:text><xsl:text disable-output-escaping="yes">&#160;</xsl:text>
						<xsl:call-template name="tmpSplitString">
						<xsl:with-param name="stringtosplit" select="shan/lines"/>
					   </xsl:call-template>
                    </p>
					</xsl:if>
                    </foliation>
					 <xsl:text>&#xa;</xsl:text>
                    <condition>
                    <p><xsl:value-of select="shan/condition"/></p>
                    <p><xsl:value-of select="shan/damage"/></p>
                    <p><xsl:value-of select="shan/appearancecomments"/></p>    
                    </condition>   
					 <xsl:text>&#xa;</xsl:text>
                    </extent>
					                </supportDesc>        
                </objectDesc>
				 <xsl:text>&#xa;</xsl:text>
              <handDesc>
                <handNote scope="major">  
                  <xsl:attribute name="medium">
                      <xsl:value-of select="shan/appearancewriting"/>  
                  </xsl:attribute>  
                  <desc>
							  <xsl:if test="string-length(shan/appearancepaper) >1">
							<xsl:text>Appearance (paper):</xsl:text><xsl:text disable-output-escaping="yes">&#160;</xsl:text>
							<xsl:value-of select="shan/appearancepaper"/>
						</xsl:if>
                  </desc>
                  </handNote>
              </handDesc>
			   <xsl:text>&#xa;</xsl:text>
                <bindingDesc>
                <p>
					  <xsl:if test="string-length(shan/covers) >1">
					<xsl:text>Covers:</xsl:text><xsl:text disable-output-escaping="yes">&#160;</xsl:text>
					<xsl:value-of select="shan/covers"/>
					<xsl:text>&#xa;</xsl:text>
				 </xsl:if>
				 	  <xsl:if test="string-length(shan/covercol) >1">
                <xsl:text>Cover colour:</xsl:text><xsl:text disable-output-escaping="yes">&#160;</xsl:text>
                <xsl:value-of select="shan/covercol"/>
				 <xsl:text>&#xa;</xsl:text>
				 </xsl:if>
				 	  <xsl:if test="string-length(shan/covermat) >1">
						<xsl:text>Cover material:</xsl:text><xsl:text disable-output-escaping="yes">&#160;</xsl:text>
						<xsl:text>&#xa;</xsl:text>
						<material>
						<xsl:value-of select="shan/covermat"/>    
						</material>
						<xsl:text>&#xa;</xsl:text>
					</xsl:if>
                </p>
                <decoNote>
					  <xsl:if test="string-length(shan/coveremb) >1">
						<xsl:text>Cover embellishment:</xsl:text><xsl:text disable-output-escaping="yes">&#160;</xsl:text>
						<xsl:value-of select="shan/coveremb"/>
				</xsl:if>
                </decoNote>
				 <xsl:text>&#xa;</xsl:text>
                <condition>
                <xsl:value-of select="shan/group/complete"/>    
                </condition>   
				 <xsl:text>&#xa;</xsl:text>
                </bindingDesc>
            </physDesc>
			 <xsl:text>&#xa;</xsl:text>
            <history>    
             <origin>
                 <p>
              <xsl:value-of select="shan/historycomments"/>    
                 </p>
				  <xsl:text>&#xa;</xsl:text>
             <date calendar="Gregorian" when="seecommentbelow"></date> 
			  <xsl:text>&#xa;</xsl:text>
             <p>
			  <xsl:if test="string-length(shan/datecompera) >1">
				<xsl:text>Date of composition (era):</xsl:text><xsl:text disable-output-escaping="yes">&#160;</xsl:text>
				<xsl:call-template name="tmpSplitString">
             <xsl:with-param name="stringtosplit" select="shan/datecompera"/>
				</xsl:call-template>
				<xsl:text>&#xa;</xsl:text>
			</xsl:if>
             </p>
             <p>
		  <xsl:if test="string-length(shan/datecompyear) >1">
					<xsl:text>Date of composition (year):</xsl:text><xsl:text disable-output-escaping="yes">&#160;</xsl:text>
					<xsl:call-template name="tmpSplitString">
             	<xsl:with-param name="stringtosplit" select="shan/datecompyear"/>
					</xsl:call-template>
					</xsl:if>
						  <xsl:text>&#xa;</xsl:text>
             </p>
		         <p>
				  <xsl:if test="string-length(shan/datecopyingera) >1">
				 <xsl:text>Date of copying (era):</xsl:text><xsl:text disable-output-escaping="yes">&#160;</xsl:text>
				  <xsl:call-template name="tmpSplitString">
              <xsl:with-param name="stringtosplit" select="shan/datecopyingera"/>
				</xsl:call-template>
				<xsl:text>&#xa;</xsl:text>
			</xsl:if>
             </p>
             <p>
			 		  <xsl:if test="string-length(shan/datecopyingyear) >1">
					<xsl:text>Date of copying (year):</xsl:text><xsl:text disable-output-escaping="yes">&#160;</xsl:text>
					<xsl:call-template name="tmpSplitString">
             	<xsl:with-param name="stringtosplit" select="shan/datecopyingyear"/>
					</xsl:call-template>
			   </xsl:if>
			   <xsl:text>&#xa;</xsl:text>
             </p>    
             </origin>  
			  <xsl:text>&#xa;</xsl:text>
             <provenance>
					  <xsl:if test="string-length(shan/formerowner) >1">
						<xsl:text>Former owner:</xsl:text><xsl:text disable-output-escaping="yes">&#160;</xsl:text>
						<xsl:value-of select="shan/formerowner"/>
			      </xsl:if>
             </provenance>   
			  <xsl:text>&#xa;</xsl:text>
             <provenance>
				  <xsl:if test="string-length(shan/formerownerslang) >1">
					<xsl:text>Former owner (shan):</xsl:text><xsl:text disable-output-escaping="yes">&#160;</xsl:text>
				  	<foreign xml:lang="shn">
				  	<xsl:value-of select="shan/formerownershan"/>
				  		</foreign>
					<xsl:variable name="shanformerownerslangvar" select="shan/formerownerslang"/>
					<xsl:value-of select="translate($shanformerownerslangvar,'{}&#34;',' ')"/>
				</xsl:if>
						    <xsl:text>&#xa;</xsl:text>
               </provenance>
             <acquisition>
			  <xsl:text>&#xa;</xsl:text>
			   <p>
			  <xsl:if test="string-length(shan/odonor) >1">
               <xsl:text>Original donor:</xsl:text><xsl:text disable-output-escaping="yes">&#160;</xsl:text>
               <xsl:variable name="shanoriginaldonorvar" select="shan/odonor"/>
			     <xsl:call-template name="tmpSplitString">
               <xsl:with-param name="stringtosplit" select="translate($shanoriginaldonorvar,'{}&#34;',' ')"/>
        	     </xsl:call-template>							
			     <xsl:text>&#xa;</xsl:text>
			  </xsl:if>
			   	  <xsl:if test="string-length(shan/odonors) >1">
					<xsl:text>Original donor (shan):</xsl:text><xsl:text disable-output-escaping="yes">&#160;</xsl:text>
			   	  	<xsl:variable name="shanoriginaldonorvarshan" select="shan/odonors"/>
					<xsl:call-template name="tmpSplitString">
						<xsl:with-param name="stringtosplit" select="translate($shanoriginaldonorvarshan,'{}&#34;',' ')"/>
					<xsl:with-param name="shanelement" select="'shandefault'"/>
					</xsl:call-template>
			   	  	<xsl:variable name="shanoriginaldonorvarshanlang" select="shan/odonorslang"/>
			   	  	<xsl:call-template name="tmpSplitString">
			  			<xsl:with-param name="stringtosplit" select="translate($shanoriginaldonorvarshanlang,'{}&#34;',' ')"/>
					</xsl:call-template>	
					<xsl:text>&#xa;</xsl:text>
				</xsl:if>
					  <xsl:if test="string-length(shan/odonoric) >1">
					<xsl:text>Original donor information:</xsl:text><xsl:text disable-output-escaping="yes">&#160;</xsl:text>
					  	<xsl:variable name="shanoriginaldonorinfo" select="shan/odonoric"/>
					<xsl:call-template name="tmpSplitString">
						<xsl:with-param name="stringtosplit" select="translate($shanoriginaldonorinfo,'{}&#34;',' ')"/>
					</xsl:call-template>
				</xsl:if>
				<xsl:text>&#xa;</xsl:text>
             </p>
			  <p>
				  <xsl:if test="string-length(shan/odonationplace) >1">
					<xsl:text>Original place of donation:</xsl:text><xsl:text disable-output-escaping="yes">&#160;</xsl:text>
				  	<xsl:variable name="shanoriginaldonationplace" select="shan/odonationplace"/>
					<xsl:call-template name="tmpSplitString">
						<xsl:with-param name="stringtosplit" select="translate($shanoriginaldonationplace,'{}&#34;',' ')"/>
					</xsl:call-template>	
					<xsl:text>&#xa;</xsl:text>
			   </xsl:if>
			  	  <xsl:if test="string-length(shan/odonationplaces) >1">
					<xsl:text>Original place of donation (shan):</xsl:text><xsl:text disable-output-escaping="yes">&#160;</xsl:text>
			  	  	<xsl:variable name="shanoriginaldonationplaces" select="shan/odonationplaces"/>
					<xsl:call-template name="tmpSplitString">
						<xsl:with-param name="stringtosplit" select="translate($shanoriginaldonationplaces,'{}&#34;',' ')"/>
						<xsl:with-param name="shanelement" select="'shandefault'"/>
					</xsl:call-template>	
					<xsl:call-template name="tmpSplitString">
             	<xsl:with-param name="stringtosplit" select="shan/odonationplaceslang"/>
					</xsl:call-template>	
					<xsl:text>&#xa;</xsl:text>
			  </xsl:if>
			 	  <xsl:if test="string-length(shan/odonationplaceic) >1">
					<xsl:text>Original donor place information:</xsl:text><xsl:text disable-output-escaping="yes">&#160;</xsl:text>
			 	  	<xsl:variable name="shanoriginaldonationplaceic" select="shan/odonationplaceic"/>
					<xsl:call-template name="tmpSplitString">
						<xsl:with-param name="stringtosplit" select="translate($shanoriginaldonationplaceic,'{}&#34;',' ')"/>
					</xsl:call-template>	
					<xsl:text>&#xa;</xsl:text>
				</xsl:if>
             </p>
             <p>
			 	  <xsl:if test="string-length(shan/pcopydonor) >1">
					<xsl:text>Present copy's donor:</xsl:text><xsl:text disable-output-escaping="yes">&#160;</xsl:text>
					<xsl:value-of select="shan/pcopydonor"/>
					<xsl:text>&#xa;</xsl:text>
				</xsl:if>
					  <xsl:if test="string-length(shan/pcopydonorshan) >1">
					<xsl:text>Present copy's donor (shan):</xsl:text><xsl:text disable-output-escaping="yes">&#160;</xsl:text>
					  	<foreign xml:lang="shn">
					<xsl:value-of select="shan/pcopydonorshan"/>
					  		</foreign>
					<xsl:value-of select="shan/pcopydonorslang"/>
					<xsl:text>&#xa;</xsl:text>
				</xsl:if>
					  <xsl:if test="string-length(shan/pcopyic) >1">
					<xsl:text>Present copy information:</xsl:text><xsl:text disable-output-escaping="yes">&#160;</xsl:text>
					<xsl:value-of select="shan/pcopyic"/>
					<xsl:text>&#xa;</xsl:text>
				</xsl:if>
             </p>
             <p>
			 	  <xsl:if test="string-length(shan/placepcopy) >1">
					<xsl:text>Place name for present copy:</xsl:text><xsl:text disable-output-escaping="yes">&#160;</xsl:text>
					<xsl:value-of select="shan/placepcopy"/>
					<xsl:text>&#xa;</xsl:text>
				</xsl:if>
				  <xsl:if test="string-length(shan/placepcopyshan) >1">
					<xsl:text>Place name for present copy (shan):</xsl:text><xsl:text disable-output-escaping="yes">&#160;</xsl:text>
				  	<foreign xml:lang="shn">
				  	<xsl:value-of select="shan/placepcopyshan"/>
				  		</foreign>
					<xsl:text>&#xa;</xsl:text>
				</xsl:if>
					  <xsl:if test="string-length(shan/placepcopyic) >1">
					<xsl:text>Place name information:</xsl:text><xsl:text disable-output-escaping="yes">&#160;</xsl:text>
					<xsl:value-of select="shan/placepcopyic"/>
					<xsl:text>&#xa;</xsl:text>
				</xsl:if>
             </p>    
             </acquisition>   
            </history>
        </msDesc>
    </sourceDesc>
</fileDesc>                    
</teiHeader>    
</TEI>    
</xsl:template>

<xsl:template name="tmpSplitString">
    <xsl:param name="stringtosplit"/>
	<xsl:param name="shanelement"/>
	<xsl:variable name="originalvalue" select="$stringtosplit"/>
    <xsl:variable name="first" select="substring-before($stringtosplit, ',')" />
	<xsl:variable name="shanmarker" select="$shanelement"/>
	<xsl:choose>
		<xsl:when test="contains($originalvalue, ',')">
			<xsl:choose>
			<xsl:when test="string-length($first) > 1">
		    <xsl:value-of select="$first"/>
			</xsl:when>
			<xsl:otherwise>
			<xsl:text>Unknown </xsl:text>	
			</xsl:otherwise>	
			</xsl:choose>
		</xsl:when>
		<xsl:otherwise>
			<xsl:choose>
			<xsl:when test="$shanmarker = 'shandefault'">
			<foreign xml:lang="shn">
			<xsl:value-of select="$originalvalue"/>
			</foreign>
			</xsl:when>
			<xsl:otherwise>
			<xsl:value-of select="$originalvalue"/>
			</xsl:otherwise>
			</xsl:choose>
		</xsl:otherwise>
	</xsl:choose>
  </xsl:template>
  
  <xsl:template name="tokenize">
        <xsl:param name="textdescriptor"/>
    	     <xsl:param name="separator" select="','"/>
        <xsl:choose>
            <xsl:when test="not(contains($textdescriptor, $separator))">
               <xsl:variable name="tdvalue"><xsl:value-of select="normalize-space($textdescriptor)"/></xsl:variable>
			   <xsl:choose>
			   <xsl:when test="$tdvalue='2'">
				<xsl:text>Alaung </xsl:text> <xsl:text disable-output-escaping="yes">&#160;</xsl:text>
				</xsl:when>
				 <xsl:when test="$tdvalue='3'">
				<xsl:text>Lik </xsl:text> <xsl:text disable-output-escaping="yes">&#160;</xsl:text>
				</xsl:when>
				 <xsl:when test="$tdvalue='4'"><xsl:text disable-output-escaping="yes">&#160;</xsl:text>
				<xsl:text>Nang </xsl:text> 
				</xsl:when>
				 <xsl:when test="$tdvalue='5'"><xsl:text disable-output-escaping="yes">&#160;</xsl:text>
				<xsl:text>Kyam </xsl:text> 
				</xsl:when>
				 <xsl:when test="$tdvalue='6'"><xsl:text disable-output-escaping="yes">&#160;</xsl:text>
				<xsl:text>Phuen Lik </xsl:text> 
				</xsl:when>
				<xsl:when test="$tdvalue='7'"><xsl:text disable-output-escaping="yes">&#160;</xsl:text>
				<xsl:text>Zao </xsl:text> 
				</xsl:when>
					<xsl:when test="$tdvalue='15'"><xsl:text disable-output-escaping="yes">&#160;</xsl:text>
				<xsl:text>tra </xsl:text> 
				</xsl:when>
					<xsl:when test="$tdvalue='18'"><xsl:text disable-output-escaping="yes">&#160;</xsl:text>
				<xsl:text>Vatthu </xsl:text> 
				</xsl:when>
				<xsl:otherwise>
				<xsl:text>Not specified </xsl:text><xsl:text disable-output-escaping="yes">&#160;</xsl:text>
				</xsl:otherwise>
		</xsl:choose>
                    </xsl:when>
            <xsl:otherwise>
			 <xsl:variable name="tdvalue"><xsl:value-of select="normalize-space(substring-before($textdescriptor, $separator))"/></xsl:variable>
			 <xsl:choose>
			   <xsl:when test="$tdvalue='2'">
				<xsl:text>Alaung</xsl:text> <xsl:text disable-output-escaping="yes">&#160;</xsl:text>
				</xsl:when>
				 <xsl:when test="$tdvalue='3'">
				<xsl:text>Lik</xsl:text> <xsl:text disable-output-escaping="yes">&#160;</xsl:text>
				</xsl:when>
				 <xsl:when test="$tdvalue='4'">
				<xsl:text>Nang</xsl:text> <xsl:text disable-output-escaping="yes">&#160;</xsl:text>
				</xsl:when>
				 <xsl:when test="$tdvalue='5'"><xsl:text disable-output-escaping="yes">&#160;</xsl:text>
				<xsl:text>Kyam</xsl:text> 
				</xsl:when>
				 <xsl:when test="$tdvalue='6'"><xsl:text disable-output-escaping="yes">&#160;</xsl:text>
				<xsl:text>Phuen Lik</xsl:text> 
				</xsl:when>
				<xsl:when test="$tdvalue='7'"><xsl:text disable-output-escaping="yes">&#160;</xsl:text>
				<xsl:text>Zao</xsl:text> 
				</xsl:when>
					<xsl:when test="$tdvalue='15'"><xsl:text disable-output-escaping="yes">&#160;</xsl:text>
				<xsl:text>tra</xsl:text> 
				</xsl:when>
					<xsl:when test="$tdvalue='18'"><xsl:text disable-output-escaping="yes">&#160;</xsl:text>
				<xsl:text>Vatthu</xsl:text> 
				</xsl:when>
				<xsl:otherwise>
				<xsl:text>Not specified</xsl:text><xsl:text disable-output-escaping="yes">&#160;</xsl:text>
				</xsl:otherwise>
		</xsl:choose>
                    <!--<xsl:value-of select="normalize-space(substring-before($textdescriptor, $separator))"/>-->
                <xsl:call-template name="tokenize">
                    <xsl:with-param name="textdescriptor" select="substring-after($textdescriptor, $separator)"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

	
</xsl:stylesheet>
