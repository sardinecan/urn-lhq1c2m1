<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   exclude-result-prefixes="xs"
   version="2.0">
   
<!--  
   <?xml version="1.0" encoding="UTF-8"?>
<data>
   <s>Hello 
      <emph>World</emph>
      !</s>
</data>
   -->
   
   <xsl:template match="/">
      <xsl:apply-templates/>
   </xsl:template>
   
   <xsl:template match="*:s">
      résultat apply-templates : 
         <xsl:apply-templates/>
      
      
      Résultat value-of : 
         <xsl:value-of select="."/>
   </xsl:template>
   
   <xsl:template match="emph">
      *<xsl:apply-templates/>*
   </xsl:template>
   
</xsl:stylesheet>