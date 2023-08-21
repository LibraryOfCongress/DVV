<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [<!ENTITY nbsp "&#160;"><!ENTITY gt "&#63;">]>
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:fn="http://www.w3.org/2005/02/xpath-functions" 
  xmlns:alto="http://schema.ccs-gmbh.com/ALTO"
  version="1.0">
<xsl:param name="ocrPercent"/>
<xsl:variable name="accuracyThreshold" select="'0.0'"/>
<xsl:output method="html" encoding="UTF-8"/>
<xsl:template match="/alto:alto">
    <html>
        <head>
            <style type="text/css">body { font-family: Arial, Verdana, Geneva, sans-serif; }</style> 
        </head>
        <body>
            <h1>OCR Data</h1>
                <xsl:apply-templates/>
        </body>
    </html>
</xsl:template>

<!-- Description is optional -->
<xsl:template match="alto:Description">
    <h3>Description:</h3>
    <xsl:apply-templates select="alto:MeasurementUnit"/>
    <xsl:apply-templates select="alto:sourceImageInformation"/>
    <xsl:apply-templates select="alto:OCRProcessing"/>
</xsl:template>

<!-- This begins the Description tree section -->
<!-- MeasurementUnit is optional -->
<xsl:template match="alto:MeasurementUnit">
    <b>Measurement Unit - <xsl:value-of select="text()"/></b>
</xsl:template>

<!-- sourceImageInformation is optional -->
<xsl:template match="alto:sourceImageInformation">
    <xsl:apply-templates select="alto:fileName"/>
    <xsl:apply-templates select="alto:fileIdentifier"/>
</xsl:template>

<!-- fileName is optional -->
<xsl:template match="alto:fileName">
    <br/>
    <br/>
    <b>File Name - <xsl:value-of select="text()"/></b>
</xsl:template>

<!-- fileIdentifier is optional, unbounded -->
<xsl:template match="alto:fileIdentifier">
    <br/>
    <br/>
    <xsl:for-each select="alto:fileIdentifier">
        <b>File Identifier - <xsl:value-of select="text()"/></b>
    </xsl:for-each>
</xsl:template>

<!-- OCRProcessing is optional, unbounded -->
<xsl:template match="alto:OCRProcessing">
    <xsl:apply-templates select="alto:preProcessingStep"/>
    <xsl:apply-templates select="alto:ocrProcessingStep"/>
    <xsl:apply-templates select="alto:postProcessingStep"/>
</xsl:template>

<!-- preProcessingStep is optional, unbounded -->
<xsl:template match="alto:preProcessingStep">
    <xsl:apply-templates select="alto:processingDateTime"/>
    <xsl:apply-templates select="alto:processingAgency"/>
    <xsl:apply-templates select="alto:processingStepDescription"/>
    <xsl:apply-templates select="alto:processingStepSettings"/>
    <xsl:apply-templates select="alto:processingSoftware"/>
</xsl:template>

<!-- ocrProcessingStep is mandatory, singleton -->
<xsl:template match="alto:ocrProcessingStep">
    <xsl:apply-templates select="alto:processingDateTime"/>
    <xsl:apply-templates select="alto:processingAgency"/>
    <xsl:apply-templates select="alto:processingStepDescription"/>
    <xsl:apply-templates select="alto:processingStepSettings"/>
    <xsl:apply-templates select="alto:processingSoftware"/>
</xsl:template>

<!-- postProcessingStep is optional, unbounded -->
<xsl:template match="alto:postProcessingStep">
    <xsl:apply-templates select="alto:processingDateTime"/>
    <xsl:apply-templates select="alto:processingAgency"/>
    <xsl:apply-templates select="alto:processingStepDescription"/>
    <xsl:apply-templates select="alto:processingStepSettings"/>
    <xsl:apply-templates select="alto:processingSoftware"/>
</xsl:template>

<!-- processingDateTime is optional -->
<xsl:template match="alto:processingDateTime">
    <br/>
    <b>Processing Date/Time - <xsl:apply-templates select="text()"/></b>
</xsl:template>

<!-- processingAgency is optional, text node -->
<xsl:template match="alto:processingAgency">
    <br/>
    <b>Processing Agency - <xsl:value-of select="text()"/></b>
