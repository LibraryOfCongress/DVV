<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [<!ENTITY nbsp "&#160;"><!ENTITY gt "&#63;">]>
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:fn="http://www.w3.org/2005/02/xpath-functions" 
  xmlns:alto="http://schema.ccs-gmbh.com/ALTO"
  version="1.0">
<xsl:output method="html" encoding="UTF-8"/>
<xsl:template match="/repInfo">
    <html>
    	<head>
    		<style type="text/css">body { font-family: Arial, Verdana, Geneva, sans-serif; }</style> 
    	</head>
        <body>
            <h1>Master File Header Data</h1>
                <xsl:apply-templates/>
        </body>
    </html>
</xsl:template>

<xsl:template match="array">
    <div><xsl:attribute name="id"><xsl:value-of select="@name"/></xsl:attribute>
    <h3>Array - <xsl:value-of select="@name"/></h3>
    <xsl:for-each select="*">
	<xsl:choose>
	    <xsl:when test="name()='NisoImageMetadata'"/>
	    <xsl:when test="name()='array'"/>
	    <xsl:when test="name()='list'"/>
	    <xsl:when test="name()='set'"/>
	    <xsl:when test="name()='map'"/>
	    <xsl:otherwise>
			<xsl:value-of select="name()"/> 
				<xsl:call-template name="ConvertLabelToTag"/>
			- 
	    	<xsl:value-of select="text()"/><br/>
	    </xsl:otherwise>
	</xsl:choose>
    </xsl:for-each>
    </div>
    <xsl:apply-templates select="array"/>
    <xsl:apply-templates select="list"/>
    <xsl:apply-templates select="set"/>
    <xsl:apply-templates select="map"/>
</xsl:template>

<xsl:template match="list">
    <div><xsl:attribute name="id"><xsl:value-of select="@name"/></xsl:attribute>
    <h3>List - <xsl:value-of select="@name"/></h3>
    <xsl:for-each select="*">
	<xsl:choose>
		<xsl:when test="name()='DocumentName'">
			<span style="color:#0B61A4"><b><xsl:value-of select="name()"/></b></span>
			<span style="color:#0B61A4"><b><xsl:call-template name="ConvertLabelToTag"/></b></span>
			<span style="color:#0B61A4"><b>- </b></span> 
			<span style="color:#0B61A4"><b><xsl:value-of select="text()"/></b><br/></span>	
		</xsl:when>
		<xsl:when test="name()='NisoImageMetadata'"/>
	    <xsl:when test="name()='array'"/>
	    <xsl:when test="name()='list'"/>
	    <xsl:when test="name()='set'"/>
	    <xsl:when test="name()='map'"/>
	    <xsl:otherwise>
	    	<!--<xsl:if test="DocumentName">
	    		<span style="color:#0B61A4"><b><xsl:value-of select="name()"/></b></span>	
	    		<span style="color:#0B61A4"><b><xsl:call-template name="ConvertLabelToTag"/></b></span>
	    		<span style="color:#0B61A4"><b>-</b></span> 
	    		<span style="color:#0B61A4"><b><xsl:value-of select="text()"/></b><br/></span>
	    	</xsl:if>-->
	    	
	    	
	    	<!--<xsl:choose>
	    			<xsl:when test="name()='DocumentName'">
	    				<span style="color:#0B61A4"><b><xsl:value-of select="name()"/></b></span>
	    				<span style="color:#0B61A4"><b><xsl:call-template name="ConvertLabelToTag"/></b></span>
	    				<span style="color:#0B61A4"><b>-</b></span> 
	    				<span style="color:#0B61A4"><b><xsl:value-of select="text()"/></b><br/></span>	
	    			</xsl:when>
	    	</xsl:choose>-->
	    	
	    	<!--<xsl:if test="name()='DocumentName'">
	    		<span style="color:#0B61A4"><b><xsl:value-of select="name()"/></b></span>
	    		<span style="color:#0B61A4"><b><xsl:call-template name="ConvertLabelToTag"/></b></span>
	    		<span style="color:#0B61A4"><b>-</b></span> 
	    		<span style="color:#0B61A4"><b><xsl:value-of select="text()"/></b><br/></span>	
	    	</xsl:if>-->
	    	
	    	<xsl:value-of select="name()"/>
					
						
	 
				<xsl:call-template name="ConvertLabelToTag"/>
			- 
	    	<xsl:value-of select="text()"/><br/>
	   	
	    </xsl:otherwise>
	</xsl:choose>
    </xsl:for-each>
    </div>
    <xsl:apply-templates select="array"/>
    <xsl:apply-templates select="list"/>
    <xsl:apply-templates select="set"/>
    <xsl:apply-templates select="map"/>
    <xsl:apply-templates select="NisoImageMetadata"/>
