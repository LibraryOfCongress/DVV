<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:mods="http://www.loc.gov/mods/v3"
  xmlns:ndnp="http://www.loc.gov/ndnp"
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
            <h1>Reel <xsl:value-of select="@LABEL"/></h1>
                <xsl:apply-templates/>
        </body>
    </html>
</xsl:template>

<xsl:template match="//*[local-name()='amdSec']"><!-- */ -->
    <xsl:apply-templates select="*[local-name()='techMD']"/><!-- */ -->
</xsl:template>

<xsl:template match="*[local-name()='techMD']"><!-- */ -->
    <xsl:if test="@ID='reelTechMD'">
		<h4>NDNP Reel Technical Metadata</h4>
		<xsl:apply-templates select="*[local-name()='mdWrap']"/><!-- */ -->
    </xsl:if>
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
	<xsl:choose>
	    <xsl:when test="@MDTYPE='OTHER'">
		    <xsl:if test="@OTHERMDTYPE='NDNP Reel Technical Metadata'">
	    		<xsl:apply-templates select="*[local-name()='xmlData']/ndnp:reelTechMD"/>
	    	</xsl:if>
    	</xsl:when>
	    <xsl:otherwise>
		    <b>MD Type - <xsl:value-of select="@MDTYPE"/></b>
		    <br/>
		    <b>Label - <xsl:value-of select="@LABEL"/></b>
		    <xsl:apply-templates select="*[local-name()='xmlData']/mods:mods/mods:titleInfo/mods:title"/>
		    <xsl:apply-templates select="*[local-name()='xmlData']/mods:mods/mods:part/mods:extent"/>
		    <xsl:apply-templates select="*[local-name()='xmlData']/mods:mods/mods:relatedItem"/>
		    <xsl:apply-templates select="*[local-name()='xmlData']/mods:mods/mods:originInfo/mods:dateIssued"/>
		    <xsl:apply-templates select="*[local-name()='xmlData']/mods:mods/mods:note"/>
	    </xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="*[local-name()='xmlData']/ndnp:reelTechMD">
	<b>Title: <xsl:value-of select="ndnp:titles/text()"/></b>
    <br/>
	<b>Start Date: <xsl:value-of select="ndnp:startDate/text()"/></b>
    <br/>
	<b>End Date: <xsl:value-of select="ndnp:endDate/text()"/></b>
    <br/>
	<b>Position: <xsl:value-of select="ndnp:position/text()"/></b>
    <br/>
	<b>Reduction Ratio: <xsl:value-of select="ndnp:reductionRatio/text()"/></b>
    <br/>
	<b>Capture Resolution (original): <xsl:value-of select="ndnp:captureResolutionOriginal/text()"/></b>
    <br/>
	<b>Capture Resolution (film): <xsl:value-of select="ndnp:captureResolutionFilm/text()"/></b>
    <br/>
	<b>Guide To Contents Present Flag: <xsl:value-of select="ndnp:guideToContentsPresentFlag/text()"/></b>
    <br/>
	<b>Guide To Contents String: <xsl:value-of select="ndnp:guideToContentsString/text()"/></b>
    <br/>
	<b>Date Microfilm Created: <xsl:value-of select="ndnp:dateMicrofilmCreated/text()"/></b>
    <br/>
	<b>Loose Leaves Flag: <xsl:value-of select="ndnp:looseLeavesFlag/text()"/></b>
    <br/>
	<b>Bound Volume Flag: <xsl:value-of select="ndnp:boundVolumeFlag/text()"/></b>
    <br/>
	<b>Comments: <xsl:value-of select="ndnp:comments/text()"/></b>
    <br/>
    <b>Dimensions: <xsl:value-of select="ndnp:dimensions/text()"/></b>
    <br/>
	<b>Pages Per Issue: <xsl:value-of select="ndnp:pagesPerIssue/text()"/></b>
    <br/>
	<b>Number Of Resolution Targets: <xsl:value-of select="ndnp:numberOfResolutionTargets/text()"/></b>
    <br/>
	<b>Resolution Of Master: <xsl:value-of select="ndnp:resolutionOfMaster/text()"/></b>
    <br/>
	<b>Resolution Comment Master: <xsl:value-of select="ndnp:resolutionCommentMaster/text()"/></b>
    <br/>
	<b>Density Reading Master: <xsl:value-of select="ndnp:densityReadingMaster/text()"/></b>
    <br/>
	<b>dmin Master: <xsl:value-of select="ndnp:dminMaster/text()"/></b>
    <br/>
	<b>Resolution Comment Duplicate Negative: <xsl:value-of select="ndnp:resolutionCommentDuplicateNegative/text()"/></b>
    <br/>
	<b>Density Reading Duplicate Negative: <xsl:value-of select="ndnp:densityReadingDuplicateNegative/text()"/></b>
    <br/>
	<b>Average Density Duplicate Negative: <xsl:value-of select="ndnp:averageDensityDuplicateNegative/text()"/></b>
    <br/>
	<b>dmin Duplicate Negative: <xsl:value-of select="ndnp:dminDuplicateNegative/text()"/></b>
    <br/>
</xsl:template>