</xsl:template>

<!-- processingStepDescription is optional, text node -->
<xsl:template match="alto:processingStepDescription">
    <br/>
    <b>Processing Step Description - <xsl:value-of select="text()"/></b>
</xsl:template>

<!-- processingStepSettings is optional, text node -->
<xsl:template match="alto:processingStepSettings">
    <br/>
    <br/>
    <b>Processing Step Settings:</b>
    <br/>
    <xsl:if test="@WordAccuracy">
        <br/>
	<b><xsl:value-of select="@WordAccuracy"/></b>
    </xsl:if>
    <xsl:if test="@AbbyyAccuracy">
        <br/>
	<b><xsl:value-of select="@AbbyyAccuracy"/></b>
    </xsl:if>
    <xsl:if test="@IrisAccuracy">
        <br/>
	<b><xsl:value-of select="@IrisAccuracy"/></b>
    </xsl:if>
</xsl:template>

<!-- processingSoftware is optional -->
<xsl:template match="alto:processingSoftware">
    <xsl:apply-templates select="alto:softwareCreator"/>
    <xsl:apply-templates select="alto:softwareName"/>
    <xsl:apply-templates select="alto:softwareVersion"/>
    <xsl:apply-templates select="alto:applicationDescription"/>
</xsl:template>

<!-- softwareCreator is optional, text node -->
<xsl:template match="alto:softwareCreator">
    <br/>
    <br/>
    <b>Software Creator - <xsl:value-of select="text()"/></b>
</xsl:template>

<!-- softwareName is optional, text node -->
<xsl:template match="alto:softwareName">
    <br/>
    <b>Software Name - <xsl:value-of select="text()"/></b>
</xsl:template>

<!-- softwareVersion is optional, text node -->
<xsl:template match="alto:softwareVersion">
    <br/>
    <b>Software Version - <xsl:value-of select="text()"/></b>
</xsl:template>

<!-- applicationDescription is optional, text node -->
<xsl:template match="alto:applicationDescription">
    <br/>
    <b>Application Description - </b><xsl:value-of select="text()"/>
</xsl:template>
<!-- This concludes the Description tree section -->

<!-- This begins the Styles tree section -->
<!-- Styles is optional -->
<xsl:template match="alto:Styles">
    <h3>Styles:</h3>
        <xsl:if test="count(alto:TextStyle) &gt; 0">
            <table border="1">
                <tr>
                    <th>ID</th>
                    <th>Font Size</th>
                </tr>
                <xsl:apply-templates select="alto:TextStyle"/>
            </table>
        </xsl:if>
        <xsl:if test="count(alto:paragraphStyle) &gt; 0">
            <table border="1">
                <tr>
                    <th>ID</th>
                    <th>ALIGN</th>
                    <th>LEFT</th>
                    <th>RIGHT</th>
                    <th>LINESPACE</th>
                    <th>FIRSTLINE</th>
                </tr>
                <xsl:apply-templates select="alto:paragraphStyle"/>
            </table>
        </xsl:if>
</xsl:template>

<!-- TextStyle is optional, unbounded -->
<xsl:template match="alto:TextStyle">
        <tr>
            <td><xsl:value-of select="@ID"/></td>
            <td><xsl:value-of select="@FONTSIZE"/></td>
        </tr>
</xsl:template>

<!-- paragraphStyle is optional, unbounded -->
<xsl:template match="alto:paragraphStyle">
        <tr>
            <td><xsl:value-of select="@ID"/></td>
            <td><xsl:value-of select="@ALIGN"/></td>
            <td><xsl:value-of select="@LEFT"/></td>
            <td><xsl:value-of select="@RIGHT"/></td>
            <td><xsl:value-of select="@LINESPACE"/></td>
            <td><xsl:value-of select="@FIRSTLINE"/></td>
        </tr>
</xsl:template>

<!-- This concludes the Styles tree section -->

<!-- This is the beginning of the Layout tree section -->
<!-- Description is optional -->
<xsl:template match="alto:Layout">
    <h3>Layout: <xsl:value-of select="@STYLEREFS"/></h3>
    <xsl:apply-templates select="alto:Page"/>
