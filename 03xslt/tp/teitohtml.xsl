<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xpath-default-namespace="http://www.tei-c.org/ns/1.0"
   exclude-result-prefixes="xs"
   version="2.0">
   
   <xsl:output method="html" indent="yes"/>
   <xsl:strip-space elements="*"/>
   
   <xsl:template match="/">
      <xsl:apply-templates/>
   </xsl:template>
   
   <xsl:template match="TEI">
      <html>
         <xsl:apply-templates/>
      </html>
   </xsl:template>
   
   <xsl:template match="teiHeader">
      <head>
         <title>
            <xsl:value-of select="fileDesc/titleStmt/title[@type='main']"/>
         </title>
      </head>
   </xsl:template>
   
   <xsl:template match="body">
      <body>
         <xsl:apply-templates/>
      </body>
   </xsl:template>
   
</xsl:stylesheet>