<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:mix="http://www.loc.gov/mix/" version="1.0">
    <xsl:output method="xml" indent="yes" />
    <xsl:param name="isMaster" />

    <xsl:template match="mix:mix">        
        <xsl:copy>
            <xsl:apply-templates select="mix:*"/>
        </xsl:copy>
    </xsl:template>        

    <!--        
    <xsl:template match="mix:BasicImageParameters | mix:Format | mix:Compression | mix:CompressionScheme | mix:PhotometricInterpretation | mix:ColorSpace">
        <xsl:if test="boolean($isMaster)">
            <xsl:copy>
                <xsl:apply-templates select="@*|node()|mix:*|text()"/>
            </xsl:copy>
        </xsl:if>
    </xsl:template>    
    -->

    <xsl:template match="mix:BasicImageParameters | mix:Format">
        <xsl:if test="boolean($isMaster)">
            <xsl:copy>
                <xsl:apply-templates select="mix:*"/>
            </xsl:copy>
        </xsl:if>
    </xsl:template>        
        
    <xsl:template match="mix:Compression | mix:PhotometricInterpretation">
        <xsl:if test="boolean($isMaster)">
            <xsl:copy-of select="." />
        </xsl:if>
    </xsl:template>    
    
    <xsl:template match="mix:ImageCreation | mix:ScanningSystemCapture">
        <xsl:if test="boolean($isMaster) or boolean(mix:ImageProducer)">
            <xsl:copy>
                <xsl:apply-templates select="mix:*"/>
            </xsl:copy>
        </xsl:if>
    </xsl:template>    

    <xsl:template match="mix:SourceType | mix:ScanningSystemHardware">
        <xsl:if test="boolean($isMaster)">
            <xsl:copy-of select="." />
        </xsl:if>
    </xsl:template>    
    
    <xsl:template match="mix:ImageProducer">
        <xsl:copy-of select="." />
    </xsl:template>
    
    <xsl:template match="mix:ImagingPerformanceAssessment | mix:SpatialMetrics">
        <xsl:copy>
            <xsl:apply-templates select="mix:*"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="mix:SamplingFrequencyUnit | mix:XSamplingFrequency | mix:YSamplingFrequency | mix:ImageWidth | mix:ImageLength">
        <xsl:copy-of select="." />
    </xsl:template>
    
    <xsl:template match="mix:Energetics">
        <xsl:if test="boolean($isMaster)">
            <xsl:copy>
                <xsl:apply-templates select="mix:*"/>
            </xsl:copy>
        </xsl:if>
    </xsl:template>    

    <xsl:template match="mix:BitsPerSample">
        <xsl:if test="boolean($isMaster)">
            <xsl:copy-of select="." />
        </xsl:if>
    </xsl:template>    

    <!--
    <xsl:template match="mix:ChangeHistory | mix:ImageProcessing">
        <xsl:copy>
            <xsl:apply-templates select="mix:*"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="mix:ProcessingAgency">
        <xsl:copy-of select="." />
    </xsl:template>
    -->
    
    <xsl:template match="*" />
    
    <xsl:template match="text()|@*" />    
    
</xsl:stylesheet>