</xsl:template>

<!-- Page is mandatory, unbounded -->
<xsl:template match="alto:Page">
    <h3>Page - ID: <xsl:value-of select="@ID"/></h3>
    <table border="1">
        <tr>
            <th>PageClass</th>
            <th>StyleRefs</th>
            <th>Height</th>
            <th>Width</th>
            <th>Physical Image Number</th>
            <th>Printed Image Number</th>
            <th>Quality</th>
            <th>Position</th>
            <th>Processing</th>
            <th>Page Confidence</th>
        </tr>
        <tr>
            <td><xsl:value-of select="@PAGECLASS"/></td>
            <td><xsl:value-of select="@STYLEREFS"/></td>
            <td><xsl:value-of select="@HEIGHT"/></td>
            <td><xsl:value-of select="@WIDTH"/></td>
            <td><xsl:value-of select="@PHYSICAL_IMG_NR"/></td>
            <td><xsl:value-of select="@PRINTED_IMG_NR"/></td>
            <td><xsl:value-of select="@QUALITY"/></td>
            <td><xsl:value-of select="@POSITION"/></td>
            <td><xsl:value-of select="@PROCESSING"/></td>
            <td><xsl:value-of select="@PC"/></td>
        </tr>
    </table>
    <xsl:apply-templates select="alto:TopMargin"/>
    <xsl:apply-templates select="alto:LeftMargin"/>   
    <xsl:apply-templates select="alto:RightMargin"/>
    <xsl:apply-templates select="alto:BottomMargin"/>
    <xsl:apply-templates select="alto:PrintSpace"/>
</xsl:template>

<!-- PrintSpace is optional -->
<xsl:template match="alto:PrintSpace">
    <h3>PrintSpace - ID: <xsl:value-of select="@ID"/></h3>
    <table border="1">
        <tr>
            <th>StyleRefs</th>
            <th>Height</th>
            <th>Width</th>
            <th>Horizontal Position</th>
            <th>Vertical Position</th>
        </tr>
        <tr>
            <td><xsl:value-of select="@STYLEREFS"/></td>
            <td><xsl:value-of select="@HEIGHT"/></td>
            <td><xsl:value-of select="@WIDTH"/></td>
            <td><xsl:value-of select="@HPOS"/></td>
            <td><xsl:value-of select="@VPOS"/></td>
        </tr>
    </table>
    <!-- apply any and all Block Groups below PrintSpace -->
    <xsl:apply-templates select="alto:TextBlock"/>
    <xsl:apply-templates select="alto:Illustration"/>
    <xsl:apply-templates select="alto:GraphicalElement"/>
    <xsl:apply-templates select="alto:ComposedBlock"/>
</xsl:template>

