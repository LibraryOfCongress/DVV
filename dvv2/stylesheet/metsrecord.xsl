<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:mix="http://www.loc.gov/mix/" xmlns:ndnp="http://www.loc.gov/ndnp" xmlns:premis="http://www.loc.gov/standards/premis" xmlns:mods="http://www.loc.gov/mods/v3" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:dsig="http://www.w3.org/2000/09/xmldsig#" xmlns:mets="http://www.loc.gov/METS/" xmlns:java="http://xml.apache.org/xalan/java" exclude-result-prefixes="java" version="1.0">
    <xsl:output method="xml" indent="yes" />
    <xsl:param name="id" />
    <xsl:param name="addSignature" />
    <xsl:param name="mixElement" />
    <xsl:param name="mixId" />  
    <xsl:param name="premisElement" />
    <xsl:param name="objid" />
    <xsl:param name="setCreateDate" />
    <xsl:param name="marcXmlBibFile" />
    <xsl:param name="modsBibFile" />
    <xsl:param name="marcXmlHoldingFile" />
    <xsl:param name="marcXmlHoldingId" />
    <xsl:param name="parentFilename" />
    
    <xsl:template match="mets:mdRef">
        <xsl:choose>
            <xsl:when test="boolean($parentFilename)">
                <xsl:element namespace="http://www.loc.gov/METS/" name="mdWrap">
                    <xsl:attribute name="MDTYPE"><xsl:value-of select="@MDTYPE" /></xsl:attribute>
                    <xsl:attribute name="LABEL"><xsl:value-of select="@LABEL" /></xsl:attribute>
                    <xsl:element namespace="http://www.loc.gov/METS/" name="xmlData">
                        <xsl:copy-of select="document(java:gov.loc.ndnp.preingest.utilities.RelativeFileHelper.resolve($parentFilename, @xlink:href))" />
                    </xsl:element>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:apply-templates select="@*|node()|mix:*|ndnp:*|premis:*|mods:*|xlink:*|dsig:*"/>
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="mets:dmdSec[position()=last()]">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()|mix:*|ndnp:*|premis:*|mods:*|xlink:*|dsig:*"/>
        </xsl:copy>
        <xsl:if test="not(following-sibling::mets:amdSec)">
                <xsl:call-template name="amdSec" />                
        </xsl:if>
    </xsl:template>

    <xsl:template name="amdSec" match="mets:amdSec">    
        <xsl:if test="boolean($marcXmlBibFile)">
            <xsl:call-template name="marcXmlBib" />
        </xsl:if>
        <xsl:if test="boolean($modsBibFile)">
            <xsl:call-template name="modsBib" />
        </xsl:if>        
        <xsl:element namespace="http://www.loc.gov/METS/" name="amdSec">
            <xsl:for-each select="mets:techMD">
                <xsl:copy>
                    <xsl:apply-templates select="@*|node()|mix:*|ndnp:*|premis:*|mods:*|xlink:*|dsig:*"/>
                </xsl:copy>                            
            </xsl:for-each>
            <xsl:if test="boolean($mixElement)">
                <xsl:call-template name="mixTechMD" />
            </xsl:if>
            <xsl:if test="boolean($premisElement)">
                <xsl:call-template name="premisTechMD" />
            </xsl:if>                        
            <xsl:for-each select="mets:sourceMD">
                <!--xsl:copy>
                    <xsl:apply-templates select="@*|node()|mix:*|ndnp:*|premis:*|mods:*|xlink:*|dsig:*"/>
                </xsl:copy>-->                                        
                <xsl:apply-templates select="."/>
            </xsl:for-each>
            <xsl:if test="boolean($marcXmlHoldingFile)">
                <xsl:call-template name="marcXmlHolding" />
            </xsl:if>
            <xsl:for-each select="mets:digiprovMD">
                <xsl:copy>
                    <xsl:apply-templates select="@*|node()|mix:*|ndnp:*|premis:*|mods:*|xlink:*|dsig:*"/>
                </xsl:copy>                                        
            </xsl:for-each>
            <xsl:if test="boolean($addSignature)">
                <xsl:call-template name="signatureDigiProvMD" />
            </xsl:if>            
        </xsl:element>    
    </xsl:template>    

    <xsl:template name="marcXmlBib">
        <xsl:element namespace="http://www.loc.gov/METS/" name="dmdSec">
            <xsl:attribute name="ID"><xsl:call-template name="admidId" /></xsl:attribute>
            <xsl:element namespace="http://www.loc.gov/METS/" name="mdRef">
                <xsl:attribute name="MDTYPE">MARC</xsl:attribute>
                <xsl:attribute name="LABEL">MarcXml bibliographic record</xsl:attribute>
                <xsl:attribute name="LOCTYPE">OTHER</xsl:attribute>
                <xsl:attribute name="OTHERLOCTYPE">file</xsl:attribute>
                <xsl:attribute name="xlink:href"><xsl:value-of select="$marcXmlBibFile" /></xsl:attribute>
            </xsl:element>
        </xsl:element>        
    </xsl:template>
    
    <xsl:template name="modsBib">
        <xsl:element namespace="http://www.loc.gov/METS/" name="dmdSec">
            <xsl:attribute name="ID"><xsl:call-template name="admidId" /></xsl:attribute>
            <xsl:element namespace="http://www.loc.gov/METS/" name="mdRef">
                <xsl:attribute name="MDTYPE">MODS</xsl:attribute>
                <xsl:attribute name="LABEL">NDNP title metadata</xsl:attribute>
                <xsl:attribute name="LOCTYPE">OTHER</xsl:attribute>
                <xsl:attribute name="OTHERLOCTYPE">file</xsl:attribute>
                <xsl:attribute name="xlink:href"><xsl:value-of select="$modsBibFile" /></xsl:attribute>
            </xsl:element>
        </xsl:element>        
    </xsl:template>

    <xsl:template name="marcXmlHolding">
        <xsl:element namespace="http://www.loc.gov/METS/" name="sourceMD">
            <xsl:attribute name="ID"><xsl:value-of select="$marcXmlHoldingId" /></xsl:attribute>
            <xsl:element namespace="http://www.loc.gov/METS/" name="mdRef">
                <xsl:attribute name="MDTYPE">MARC</xsl:attribute>
                <xsl:attribute name="LABEL">MarcXml holding record</xsl:attribute>
                <xsl:attribute name="LOCTYPE">OTHER</xsl:attribute>
                <xsl:attribute name="OTHERLOCTYPE">file</xsl:attribute>
                <xsl:attribute name="xlink:href"><xsl:value-of select="$marcXmlHoldingFile" /></xsl:attribute>
            </xsl:element>
        </xsl:element>        
    </xsl:template>
    
    
    <xsl:template name="mixTechMD">
        <xsl:element namespace="http://www.loc.gov/METS/" name="techMD">
            <xsl:attribute name="ID"><xsl:call-template name="admidId" /></xsl:attribute>
            <xsl:element namespace="http://www.loc.gov/METS/" name="mdWrap">
                <xsl:attribute name="MDTYPE">NISOIMG</xsl:attribute>
                <xsl:attribute name="LABEL">NISO still image metadata</xsl:attribute>
                <xsl:element namespace="http://www.loc.gov/METS/" name="xmlData">                    
                    <xsl:copy-of select="$mixElement" />
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>    
    
    <xsl:template name="signatureDigiProvMD">
    <xsl:element namespace="http://www.loc.gov/METS/" name="digiprovMD">
            <xsl:attribute name="ID"><xsl:call-template name="admidId" /></xsl:attribute>
            <xsl:element namespace="http://www.loc.gov/METS/" name="mdWrap">
                <xsl:attribute name="MDTYPE">OTHER</xsl:attribute>
                <xsl:attribute name="OTHERMDTYPE">XML-Signature</xsl:attribute>
                <xsl:attribute name="LABEL">Mets record validation signature</xsl:attribute>
                <xsl:element namespace="http://www.loc.gov/METS/" name="xmlData" />                    
            </xsl:element>
        </xsl:element>        
    </xsl:template>
    
    <xsl:template name="premisTechMD">
        <xsl:element namespace="http://www.loc.gov/METS/" name="techMD">
            <xsl:attribute name="ID"><xsl:call-template name="admidId" /></xsl:attribute>
            <xsl:element namespace="http://www.loc.gov/METS/" name="mdWrap">
                <xsl:attribute name="MDTYPE">OTHER</xsl:attribute>
                <xsl:attribute name="OTHERMDTYPE">PREMIS</xsl:attribute>
                <xsl:attribute name="LABEL">PREMIS object metadata</xsl:attribute>
                <xsl:element namespace="http://www.loc.gov/METS/" name="xmlData">                    
                    <xsl:copy-of select="$premisElement" />
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>        
            
    <xsl:template match="mets:file[@ID=$id]/@ADMID">
        <xsl:attribute name="ADMID"><xsl:value-of select="." /><xsl:text> </xsl:text><xsl:call-template name="admidId" /></xsl:attribute>
        <xsl:apply-templates select="@*|node()|mix:*|ndnp:*|premis:*|mods:*|xlink:*|dsig:*"/>
    </xsl:template>
    
    <xsl:template match="mets:file[@ID=$id and not(@ADMID)]">
        <xsl:copy>
            <xsl:attribute name="ADMID"><xsl:call-template name="admidId" /></xsl:attribute>
            <xsl:apply-templates select="@*|node()|mix:*|ndnp:*|premis:*|mods:*|xlink:*|dsig:*"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="mets:dmdSec[@ID=$id]/@ADMID">
        <xsl:attribute name="ADMID"><xsl:value-of select="." /><xsl:text> </xsl:text><xsl:call-template name="admidId" /></xsl:attribute>
        <xsl:apply-templates select="@*|node()|mix:*|ndnp:*|premis:*|mods:*|xlink:*|dsig:*"/>
    </xsl:template>
    
    <xsl:template match="mets:dmdSec[@ID=$id and not(@ADMID)]">
        <xsl:copy>
            <xsl:attribute name="ADMID"><xsl:call-template name="admidId" /></xsl:attribute>
            <xsl:apply-templates select="@*|node()|mix:*|ndnp:*|premis:*|mods:*|xlink:*|dsig:*"/>
        </xsl:copy>
    </xsl:template>    

    <xsl:template match="mets:sourceMD[@ID=$id]/@ADMID">
        <xsl:attribute name="ADMID"><xsl:value-of select="." /><xsl:text> </xsl:text><xsl:call-template name="admidId" /></xsl:attribute>
        <xsl:apply-templates select="@*|node()|mix:*|ndnp:*|premis:*|mods:*|xlink:*|dsig:*"/>
    </xsl:template>
    
    <xsl:template match="mets:sourceMD[@ID=$id and not(@ADMID)]">
        <xsl:copy>
            <xsl:attribute name="ADMID"><xsl:call-template name="admidId" /></xsl:attribute>
            <xsl:apply-templates select="@*|node()|mix:*|ndnp:*|premis:*|mods:*|xlink:*|dsig:*"/>
        </xsl:copy>
    </xsl:template>    
        
    <xsl:template match="mets:metsHdr/@ADMID">    
        <xsl:choose>
            <xsl:when test="boolean($addSignature) or (boolean($premisElement) and not($id))">        
                <xsl:attribute name="ADMID"><xsl:value-of select="." /><xsl:text> </xsl:text><xsl:call-template name="admidId" /></xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
                <xsl:attribute name="ADMID"><xsl:value-of select="." /></xsl:attribute>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:apply-templates select="@*|node()|mix:*|ndnp:*|premis:*|mods:*|xlink:*|dsig:*"/>
    </xsl:template>

    <xsl:template match="mets:mets">
        <xsl:copy>
            <xsl:if test="boolean($objid)">
                <xsl:attribute name="OBJID"><xsl:value-of select="$objid" /></xsl:attribute>
            </xsl:if>
            <xsl:apply-templates select="@*|node()|mix:*|ndnp:*|premis:*|mods:*|xlink:*|dsig:*"/>
        </xsl:copy>
    </xsl:template>
        
    <xsl:template match="mets:metsHdr">
        <xsl:copy>
            <xsl:if test="boolean($setCreateDate)">
                <xsl:attribute name="CREATEDATE">
                    <xsl:value-of select="java:gov.loc.ndnp.preingest.utilities.DateFormatter.format()" />
                </xsl:attribute>                
            </xsl:if>
            <xsl:if test="not(@ADMID) and (boolean($addSignature) or (boolean($premisElement) and not($id)))">
                <xsl:attribute name="ADMID"><xsl:call-template name="admidId" /></xsl:attribute>
            </xsl:if>            
            <xsl:apply-templates select="@*|node()|mix:*|ndnp:*|premis:*|mods:*|xlink:*|dsig:*"/>
        </xsl:copy>        
    </xsl:template>        

    <xsl:template match="mets:div[@TYPE='np:newspaperTitle']/@DMDID">
        <xsl:choose>
            <xsl:when test="boolean($marcXmlBibFile) or boolean($modsBibFile)">
                <xsl:attribute name="DMDID"><xsl:value-of select="." /><xsl:text> </xsl:text><xsl:call-template name="admidId" /></xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
                <xsl:attribute name="DMDID"><xsl:value-of select="." /></xsl:attribute>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
                
    <xsl:template match="mets:div[@TYPE='np:newspaperTitle' and not(@DMDID)]">
        <xsl:copy>
            <xsl:attribute name="DMDID"><xsl:call-template name="admidId" /></xsl:attribute>
            <xsl:apply-templates select="@*|node()|mix:*|ndnp:*|premis:*|mods:*|xlink:*|dsig:*"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="mets:div[@TYPE='np:newspaperTitle']/@ADMID">
        <xsl:choose>
            <xsl:when test="boolean($marcXmlHoldingFile)">
                <xsl:attribute name="ADMID"><xsl:value-of select="." /><xsl:text> </xsl:text><xsl:value-of select="$marcXmlHoldingId" /></xsl:attribute>
            </xsl:when>
            <xsl:when test="string-length(.) > 0">
                <xsl:attribute name="ADMID"><xsl:value-of select="." /></xsl:attribute>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
                
    <xsl:template match="mets:div[@TYPE='np:newspaperTitle' and not(@ADMID)]">
        <xsl:copy>
            <xsl:attribute name="ADMID"><xsl:value-of select="$marcXmlHoldingId" /></xsl:attribute>
            <xsl:apply-templates select="@*|node()|mix:*|ndnp:*|premis:*|mods:*|xlink:*|dsig:*"/>
        </xsl:copy>
    </xsl:template>    
    
    <xsl:template name="admidId">
        <xsl:choose>
            <xsl:when test="boolean($marcXmlBibFile)">
                <xsl:text>marcXmlBib</xsl:text><xsl:value-of select="$id" />
            </xsl:when>
            <xsl:when test="boolean($modsBibFile)">
                <xsl:text>modsBib</xsl:text><xsl:value-of select="$id" />
            </xsl:when>            
            <xsl:when test="boolean($addSignature)">
                <xsl:text>digSig</xsl:text><xsl:value-of select="$id" />
            </xsl:when>
            <xsl:when test="boolean($mixElement)">
                <xsl:text>mix</xsl:text><xsl:value-of select="$id" />
            </xsl:when>
            <xsl:when test="boolean($premisElement) and boolean($id)">
                <xsl:text>premis</xsl:text><xsl:value-of select="$id" />
            </xsl:when>                                                            
            <xsl:when test="boolean($premisElement) and not($id)">
                <xsl:text>metspremis</xsl:text>
            </xsl:when>                                                                        
            <xsl:when test="boolean($mixId)">
                <xsl:value-of select="$mixId" />
            </xsl:when>
        </xsl:choose>
        
    </xsl:template>
                            
    <xsl:template match="@*|node()|mix:*|ndnp:*|premis:*|mods:*|xlink:*|dsig:*">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()|mix:*|ndnp:*|premis:*|mods:*|xlink:*|dsig:*"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>