</xsl:template>

<xsl:template match="set">
    <div><xsl:attribute name="id"><xsl:value-of select="@name"/></xsl:attribute>
    <h3>Set - <xsl:value-of select="@name"/></h3>
    <xsl:for-each select="*">
	<xsl:choose>
	    <xsl:when test="name()='NisoImageMetadata'"/>
	    <xsl:when test="name()='array'"/>
	    <xsl:when test="name()='list'"/>
	    <xsl:when test="name()='set'"/>
	    <xsl:when test="name()='map'"/>
	    <xsl:otherwise>
			<xsl:value-of select="name()"/> 
				<xsl:call-template name="ConvertLabelToTag"/>
			- 
			<xsl:value-of select="text()"/><br/>
	    </xsl:otherwise>
	</xsl:choose>
    </xsl:for-each>
    </div>
    <xsl:apply-templates select="array"/>
    <xsl:apply-templates select="list"/>
    <xsl:apply-templates select="set"/>
    <xsl:apply-templates select="map"/>
</xsl:template>

<xsl:template match="map">
    <div><xsl:attribute name="id"><xsl:value-of select="@name"/></xsl:attribute>
    <h3>Map - <xsl:value-of select="@name"/></h3>
    <xsl:for-each select="*">
	<xsl:choose>
	    <xsl:when test="name()='NisoImageMetadata'"/>
	    <xsl:when test="name()='array'"/>
	    <xsl:when test="name()='list'"/>
	    <xsl:when test="name()='set'"/>
	    <xsl:when test="name()='map'"/>
	    <xsl:otherwise>
			<xsl:value-of select="name()"/> 
				<xsl:call-template name="ConvertLabelToTag"/>
			- 
			<xsl:value-of select="text()"/><br/>
	    </xsl:otherwise>
	</xsl:choose>
    </xsl:for-each>
    </div>
    <xsl:apply-templates select="array"/>
    <xsl:apply-templates select="list"/>
    <xsl:apply-templates select="set"/>
    <xsl:apply-templates select="map"/>
</xsl:template>

<xsl:template match="NisoImageMetadata">
    <div><xsl:attribute name="id"><xsl:value-of select="@name"/></xsl:attribute>
    <h3>Niso Image Metadata</h3>
    <xsl:for-each select="*">
	<xsl:value-of select="name()"/>
		<xsl:call-template name="ConvertLabelToTag"/>
	- 
	<xsl:value-of select="text()"/><br/>
    </xsl:for-each>
    </div>
</xsl:template>