<xsl:template match="alto:TextBlock">
    <h3>Text Block - ID: <xsl:value-of select="@ID"/></h3>
    <!-- <p>Accuracy Threshold: <xsl:value-of select="$ocrPercent"/></p> -->
    <table border="1">
        <tr>
            <th>StyleRefs</th>
            <th>Height</th>
            <th>Width</th>
            <th>Horizontal Position</th>
            <th>Vertical Position</th>
            <th>Rotation</th>
            <th>Next ID</th>
            <th>Language</th>
        </tr>
        <tr>
    		<td>
				    <xsl:choose>
					    <xsl:when test="@STYLEREFS">
						    <xsl:value-of select="@STYLEREFS"/>
					    </xsl:when>
					    <xsl:otherwise>
						    &nbsp;
					    </xsl:otherwise>
				    </xsl:choose>
    		</td>
    		<td>
				    <xsl:choose>
					    <xsl:when test="@HEIGHT">
						    <xsl:value-of select="@HEIGHT"/>
					    </xsl:when>
					    <xsl:otherwise>
						    &nbsp;
					    </xsl:otherwise>
				    </xsl:choose>
    		</td>
    		<td>
				    <xsl:choose>
					    <xsl:when test="@WIDTH">
						    <xsl:value-of select="@WIDTH"/>
					    </xsl:when>
					    <xsl:otherwise>
						    &nbsp;
					    </xsl:otherwise>
				    </xsl:choose>
    		</td>
    		<td>
				    <xsl:choose>
					    <xsl:when test="@HPOS">
						    <xsl:value-of select="@HPOS"/>
					    </xsl:when>
					    <xsl:otherwise>
						    &nbsp;
					    </xsl:otherwise>
				    </xsl:choose>
    		</td>
    		<td>
				    <xsl:choose>
					    <xsl:when test="@VPOS">
						    <xsl:value-of select="@VPOS"/>
					    </xsl:when>
					    <xsl:otherwise>
						    &nbsp;
					    </xsl:otherwise>
				    </xsl:choose>
    		</td>
    		<td>
				    <xsl:choose>
					    <xsl:when test="@ROTATION">
						    <xsl:value-of select="@ROTATION"/>
					    </xsl:when>
					    <xsl:otherwise>
						    &nbsp;
					    </xsl:otherwise>
				    </xsl:choose>
    		</td>
    		<td>
				    <xsl:choose>
					    <xsl:when test="@IDNEXT">
						    <xsl:value-of select="@IDNEXT"/>
					    </xsl:when>
					    <xsl:otherwise>
						    &nbsp;
					    </xsl:otherwise>
				    </xsl:choose>
    		</td>
    		<td>
				    <xsl:choose>
					    <xsl:when test="@language">
						    <xsl:value-of select="@language"/>
					    </xsl:when>
					    <xsl:otherwise>
						    &nbsp;
					    </xsl:otherwise>
				    </xsl:choose>
    		</td>
        </tr>
    </table>
    <xsl:apply-templates select="alto:TextLine"/>
</xsl:template>

<xsl:template match="alto:TextLine">
    <br/>
    <xsl:for-each select="*">
        <xsl:if test="name() = 'String'">
        <!--
            <xsl:if test="@WC &gt; $accuracyThreshold">
            <xsl:if test="@WC &gt; $ocrPercent">
        -->
        	<xsl:choose>
	        	<xsl:when test="@WC">
		            <xsl:if test="@WC &gt; $ocrPercent">
   			            <xsl:value-of select="@CONTENT"/>
       			    </xsl:if>
       			</xsl:when>
       			<xsl:otherwise>
		            <xsl:value-of select="@CONTENT"/>
       			</xsl:otherwise>
       		</xsl:choose>
        </xsl:if>
        <xsl:if test="name() = 'SP'">
            &nbsp;
        </xsl:if>
        <xsl:if test="name() = 'HYP'">
            -
        </xsl:if>
    </xsl:for-each>
</xsl:template>

<xsl:template match="alto:String">
    <b><xsl:value-of select="@CONTENT"/></b>
</xsl:template>

<xsl:template match="alto:SP">
    _
</xsl:template>

<xsl:template match="alto:HYP">
    -
</xsl:template>

<xsl:template match="alto:Illustration">
    <h2>Layout/Page/PrintSpace/Illustration not yet implemented</h2>
</xsl:template>

<xsl:template match="alto:GraphicalElement">
    <h2>Layout/Page/PrintSpace/GraphicalElement not yet implemented</h2>
</xsl:template>

<xsl:template match="alto:ComposedBlock">
    <h2>Layout/Page/PrintSpace/ComposedBlock not yet implemented</h2>
</xsl:template>

<!-- TopMargin is optional -->
<!-- Top, Bottom, Left and Right Margin are all of type PageSpaceType, the
     same as PrintSpace -->
<xsl:template match="alto:TopMargin">
    <h2>Layout/Page/TopMargin not yet implemented</h2>
</xsl:template>

<!-- BottomMargin is optional -->
<xsl:template match="alto:BottomMargin">
    <h2>Layout/Page/BottomMargin not yet implemented</h2>
</xsl:template>

<!-- LeftMargin is optional -->
<xsl:template match="alto:LeftMargin">
    <h2>Layout/Page/LeftMargin not yet implemented</h2>
</xsl:template>

<!-- RightMargin is optional -->
<xsl:template match="alto:RightMargin">
    <h2>Layout/Page/RightMargin not yet implemented</h2>
</xsl:template>

<!-- This concludes the Layout tree section -->
</xsl:stylesheet> 