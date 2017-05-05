<?xml version="1.0" encoding="UTF-8"?>

<!-- FILE    : COML.xsl
     AUTHOR  : (C) Copyright 2010 by Vermont Technical College
     SUBJECT : Style sheet to convert COML outlines into XHTML.
  
  To Do:
  
  + Various things.
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:coml="http://www.vtc.vsc.edu/COML_0.0">
  <xsl:output method="html"/>

  <!-- This template handles the overall outline element. -->
  <xsl:template match="coml:outline">
    <html>
      <head>
        <title>Course Evaluation: <xsl:value-of select="coml:summary/coml:title"/></title>
      </head>
      <body>
        <center><font size="+1">COURSE EVALUATION<br/>
            <xsl:value-of select="coml:summary/coml:title"/> (<xsl:value-of select="coml:number"/>)
          </font></center>
        <h3>General Information</h3>
        <p><table border="1">
            <tbody>
              <tr>
                <th width="300">Term</th><th width="300">Instructor</th><th width="300"
                  >Date</th>
              </tr>
              <tr>
                <td>&#160;</td><td>&#160;</td><td>&#160;</td>
              </tr>
            </tbody>
          </table></p>
        <h3>Objectives</h3>
        <p><table border="1">
            <tr><th width="20"/>
              <th width="35%">Objective</th>
              <th width="40">N/E</th>
              <th width="40">% met</th>
              <th>Proposed Changes</th>
              <th>Departmental Action</th></tr>
            <xsl:apply-templates select="objectives"/>
          </table></p>
        <h3>Textbook Information</h3>
        <p><table border="1">
            <tbody>
              <tr>
                <th width="35%">Text(s)</th><th width="30%">Proposed Changes</th><th width="30%"
                  >Departmental Action</th>
              </tr>
              <tr>
                <td><xsl:apply-templates select="coml:texts"/></td><td>&#160;</td><td>&#160;</td>
              </tr>
            </tbody>
          </table></p>
        <h3>Prerequisite and Corequisite Information</h3>
        <p><table border="1">
            <tbody>
              <tr>
                <th width="35%">Prerequisites</th><th width="30%">Proposed Changes</th><th
                  width="30%">Departmental Action</th>
              </tr>
              <tr>
                <td><xsl:apply-templates select="coml:summary/coml:prerequisites"
                  /></td><td>&#160;</td><td>&#160;</td>
              </tr>
            </tbody>
          </table></p>
        <xsl:if test="coml:summary/coml:corequisites">
          <p><table border="1">
              <tbody>
                <tr>
                  <th width="35%">Corequisites</th><th width="30%">Proposed Changes</th><th
                    width="30%">Departmental Action</th>
                </tr>
                <tr>
                  <td><xsl:apply-templates select="coml:summary/coml:corequisites"
                    /></td><td>&#160;</td><td>&#160;</td>
                </tr>
              </tbody>
            </table></p>
        </xsl:if>
        <!-- &copy; --> Copyright 2010 by <a href="http://www.vtc.edu/">Vermont Technical
          College</a>
      </body>
    </html>
  </xsl:template>

  <!-- The following formats the objectives list. -->
  <xsl:template match="coml:objectives">
    <xsl:for-each select="coml:objective">
      <tr>
        <td align="right" valign="top">
          <xsl:number/>
        </td>
        <td><xsl:value-of select="."/> (<b><xsl:value-of select="@support"/></b>)</td>
        <td>&#160;</td>
        <td>&#160;</td>
        <td>&#160;</td>
        <td>&#160;</td>
      </tr>
    </xsl:for-each>
  </xsl:template>

  <!-- All of the templates below are taken from COM.xsl. Is there a way to share templates between files (some kind of inclusion facility for XSLT?) -->

  <!-- The following formats the text list. -->
  <xsl:template match="coml:texts">
    <xsl:for-each select="coml:book">
      <i><xsl:text> </xsl:text><xsl:value-of select="coml:title"/></i>
      <xsl:if test="coml:edition"><xsl:text> </xsl:text><xsl:value-of select="coml:edition"/>
        edition</xsl:if> by <xsl:value-of select="coml:author"/>. <xsl:if test="coml:publisher"> Published
        by <xsl:value-of select="coml:publisher"/>.</xsl:if>
      <xsl:if test="coml:copyright"> Copyright <xsl:value-of select="coml:copyright"/>.</xsl:if>
      <xsl:if test="coml:ISBN"> ISBN=<xsl:value-of select="coml:ISBN"/>.</xsl:if>
    </xsl:for-each>
  </xsl:template>

  <!-- The following formats the prerequisites or the corequisites lists. -->
  <xsl:template match="coml:prerequisites|coml:corequisites">
    <xsl:apply-templates select="coml:AND"/>
  </xsl:template>

  <!-- Most of the difficult work is in formatting the AND and OR groups. -->
  <xsl:template match="coml:AND">
    <xsl:text>{AND: </xsl:text>
    <xsl:for-each select="coml:course">
      <a><xsl:attribute name="href"><xsl:value-of select="."/>.xml</xsl:attribute><xsl:value-of
          select="."/></a>. </xsl:for-each>
    <xsl:for-each select="coml:other">
      <xsl:value-of select="."/>. </xsl:for-each>
    <xsl:for-each select="coml:OR">
      <xsl:apply-templates select="."/>
    </xsl:for-each>
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="coml:OR">
    <xsl:text>{OR: </xsl:text>
    <xsl:for-each select="coml:course">
      <a><xsl:attribute name="href"><xsl:value-of select="."/>.xml</xsl:attribute><xsl:value-of
          select="."/></a>. </xsl:for-each>
    <xsl:for-each select="coml:other">
      <xsl:value-of select="."/>. </xsl:for-each>
    <xsl:for-each select="coml:AND">
      <xsl:apply-templates select="coml:AND"/>
    </xsl:for-each>
    <xsl:text>}</xsl:text>
  </xsl:template>

</xsl:stylesheet>