<xsl:template match="*[local-name()='xmlData']/mods:mods/mods:originInfo/mods:dateIssued">
    <br/>
    <b>Origin Info:</b>
    <br/>
    <b>Encoding - <xsl:value-of select="@encoding"/></b>
    <br/>
    <b>Date Issued - <xsl:value-of select="text()"/></b>
</xsl:template>

<xsl:template match="*[local-name()='xmlData']/mods:mods/mods:part/mods:extent">
    <br/>
    <b>Extent Unit - <xsl:value-of select="@unit"/></b> 
    <xsl:apply-templates select="mods:start"/>
</xsl:template>

<xsl:template match="mods:start">
    <br/>
    <b>Extent Start - <xsl:value-of select="text()"/></b> 
    <xsl:apply-templates select="//*[local-name()='mets']/dmdSec/mdWrap/xmlData"/>
</xsl:template>

<xsl:template match="*[local-name()='xmlData']/mods:mods/mods:relatedItem">
    <xsl:if test="@type='original'">
        <br/>
        <b>Related Item Type - <xsl:value-of select="@type"/></b>
        <br/>
        <b>Reel Number - <xsl:value-of select="mods:identifier[@type='reel number']/text()"/></b>
        <br/>
        <b>Reel Sequence Number - <xsl:value-of select="mods:identifier[@type='reel sequence number']/text()"/></b>
        <br/>
    </xsl:if>
    <xsl:if test="@type='host'">
        <br/>
        <b>Related Item Type - <xsl:value-of select="@type"/></b>
        <xsl:apply-templates select="mods:identifier"/>
        <xsl:apply-templates select="mods:part"/>
    </xsl:if>
    <xsl:apply-templates select="mods:location/mods:physicalLocation"/>
</xsl:template>

<xsl:template match="mods:identifier">
    <br/>
    <b>Mods Identifier Type - <xsl:value-of select="@type"/></b>
    <br/>
    <b>Mods Identifier Value - <xsl:value-of select="text()"/></b>
</xsl:template>

<xsl:template match="mods:part">
    <br/>
    <b>Mods Details:</b>
    <xsl:for-each select="mods:detail">
        <br/>
        <b><xsl:value-of select="@type"/> - <xsl:value-of select="mods:number/text()"/></b>
    </xsl:for-each>
</xsl:template>

<xsl:template match="mods:location/mods:physicalLocation">
    <b>Location Authority - <xsl:value-of select="@authority"/></b>
    <br/>
    <b>Location Display Label - <xsl:value-of select="@displayLabel"/></b>
    <br/>
    <b>Physical Location - <xsl:value-of select="text()"/></b>
</xsl:template>

<xsl:template match="*[local-name()='xmlData']/mods:mods/mods:note">
    <xsl:if test="@type='agencyResponsibleForReproduction'">
        <br/>
        <b>Mods Note Type - <xsl:value-of select="@type"/></b>
        <br/>
        <b>Display Label - <xsl:value-of select="@displayLabel"/></b>
        <br/>
        <b>Note Text - <xsl:value-of select="text()"/></b>
    </xsl:if>
    <xsl:if test="@type='noteAboutReproduction'">
        <br/>
        <b>Mods Note Type - <xsl:value-of select="@type"/></b>
        <br/>
        <b>Note Text - <xsl:value-of select="text()"/></b>
        <br/>
        <b>Display Label - <xsl:value-of select="@displayLabel"/></b>
        <br/>
    </xsl:if>
</xsl:template>

<xsl:template match="*[local-name()='xmlData']/mods:mods/mods:titleInfo/mods:title">
        <br/>
        <b>Mods Title - <xsl:value-of select="text()"/></b>
</xsl:template>

<xsl:template match="//*[local-name()='fileSec']"><!-- */ -->
    <h4>File Section</h4>
    <table border="1">
        <xsl:for-each select="//*[local-name()='fileGrp']"><!-- */ -->
            <tr>
                <td><xsl:value-of select="@ID"/></td>
                <xsl:for-each select="*[local-name()='file']">
                    <td>
                        <xsl:apply-templates select="*[local-name()='FLocat']"/>
                    </td>
                </xsl:for-each>
            </tr>
        </xsl:for-each>
    </table>
</xsl:template>

<xsl:template match="*[local-name()='FLocat']">
        <xsl:value-of select="@xlink:href"/>
</xsl:template>

<xsl:template match="//*[local-name()='structMap']"><!-- */ -->
    <h4>Structure Map</h4>
        <xsl:for-each select="*[local-name()='div']"><!-- */ -->
            <b>DivType: <xsl:value-of select="@TYPE"/></b>
            <br/>
            <xsl:choose>
                <xsl:when test="@TYPE='np:reel'">
                    <br/>
                    <b>ADMID: <xsl:value-of select="@ADMID"/></b>
                </xsl:when>
                <xsl:otherwise>
                    <br/>
                    <b>DMDID: <xsl:value-of select="@DMDID"/></b>
                </xsl:otherwise>
            </xsl:choose>
            <br/>
            <br/>
            <b>Pages</b>
            <table border="1">
                    <xsl:for-each select="*[local-name()='div']">
                        <tr>
                        <td><xsl:value-of select="@DMDID"/></td>
                        <td>
                            <xsl:apply-templates select="*[local-name()='fptr']"/>
                        </td>
                        </tr>
                    </xsl:for-each>
            </table>
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