<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [<!ENTITY nbsp "&#160;"><!ENTITY gt "&#63;">]>
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:fn="http://www.w3.org/2005/02/xpath-functions" 
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
  xmlns:dc="http://purl.org/dc/elements/1.1/"
  xmlns:x="adobe:ns:meta/" 
  xmlns:xap="http://ns.adobe.com/xap/1.0/"
  xmlns:xapMM="http://ns.adobe.com/xap/1.0/mm/"
  version="1.0">
<xsl:output method="html" encoding="UTF-8"/>
<xsl:template match="/repInfo">
    <html>
        <head>
            <style type="text/css">body { font-family: Arial, Verdana, Geneva, sans-serif; }</style> 
        </head>
        <body>
            <h1>Derivative File Header Data</h1>
                <xsl:apply-templates/>
        </body>
    </html>
</xsl:template>

<xsl:template match="array">
    <h3>Array - <xsl:value-of select="@name"/></h3>
    <xsl:for-each select="*">
	<xsl:choose>
	    <xsl:when test="name()='NisoImageMetadata'"/>
	    <xsl:when test="name()='XMP'"/>
	    <xsl:when test="name()='array'"/>
	    <xsl:when test="name()='list'"/>
	    <xsl:when test="name()='set'"/>
	    <xsl:when test="name()='map'"/>
	    <xsl:otherwise>
		<xsl:value-of select="name()"/> - <xsl:value-of select="text()"/><br/>
	    </xsl:otherwise>
	</xsl:choose>
    </xsl:for-each>
    <xsl:apply-templates select="XMP"/>
    <xsl:apply-templates select="array"/>
    <xsl:apply-templates select="list"/>
    <xsl:apply-templates select="set"/>
    <xsl:apply-templates select="map"/>
</xsl:template>

<xsl:template match="list">
    <h3>List - <xsl:value-of select="@name"/></h3>
    <xsl:for-each select="*">
	<xsl:choose>
	    <xsl:when test="name()='XMP'"/>
	    <xsl:when test="name()='NisoImageMetadata'"/>
	    <xsl:when test="name()='array'"/>
	    <xsl:when test="name()='list'"/>
	    <xsl:when test="name()='set'"/>
	    <xsl:when test="name()='map'"/>
	    <xsl:otherwise>
		<xsl:value-of select="name()"/> - <xsl:value-of select="text()"/><br/>
	    </xsl:otherwise>
	</xsl:choose>
    </xsl:for-each>
    <xsl:apply-templates select="XMP"/>
    <xsl:apply-templates select="array"/>
    <xsl:apply-templates select="list"/>
    <xsl:apply-templates select="set"/>
    <xsl:apply-templates select="map"/>
    <xsl:apply-templates select="NisoImageMetadata"/>
</xsl:template>

<xsl:template match="set">
    <h3>Set - <xsl:value-of select="@name"/></h3>
    <xsl:for-each select="*">
	<xsl:choose>
	    <xsl:when test="name()='NisoImageMetadata'"/>
	    <xsl:when test="name()='XMP'"/>
	    <xsl:when test="name()='array'"/>
	    <xsl:when test="name()='list'"/>
	    <xsl:when test="name()='set'"/>
	    <xsl:when test="name()='map'"/>
	    <xsl:otherwise>
		<xsl:value-of select="name()"/> - <xsl:value-of select="text()"/><br/>
	    </xsl:otherwise>
	</xsl:choose>
    </xsl:for-each>
    <xsl:apply-templates select="array"/>
    <xsl:apply-templates select="list"/>
    <xsl:apply-templates select="set"/>
    <xsl:apply-templates select="map"/>
</xsl:template>

<xsl:template match="map">
    <h3>Map - <xsl:value-of select="@name"/></h3>
    <xsl:for-each select="*">
	<xsl:choose>
	    <xsl:when test="name()='NisoImageMetadata'"/>
	    <xsl:when test="name()='XMP'"/>
	    <xsl:when test="name()='array'"/>
	    <xsl:when test="name()='list'"/>
	    <xsl:when test="name()='set'"/>
	    <xsl:when test="name()='map'"/>
	    <xsl:otherwise>
		<xsl:value-of select="name()"/> - <xsl:value-of select="text()"/><br/>
	    </xsl:otherwise>
	</xsl:choose>
    </xsl:for-each>
    <xsl:apply-templates select="XMP"/>
    <xsl:apply-templates select="array"/>
    <xsl:apply-templates select="list"/>
    <xsl:apply-templates select="set"/>
    <xsl:apply-templates select="map"/>
