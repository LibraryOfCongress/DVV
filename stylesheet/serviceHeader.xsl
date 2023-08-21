<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [<!ENTITY nbsp "&#160;"><!ENTITY gt "&#63;">]>
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:fn="http://www.w3.org/2005/02/xpath-functions" 
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
  xmlns:dc="http://purl.org/dc/elements/1.1/"
  version="1.0">
<xsl:output method="html" encoding="UTF-8"/>
<xsl:template match="/">
    <html>
        <head>
            <style type="text/css">body { font-family: Arial, Verdana, Geneva, sans-serif; }</style> 
        </head>
        <body>
            <h1>Service File Header Data</h1>
                <xsl:apply-templates/>
        </body>
    </html>
</xsl:template>

<xsl:template match="repInfo/list">
    <xsl:for-each select="*">
        <xsl:choose>
            <xsl:when test="name()='NisoImageMetadata'"/>
            <xsl:when test="name()='XML'"/>
            <xsl:when test="name()='array'"/>
            <xsl:when test="name()='list'"/>
            <xsl:when test="name()='set'"/>
            <xsl:when test="name()='map'"/>
            <xsl:otherwise>
            <xsl:value-of select="name()"/> - <xsl:value-of select="text()"/><br/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:for-each>
    <xsl:apply-templates select="XML"/>
    <xsl:apply-templates select="array"/>
    <xsl:apply-templates select="list"/>
    <xsl:apply-templates select="set"/>
    <xsl:apply-templates select="map"/>
</xsl:template>

<xsl:template match="list">
    <xsl:choose>
	<xsl:when test="@name='ColorSpecs'">
            <xsl:call-template name="ColorSpecs"/>
    </xsl:when>
	<xsl:when test="@name='ColorSpec'">
            <xsl:call-template name="ColorSpec"/>
    </xsl:when>
	<xsl:when test="@name='Codestreams'">
            <xsl:call-template name="Codestreams"/>
    </xsl:when>
	<xsl:when test="@name='Codestream'">
            <xsl:call-template name="Codestream"/>
    </xsl:when>
	<xsl:when test="@name='ImageAndTileSize'">
            <xsl:call-template name="ImageAndTileSize"/>
    </xsl:when>
	<xsl:when test="@name='CodingStyleDefault'">
            <xsl:call-template name="CodingStyleDefault"/>
    </xsl:when>
	<xsl:when test="@name='QuantizationDefault'">
            <xsl:call-template name="QuantizationDefault"/>
    </xsl:when>
	<xsl:when test="@name='Tiles'">
            <xsl:call-template name="Tiles"/>
    </xsl:when>
	<xsl:when test="@name='Tile'">
            <xsl:call-template name="Tile"/>
    </xsl:when>
	<xsl:when test="@name='TilePart'">
            <xsl:call-template name="TilePart"/>
    </xsl:when>
	<xsl:when test="@name='Comments'">
            <xsl:call-template name="Comments"/>
    </xsl:when>
    </xsl:choose>
</xsl:template>

<xsl:template match="array">
    <xsl:choose>
	<xsl:when test="count(child::*)=1">
        <xsl:for-each select="*">
            <xsl:value-of select="name()"/> - <xsl:value-of select="text()"/><br/>
        </xsl:for-each>
    </xsl:when>
    </xsl:choose>
</xsl:template>

<xsl:template name="ColorSpecs">
    <h2>Color Specs</h2>
    <xsl:apply-templates select="list"/>
</xsl:template>

<xsl:template name="ColorSpec">
    <h3>Color Spec</h3>
    <xsl:for-each select="*">
        <xsl:value-of select="name()"/> - <xsl:value-of select="text()"/><br/>
    </xsl:for-each>
</xsl:template>

<xsl:template name="Codestreams">
    <h2>Code Streams</h2>
    <xsl:apply-templates select="list"/>
</xsl:template>

<xsl:template name="Codestream">
    <h3>Code Stream</h3>
    <xsl:apply-templates select="NisoImageMetadata"/>
    <xsl:apply-templates select="list"/>
</xsl:template>

<xsl:template name="ImageAndTileSize">
    <h3>Image and Tile Sizes</h3>
    <table border="1">
        <tr>
            <xsl:for-each select="*">
                <xsl:choose>
                    <xsl:when test="name()='array'"/>
                    <xsl:otherwise>
                        <th><xsl:value-of select="name()"/></th>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
        </tr>
        <tr>
            <xsl:for-each select="*">
                <xsl:choose>
                    <xsl:when test="name()='array'"/>
                    <xsl:otherwise>
                        <td><xsl:value-of select="text()"/></td>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
        </tr>
    </table>
    <xsl:apply-templates select="array"/>
</xsl:template>

<xsl:template name="CodingStyleDefault">
    <h3>Coding Style Default</h3>
    <table border="1">
        <tr>
            <xsl:for-each select="*">
                <xsl:choose>
                    <xsl:when test="name()='array'"/>
                    <xsl:otherwise>
                        <th><xsl:value-of select="name()"/></th>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
        </tr>
        <tr>
            <xsl:for-each select="*">
                <xsl:choose>
                    <xsl:when test="name()='array'"/>
                    <xsl:otherwise>
                        <td><xsl:value-of select="text()"/></td>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
        </tr>
    </table>
    <xsl:apply-templates select="array"/>
</xsl:template>

<xsl:template name="QuantizationDefault">
    <h3>Quantization Default</h3>
    <table border="1">
        <tr>
            <td><b>Quantization Style</b></td>
            <td><xsl:value-of select="QuantizationStyle/text()"/></td>
        </tr>
        <tr>
            <td><b>Step Values</b></td>
            <xsl:for-each select="array/*">
                <td><xsl:value-of select="text()"/></td>
            </xsl:for-each>
        </tr>
    </table>
</xsl:template>

<xsl:template name="Tiles">
    <h3>Tiles</h3>
    <table border="1">
        <xsl:apply-templates select="list"/>
    </table>
</xsl:template>

<xsl:template name="Tile">    
        <tr>
            <td><b>Tile</b></td>
            <xsl:apply-templates select="list"/>
        </tr>
</xsl:template>

<xsl:template name="TilePart">
    <td><b>Tile Part</b></td>
    <xsl:for-each select="*">
        <td><xsl:value-of select="name()"/></td>
        <td><xsl:value-of select="text()"/></td>
    </xsl:for-each>
</xsl:template>

<xsl:template name="Comments">
    <h2>Comments</h2>
    <xsl:for-each select="Comment">
        <h3>Comment</h3>
        <xsl:value-of select="text()"/><br/>
    </xsl:for-each>
</xsl:template>

<xsl:template match="NisoImageMetadata">
    <h3>Niso Image Metadata</h3>
    <table border="1">
        <xsl:for-each select="*">
            <tr>
                <td><b><xsl:value-of select="name()"/></b></td>
                <td><xsl:value-of select="text()"/></td>
            </tr>
        </xsl:for-each>
    </table>
</xsl:template>

<xsl:template match="repInfo/list/XML/rdf:RDF">
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
    Title - <xsl:apply-templates select="rdf:Alt"/>
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
