<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xpath-default-namespace="http://www.tei-c.org/ns/1.0"
   exclude-result-prefixes="xs"
   version="2.0">
   
   <xsl:output method="xhtml" encoding="UTF-8" indent="no"/>
   
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
         <xsl:apply-templates select="descendant::titleStmt"/>
         <meta charset="utf-8"></meta>
      </head>
   </xsl:template>
   
   <xsl:template match="titleStmt">
      <title>
         <xsl:value-of select="concat(title, ' - ', author)"/>
      </title>
   </xsl:template>
   
   <xsl:template match="titleStmt" mode="body">
      <h1>
         <xsl:value-of select="concat(title, ' par ', author)"/>
      </h1>
   </xsl:template>
   
   <xsl:template match="body">
      <body>
         <header>
            <xsl:apply-templates select="//titleStmt" mode="body"/>
            <p>Nombre de séances : <xsl:value-of select="count(.//div[@type='seance'])"/></p>
            <nav>
               <ul>
                  <xsl:apply-templates select=".//div[@type='seance']" mode="toc"/>
               </ul>
            </nav>
         </header>
         <xsl:apply-templates/>
         <xsl:apply-templates select="//publicationStmt"/>
      </body>
   </xsl:template>
   
   <xsl:template match="div[@type='annee']">
      <main>
         <xsl:apply-templates/>
      </main>
   </xsl:template>
   
   <xsl:template match="div[@type='annee']/head">
      <h2>
         <xsl:apply-templates/>
      </h2>
   </xsl:template>
   
   <xsl:template match="div[@type='seance']">
      <article id="{@xml:id}">
         <h3>
            <xsl:apply-templates select="head"/>
            <xsl:text> </xsl:text>
            <xsl:apply-templates select="dateline"/>
         </h3>
         <xsl:apply-templates select="./div[@type='ordreJour']"/>
         <aside>
            <xsl:apply-templates select=".//note" mode="footnote"/>
         </aside>
      </article>
   </xsl:template>
   
   <xsl:template match="div[@type='seance']" mode="toc">
      <li>
         <a href="#{@xml:id}">
            <xsl:apply-templates select="head"/>
            <xsl:text> </xsl:text>
            <xsl:apply-templates select="dateline"/>
         </a>
      </li>
   </xsl:template>
  
   <xsl:template match="div[@type='ordreJour']">
      <section>
         <xsl:apply-templates/>
      </section>
   </xsl:template>
   
   <xsl:template match="p">
      <p>
         <xsl:if test="@rend">
            <xsl:attribute name="class" select="@rend"/>
         </xsl:if>
         <xsl:apply-templates/>
      </p>
   </xsl:template>
   
   <xsl:template match="pb">
      <xsl:text>[</xsl:text><xsl:value-of select="replace(@n, '_', ' ')"/><xsl:if test="@rend='empty'"><xsl:text> vierge</xsl:text></xsl:if><xsl:text>]</xsl:text>
   </xsl:template>
   
   <xsl:template match="date">
      <time datetime="{@when}"><xsl:apply-templates/></time>
   </xsl:template>
   
   <xsl:template match="add">
      <xsl:text>|</xsl:text><xsl:apply-templates/><xsl:text>|</xsl:text>
   </xsl:template>
   
   <xsl:template match="del">
      <xsl:text>&lt;</xsl:text><xsl:apply-templates/><xsl:text>&gt;</xsl:text>
   </xsl:template>
   
   <xsl:template match="unclear">
      <xsl:text>[</xsl:text><xsl:apply-templates/><xsl:text> ?]</xsl:text>
   </xsl:template>
   
   <xsl:template match="supplied">
      <xsl:text>[</xsl:text><xsl:apply-templates/><xsl:text>]</xsl:text>
   </xsl:template>
   
   <xsl:template match="sic">
      <xsl:apply-templates/><xsl:text> (</xsl:text><em>sic</em><xsl:text>)</xsl:text>
   </xsl:template>
   
   <xsl:template match="gap">
      <xsl:text>[…]</xsl:text>
   </xsl:template>
   
   <xsl:template match="q">
      <q><xsl:apply-templates/></q>
   </xsl:template>
   
   <xsl:template match="list">
      <ul><xsl:apply-templates/></ul>
   </xsl:template>
   
   <xsl:template match="item">
      <li><xsl:apply-templates/></li>
   </xsl:template>
   
   <xsl:template match="hi">
      <xsl:choose>
         <xsl:when test="@rend = 'superscript'">
            <sup><xsl:apply-templates/></sup>
         </xsl:when>
         <xsl:when test="@rend = 'underline'">
            <u><xsl:apply-templates/></u>
         </xsl:when>
         <xsl:otherwise>
            <span class="{@rend}"><xsl:apply-templates/></span>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   
   <xsl:template match="note">
      <sup><xsl:number count="note" from="div[@type='seance']" level="any"/></sup>
   </xsl:template>
   
   <xsl:template match="note" mode="footnote">
      <p>
         <small>
            <sup><xsl:number count="note" from="div[@type='seance']" level="any"/></sup>
            <xsl:apply-templates/>
         </small>
      </p>
   </xsl:template>
   
   <xsl:template match="publicationStmt">
      <footer>
         <xsl:apply-templates/>
         <small>Feuille XSLT réalisée sans ChatGPT…</small>
      </footer>
   </xsl:template>
   
   <xsl:template match="publisher | address">
      <p><xsl:apply-templates/></p>
   </xsl:template>
   
   <xsl:template match="addrLine">
      <xsl:apply-templates/><br/>
   </xsl:template>
   
</xsl:stylesheet>