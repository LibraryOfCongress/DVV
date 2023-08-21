<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:xhtml="http://www.w3.org/1999/xhtml"
  xmlns:mods="http://www.loc.gov/mods/v3"
  version="1.0">
<xsl:output method="html"/>
<xsl:template match="//*[local-name()='mets']">
    <!-- */ Nullifies the start of comment above which is not really a start of comment -->
    <!-- This "workaround" is necessary because of the default namespace declaration in 
         the Mets document (xmlns=http://www.loc.gov/METS).  It causes XPath to do funny
         things.  This will probably slow things down.
-->
    <html>
        <head>
            <style type="text/css">body { font-family: Arial, Verdana, Geneva, sans-serif; }</style> 
        </head>
        <body>
            <h1><xsl:value-of select="@LABEL"/></h1>
                <xsl:apply-templates/>
        </body>
    </html>
</xsl:template>

<xsl:template match="//*[local-name()='metsHdr']"><!-- */ -->
    <h3>Creation Timestamp - <xsl:value-of select="@CREATEDATE"/></h3>
    <xsl:apply-templates select="//*[local-name()='agent']"/><!-- */ -->
</xsl:template>

<xsl:template match="//*[local-name()='agent']"><!-- */ -->
    <h3>Creator - <xsl:value-of select="current()"/></h3>
</xsl:template>

<xsl:template match="//*[local-name()='dmdSec']"><!-- */ -->
    <h4>Descriptive Metadata Section for <xsl:value-of select="@ID"/></h4>
    <xsl:apply-templates select="*[local-name()='mdWrap']"/>
</xsl:template>

<xsl:template match="*[local-name()='mdWrap']">
    <b>MD Type - <xsl:value-of select="@MDTYPE"/></b>
    <br/>
    <b>Label - <xsl:value-of select="@LABEL"/></b>
    <xsl:apply-templates select="*[local-name()='xmlData']/mods:mods/mods:name/mods:displayForm"/>
    <xsl:apply-templates select="*[local-name()='xmlData']/mods:mods/mods:relatedItem/mods:identifier"/>
</xsl:template>

<xsl:template match="*[local-name()='xmlData']/mods:mods/mods:name/mods:displayForm">
    <br/>
    <b>Display Form (awardee) - <xsl:value-of select="text()"/></b> 
</xsl:template>

<xsl:template match="mods:identifier">
    <br/>
    <b>Mods Identifier Type - <xsl:value-of select="@type"/></b>
    <br/>
    <b>Mods Identifier Value - <xsl:value-of select="text()"/></b>
</xsl:template>

<xsl:template match="//*[local-name()='fileSec']"><!-- */ -->
    <h4>File Section</h4>
        <xsl:for-each select="//*[local-name()='fileGrp']"><!-- */ -->
            <xsl:for-each select="*[local-name()='file']">
                <xsl:apply-templates select="*[local-name()='FContent']"/>
                <xsl:apply-templates select="*[local-name()='FContent']/xmlData/xhtml:html/xhtml:head"/>
                <xsl:apply-templates select="*[local-name()='FContent']/xmlData/xhtml:html/xhtml:body"/>
            </xsl:for-each>
        </xsl:for-each>
</xsl:template>

<xsl:template match="*[local-name()='FContent']">
        <b>Title - <xsl:value-of select="*[local-name()='xmlData']/xhtml:html/xhtml:head/xhtml:title/text()"/></b>
        <br/>
        <br/>
        <xsl:apply-templates select="*[local-name()='xmlData']/xhtml:html/xhtml:body"/>
</xsl:template>

<xsl:template match="*[local-name()='xmlData']/xhtml:html/xhtml:body">
	<b>Body - </b>
        <xsl:for-each select="xhtml:p">
        	<xsl:apply-templates/>
        	<br/>
        </xsl:for-each>
</xsl:template>

<xsl:template match="xhtml:a">
	<xsl:variable name="uri" select="@href"/>
	<b><a href="$uri"><xsl:apply-templates/></a></b>
</xsl:template>

<xsl:template match="xhtml:cite">
	<b><xsl:value-of select="."/></b>
</xsl:template>

<xsl:template match="//*[local-name()='structMap']"><!-- */ -->
    <h4>Structure Map</h4>
        <xsl:for-each select="*[local-name()='div']"><!-- */ -->
            <b>DivType: <xsl:value-of select="@TYPE"/></b>
            <br/>
            <b>DMDID: <xsl:value-of select="@DMDID"/></b>
            <br/>
            <br/>
        </xsl:for-each>
</xsl:template>

<xsl:template match="*[local-name()='fptr']">
        <td><xsl:value-of select="@FILEID"/></td>
</xsl:template>

<xsl:template match="*[local-name()='div']">
    <br/>
    <b>DivType <xsl:value-of select="@TYPE"/></b>
    <br/>
    <b>DMDID: <xsl:value-of select="@DMDID"/></b>
    <table border="1">
    <xsl:for-each select="*[local-name()='fptr']">
        <tr>
            <td>FILEID</td>
            <td><xsl:value-of select="@FILEID"/></td>
        </tr>
    </xsl:for-each>
    </table>
</xsl:template>

</xsl:stylesheet> 