</xsl:template>

<xsl:template match="NisoImageMetadata">
    <h3>Niso Image Metadata</h3>
    <xsl:for-each select="*">
	<xsl:value-of select="name()"/> - <xsl:value-of select="text()"/><br/>
    </xsl:for-each>
</xsl:template>

<xsl:template match="XMP">
    <xsl:for-each select="*">
	<xsl:choose>
	    <xsl:when test="name()='x:xmpmeta'">
              <xsl:apply-templates select="."/>
	    </xsl:when>
	    <xsl:when test="name()='rdf:RDF'">
              <xsl:apply-templates select="."/>
	    </xsl:when>
	</xsl:choose>
    </xsl:for-each>
</xsl:template>

<xsl:template match="x:xmpmeta">
    <xsl:apply-templates select="rdf:RDF"/>
</xsl:template>

<xsl:template match="rdf:RDF">
    <h2>RDF Information</h2>
    <xsl:apply-templates select="rdf:Description"/>
</xsl:template>

<xsl:template match="rdf:Description">
    <h3>RDF Description</h3>
    <xsl:apply-templates select="dc:format"/>
    <span style="color:#0B61A4"><b><xsl:apply-templates select="dc:title"/></b></span>
    <span style="color:#0B61A4"><b><xsl:apply-templates select="dc:description"/></b></span>
    <span style="color:#ff9200"><b><xsl:apply-templates select="dc:date"/></b></span>
    <xsl:apply-templates select="dc:type"/>
    <span style="color:#0B61A4"><b><xsl:apply-templates select="dc:identifier"/></b></span>
    <xsl:apply-templates select="xap:ModifyDate"/>
    <xsl:apply-templates select="xap:MetadataDate"/>
    <xsl:apply-templates select="xapMM:DocumentID"/>
    <xsl:apply-templates select="xapMM:InstanceID"/>
</xsl:template>

<xsl:template match="xap:ModifyDate">
    <b>Modify Date - </b><xsl:value-of select="text()"/><br/>
</xsl:template>

<xsl:template match="xap:MetadataDate">
    <b>Metadata Date - </b><xsl:value-of select="text()"/><br/>
</xsl:template>

<xsl:template match="xapMM:DocumentID">
    <b>Document ID - </b><xsl:value-of select="text()"/><br/>
</xsl:template>

<xsl:template match="xapMM:InstanceID">
    <b>Instance ID - </b><xsl:value-of select="text()"/><br/>
</xsl:template>

<xsl:template match="dc:format">
    <b>Format - </b><xsl:value-of select="text()"/><br/>
</xsl:template>

<xsl:template match="rdf:Alt">
    <xsl:for-each select="rdf:li">
	<xsl:value-of select="text()"/><br/>
    </xsl:for-each>
</xsl:template>

<xsl:template match="rdf:Seq">
    <xsl:for-each select="rdf:li">
	<xsl:value-of select="text()"/><br/>
    </xsl:for-each>
</xsl:template>

<xsl:template match="rdf:Bag">
    <xsl:for-each select="rdf:li">
	<xsl:value-of select="text()"/><br/>
    </xsl:for-each>
</xsl:template>

<xsl:template match="dc:title">
    <b>Title - </b><xsl:apply-templates select="rdf:Alt"/>
</xsl:template>

<xsl:template match="dc:description">
    <b>Description - </b><xsl:apply-templates select="rdf:Alt"/>
</xsl:template>

<xsl:template match="dc:date">
    <b>Date - </b><xsl:apply-templates select="rdf:Seq"/>
</xsl:template>

<xsl:template match="dc:type">
    <b>Type - </b><xsl:apply-templates select="rdf:Bag"/>
</xsl:template>

<xsl:template match="dc:identifier">
    <b>Identifier - </b><xsl:apply-templates select="rdf:Alt"/>
</xsl:template>

</xsl:stylesheet> 