<xsl:template name="ConvertLabelToTag">
	<xsl:choose>
	    <xsl:when test="name()='NewSubfileType'"> (254) </xsl:when>
	    <xsl:when test="name()='NewSubfileType'"> (255) </xsl:when>
	    <xsl:when test="name()='ImageWidth'"> (256) </xsl:when>
	    <xsl:when test="name()='ImageLength'"> (257) </xsl:when>
	    <xsl:when test="name()='BitsPerSample'"> (258) </xsl:when>
	    <xsl:when test="name()='Compression'"> (259) </xsl:when>
	    <xsl:when test="name()='PhotometricInterpretation'"> (262) </xsl:when>
	    <xsl:when test="name()='Threshholding'"> (263) </xsl:when>
	    <xsl:when test="name()='CellWidth'"> (264) </xsl:when>
	    <xsl:when test="name()='CellLength'"> (265) </xsl:when>
	    <xsl:when test="name()='FillOrder'"> (266) </xsl:when>
		<xsl:when test="name()='DocumentName'"> (269) </xsl:when>
		<xsl:when test="name()='ImageDescription'"> (270) </xsl:when>
	    <xsl:when test="name()='Make'"> (271) </xsl:when>
	    <xsl:when test="name()='Model'"> (272) </xsl:when>
	    <xsl:when test="name()='StripOffsets'"> (273) </xsl:when>
	    <xsl:when test="name()='Orientation'"> (274) </xsl:when>
	    <xsl:when test="name()='SamplesPerPixel'"> (277) </xsl:when>
	    <xsl:when test="name()='RowsPerStrip'"> (278) </xsl:when>
	    <xsl:when test="name()='StripByteCounts'"> (279) </xsl:when>
	    <xsl:when test="name()='MinSampleValue'"> (280) </xsl:when>
	    <xsl:when test="name()='MaxSampleValue'"> (281) </xsl:when>
	    <xsl:when test="name()='XResolution'"> (282) </xsl:when>
	    <xsl:when test="name()='YResolution'"> (283) </xsl:when>
	    <xsl:when test="name()='PlanarConfiguration'"> (284) </xsl:when>
	    <xsl:when test="name()='PageName'"> (285) </xsl:when>
	    <xsl:when test="name()='XPosition'"> (286) </xsl:when>
	    <xsl:when test="name()='YPosition'"> (287) </xsl:when>
	    <xsl:when test="name()='FreeOffsets'"> (288) </xsl:when>
	    <xsl:when test="name()='FreeByteCounts'"> (289) </xsl:when>
	    <xsl:when test="name()='GrayResponseUnit'"> (290) </xsl:when>
	    <xsl:when test="name()='GrayResponseCurve'"> (291) </xsl:when>
	    <xsl:when test="name()='T4Options'"> (292) </xsl:when>
	    <xsl:when test="name()='T6Options'"> (293) </xsl:when>
	    <xsl:when test="name()='ResolutionUnit'"> (296) </xsl:when>
	    <xsl:when test="name()='PageNumber'"> (297) </xsl:when>
	    <xsl:when test="name()='TransferFunction'"> (301) </xsl:when>
	    <xsl:when test="name()='Software'"> (305) </xsl:when>
	    <xsl:when test="name()='DateTime'"> (306) </xsl:when>
	    <xsl:when test="name()='Artist'"> (315) </xsl:when>
	    <xsl:when test="name()='HostComputer'"> (316) </xsl:when>
	    <xsl:when test="name()='Predictor'"> (317) </xsl:when>
	    <xsl:when test="name()='WhitePoint'"> (318) </xsl:when>
	    <xsl:when test="name()='PrimaryChromaticities'"> (319) </xsl:when>
	    <xsl:when test="name()='ColorMap'"> (320) </xsl:when>
	    <xsl:when test="name()='HalftoneHints'"> (321) </xsl:when>
	    <xsl:when test="name()='TileWidth'"> (322) </xsl:when>
	    <xsl:when test="name()='TileLength'"> (323) </xsl:when>
	    <xsl:when test="name()='TileOffsets'"> (324) </xsl:when>
	    <xsl:when test="name()='TileByteCounts'"> (325) </xsl:when>
	    <xsl:when test="name()='InkSet'"> (332) </xsl:when>
	    <xsl:when test="name()='InkNames'"> (333) </xsl:when>
	    <xsl:when test="name()='NumberOfInks'"> (334) </xsl:when>
	    <xsl:when test="name()='DotRange'"> (336) </xsl:when>
	    <xsl:when test="name()='TargetPrinter'"> (337) </xsl:when>
	    <xsl:when test="name()='ExtraSamples'"> (338) </xsl:when>
	    <xsl:when test="name()='SampleFormat'"> (339) </xsl:when>
	    <xsl:when test="name()='SMinSampleValue'"> (340) </xsl:when>
	    <xsl:when test="name()='SMaxSampleValue'"> (341) </xsl:when>
	    <xsl:when test="name()='TransferRange'"> (342) </xsl:when>
	    <xsl:when test="name()='JPEGProc'"> (512) </xsl:when>
	    <xsl:when test="name()='JPEGInterchangeFormat'"> (513) </xsl:when>
	    <xsl:when test="name()='JPEGInterchangeFormatLength'"> (514) </xsl:when>
	    <xsl:when test="name()='JPEGRestartInterval'"> (515) </xsl:when>
	    <xsl:when test="name()='JPEGLosslessPredictors'"> (517) </xsl:when>
	    <xsl:when test="name()='JPEGPointTransforms'"> (518) </xsl:when>
	    <xsl:when test="name()='JPEGQTables'"> (519) </xsl:when>
	    <xsl:when test="name()='JPEGDCTables'"> (520) </xsl:when>
	    <xsl:when test="name()='JPEGACTables'"> (521) </xsl:when>
	    <xsl:when test="name()='YCbCrCoefficients'"> (529) </xsl:when>
	    <xsl:when test="name()='YCbCrSubSampling'"> (530) </xsl:when>
	    <xsl:when test="name()='YCbCrPositioning'"> (531) </xsl:when>
	    <xsl:when test="name()='ReferenceBlackWhite'"> (532) </xsl:when>
	    <xsl:when test="name()='Copyright'"> (33432) </xsl:when>
	    <xsl:when test="name()='UniqueImageId'"> (42016) </xsl:when>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet> 
