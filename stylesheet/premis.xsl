<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:premis="http://www.loc.gov/standards/premis" xmlns:mix="http://www.loc.gov/mix/" xmlns:java="http://xml.apache.org/xalan/java" xmlns:ndnp="http://www.loc.gov/ndnp" exclude-result-prefixes="java" version="1.0">
    <xsl:output method="xml" indent="yes" />
    
    <xsl:template match="/">
        <xsl:element name="premis:object">
            <xsl:element name="premis:objectCharacteristics">
                <xsl:if test="string(//format) != 'Issue' and string(//format) != 'Reel'">
                    <xsl:element name="premis:fixity">
                        <xsl:element name="premis:messageDigestAlgorithm"><xsl:text>SHA-1</xsl:text></xsl:element>
                        <xsl:element name="premis:messageDigest"><xsl:value-of select="string(//checksum[@type='SHA-1'])" /></xsl:element>                    
                        <xsl:element name="premis:messageDigestOriginator"><xsl:text>Library of Congress</xsl:text></xsl:element>                    
                    </xsl:element>
                    <xsl:element name="premis:size"><xsl:value-of select="//size" /></xsl:element>
                    <xsl:element name="premis:format">
                        <xsl:element name="premis:formatDesignation">
                            <xsl:element name="premis:formatName"><xsl:value-of select="//mimeType" /></xsl:element>
                        </xsl:element>
                    </xsl:element>
                </xsl:if>
                <xsl:if test="boolean(//property[child::name/text() = 'Code'])">
                    <xsl:element name="premis:significantProperties">
                        <xsl:element name="ndnp:exemptionSet">
                            <xsl:for-each select="//property[child::name/text() = 'Code']/values/value">
                                <xsl:element name="ndnp:code"><xsl:value-of select="string(.)" /></xsl:element>
                            </xsl:for-each>
                        </xsl:element>
                    </xsl:element>
                </xsl:if>
            </xsl:element>
            <xsl:if test="string(//format) != 'Issue' and string(//format) != 'Reel'">
                <xsl:element name="premis:creatingApplication">                
                    <xsl:choose>
                        <xsl:when test="boolean(//mix:ScanningSoftware)">                    
                            <xsl:element name="premis:creatingApplicationName"><xsl:value-of select="//mix:ScanningSoftware" /></xsl:element>
                        </xsl:when>
                        <xsl:when test="//property/name/text() = 'Creator'">
                            <xsl:element name="premis:creatingApplicationName"><xsl:value-of select="//property[child::name/text() = 'Creator']/values/value" /></xsl:element>
                        </xsl:when>
                    </xsl:choose>
                    <xsl:choose>
                        <xsl:when test="boolean(//mix:DateTimeCreated)">
                            <xsl:element name="premis:dateCreatedByApplication"><xsl:value-of select="//mix:DateTimeCreated" /></xsl:element>
                        </xsl:when>
                        <xsl:when test="//property/name/text() = 'CreationDate'">
                            <xsl:element name="premis:dateCreatedByApplication">
                                <xsl:variable name="creationDate" select="string(//property[child::name/text() = 'CreationDate']/values/value)"/>
                                <xsl:value-of select="java:gov.loc.ndnp.preingest.utilities.DateFormatter.format('EEE MMM dd HH:mm:ss zzz yyyy', $creationDate)" />
                            </xsl:element>
                        </xsl:when>                        
                    </xsl:choose>
                </xsl:element>
            </xsl:if>
        </xsl:element>
    </xsl:template>    
</xsl:stylesheet>
