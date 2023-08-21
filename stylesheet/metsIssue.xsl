<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:xlink="http://www.w3.org/1999/xlink"
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
            <span style="color:#0B61A4"><h1><xsl:value-of select="@LABEL"/></h1></span>
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
    <xsl:apply-templates select="*[local-name()='xmlData']/mods:mods/mods:part/mods:extent"/>
    <xsl:if test="@LABEL='Page metadata'">
	    <xsl:choose>
	    	<xsl:when test="*[local-name()='xmlData']/mods:mods/mods:part/mods:detail">
			    <xsl:apply-templates select="*[local-name()='xmlData']/mods:mods/mods:part/mods:detail"/>
	    	</xsl:when>
	    	<xsl:otherwise>
	    		<br/>
			    <b>Printed Page Number - [none - element omitted]</b> 
	    	</xsl:otherwise>
	    </xsl:choose>
	</xsl:if>
    <xsl:if test="@LABEL='Section metadata'">
        <xsl:choose>
	    	<xsl:when test="*[local-name()='xmlData']/mods:mods/mods:part/mods:detail">
			    <xsl:apply-templates select="*[local-name()='xmlData']/mods:mods/mods:part/mods:detail"/>
	    	</xsl:when>
	    	<xsl:otherwise>
	    		<br/>
			    <b>Printed Page Number - [none - element omitted]</b> 
	    	</xsl:otherwise>
        </xsl:choose>         
	</xsl:if>
    <xsl:apply-templates select="*[local-name()='xmlData']/mods:mods/mods:relatedItem"/>
    <xsl:apply-templates select="*[local-name()='xmlData']/mods:mods/mods:originInfo/mods:dateIssued"/>
    <xsl:apply-templates select="*[local-name()='xmlData']/mods:mods/mods:note"/>
</xsl:template>

<xsl:template match="*[local-name()='xmlData']/mods:mods/mods:originInfo/mods:dateIssued">
    <br/>
    <b>Origin Info:</b>
    <br/>
    <b>Encoding - <xsl:value-of select="@encoding"/></b>
    <br/>
    <xsl:choose>
        <xsl:when test="@qualifier">
            <b><span style="color:#ff9200">Date Issued(<xsl:value-of select="@qualifier"/>) - <xsl:value-of select="text()"/></span></b>
        </xsl:when>
        <xsl:otherwise>
            <b><span style="color:#ff9200">Date Issued - <xsl:value-of select="text()"/></span></b>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<xsl:template match="*[local-name()='xmlData']/mods:mods/mods:part/mods:extent">
    <br/>
    <b>Extent Unit - <xsl:value-of select="@unit"/></b> 
    <xsl:apply-templates select="mods:start"/>
</xsl:template>

<xsl:template match="mods:start">
    <br/>
    <b>Page - <xsl:value-of select="text()"/></b> 
    <xsl:apply-templates select="//*[local-name()='mets']/dmdSec/mdWrap/xmlData"/>
</xsl:template>

<xsl:template match="*[local-name()='xmlData']/mods:mods/mods:part/mods:detail">
    <br/>
    <xsl:choose>
	    <xsl:when test="@type='page number'">
	        <b><span style="color:#ff9200">Printed Page Number - <xsl:value-of select="mods:number/text()"/></span></b> 
	    </xsl:when>
	    <xsl:when test="@type='section label'">
	        <b><span style="color:#ff9200">Section Label - <xsl:value-of select="mods:number/text()"/></span></b> 
	    </xsl:when>
	    <xsl:otherwise>
		    <b>Printed Page Number - [none - element omitted]</b> 
	    </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<xsl:template match="*[local-name()='xmlData']/mods:mods/mods:relatedItem">
    <xsl:if test="@type='original'">
        <br/>
        <b>Related Item Type - <xsl:value-of select="@type"/></b>
        <br/>
        <b><span style="color:#ff9200">Reel Number - <xsl:value-of select="mods:identifier[@type='reel number']/text()"/></span></b>
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
    <span style="color:#0B61A4"><b>Mods Identifier Value - <xsl:value-of select="text()"/></b></span>
</xsl:template>

<xsl:template match="mods:part">
    <br/>
    <b>Mods Details:</b>
    <xsl:for-each select="mods:detail">
        <br/>
        <span style="color:#ff9200"><b><xsl:value-of select="@type"/> - <xsl:value-of select="mods:number/text()"/></b></span>
        <xsl:if test="@type='edition'">
        	<br/>
        	<xsl:choose>
		        <xsl:when test="mods:caption">
		            <span style="color:#ff9200"><b>Edition label (optional) - <xsl:value-of select="mods:caption/text()"/></b></span>
		        </xsl:when>
		        <xsl:otherwise>
		        	<b>Edition label (optional) - [none - element omitted]</b>
		        </xsl:otherwise>
        	</xsl:choose>
        </xsl:if>
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
        <xsl:for-each select="*[local-name()='div']">
            <b>DivType: <xsl:value-of select="@TYPE"/></b>
            <br/>
            <b>DMDID: <xsl:value-of select="@DMDID"/></b>
            <br/>
			<xsl:if test="*[local-name()='div']/@TYPE='np:page'">
            <br/>
	            <b>Pages</b>
	            <br/>
	            <br/>
	        </xsl:if>
            <table border="1">
                    <xsl:for-each select="*[local-name()='div']">
	    				<xsl:if test="@TYPE='np:page'">
	                        <tr>
	                        <td><xsl:value-of select="@DMDID"/></td>
	                        <td>
	                            <xsl:apply-templates select="*[local-name()='fptr']"/>
	                        </td>
	                        </tr>
						</xsl:if>
                    </xsl:for-each>
            </table>
            <xsl:for-each select="*[local-name()='div']">
            	<xsl:choose>
    				<xsl:when test="@TYPE='np:section'">
    					<br/>
    					<b>Pages for section: <xsl:value-of select="@DMDID"/></b>
			            <br/>
			            <br/>
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
					</xsl:when>
            	</xsl:choose>
			</xsl:for-each>
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