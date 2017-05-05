<?xml version="1.0" ?>

<!-- FILE    : COML.xsl
     AUTHOR  : (C) Copyright 2014 by Vermont Technical College
     SUBJECT : Style sheet to convert COML outlines into XHTML.
     
To Do:

+ Various things.
-->

<xsl:stylesheet version="1.0" xmlns:coml="http://www.vtc.vsc.edu/COML_0.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://www.w3.org/1999/xhtml">

  <xsl:output method="xml"/>

  <!-- This template handles the overall outline element. -->
  <xsl:template match="coml:outline">
    <html>
      <head>
        <title>Course Outline: <xsl:value-of select="coml:summary/coml:title"/></title>
        <!-- <link rel="stylesheet" href="ecet.css" type="text/css"/> -->
      </head>
      <body>
        <p align="center"><font size="+1">
            <a href="http://www.vtc.edu/">VERMONT TECHNICAL COLLEGE</a>
          </font><br/> Randolph Center, Vermont</p>
        <p align="center">COURSE OUTLINE</p>
        <table border="0" cellspacing="10">
          <tr>
            <td valign="top">
              <p>
                <u>DEPARTMENT/PROGRAM</u>
              </p>
            </td>
            <td>
              <p>
                <xsl:value-of select="coml:summary/coml:department-program"/>
              </p>
            </td>
          </tr>
          <tr>
            <td valign="top">
              <p>
                <u>COURSE NUMBER</u>
              </p>
            </td>
            <td>
              <p>
                <xsl:value-of select="coml:summary/coml:number"/>
              </p>
            </td>
          </tr>
          <tr>
            <td valign="top">
              <p>
                <u>REVISION DATE</u>
              </p>
            </td>
            <td>
              <p>
                <xsl:value-of select="@revision"/>
              </p>
            </td>
          </tr>
          <tr>
            <td valign="top">
              <p>
                <u>COURSE TITLE</u>
              </p>
            </td>
            <td>
              <p>
                <xsl:value-of select="coml:summary/coml:title"/>
              </p>
            </td>
          </tr>
          <tr>
            <td valign="top">
              <p>
                <u>COURSE DESCRIPTION</u>
              </p>
            </td>
            <td>
              <p>
                <xsl:value-of select="coml:summary/coml:description"/>
              </p>
            </td>
          </tr>
          <xsl:if test="coml:summary/coml:prerequisites">
            <tr>
              <td valign="top">
                <p>
                  <u>PREREQUISITES</u>
                </p>
              </td>
              <td>
                <xsl:apply-templates select="coml:summary/coml:prerequisites"/>
              </td>
            </tr>
          </xsl:if>
          <xsl:if test="coml:summary/coml:corequisites">
            <tr>
              <td valign="top">
                <p>
                  <u>CO-REQUISITES</u>
                </p>
              </td>
              <td>
                <xsl:apply-templates select="coml:summary/coml:corequisites"/>
              </td>
            </tr>
          </xsl:if>
          <tr>
            <td valign="top">
              <p>
                <u>TIME</u>
              </p>
            </td>
            <td>
              <p><xsl:apply-templates select="coml:summary/coml:time"/> (<xsl:value-of
                  select="coml:summary/coml:credits"/> credits)</p>
            </td>
          </tr>
          <xsl:if test="coml:required-texts">
            <tr>
              <td valign="top">
                <xsl:choose>
                  <xsl:when test="count(coml:required-texts/coml:book) = 1">
                    <p>
                      <u>REQUIRED TEXT</u>
                    </p>
                  </xsl:when>
                  <xsl:otherwise>
                    <p>
                      <u>REQUIRED TEXTS</u>
                    </p>
                  </xsl:otherwise>
                </xsl:choose>
              </td>
              <td>
                <p>
                  <xsl:apply-templates select="coml:required-texts"/>
                </p>
              </td>
            </tr>
          </xsl:if>
          <xsl:if test="coml:optional-texts">
            <tr>
              <td valign="top">
                <xsl:choose>
                  <xsl:when test="count(coml:optional-texts/coml:book) = 1">
                    <p>
                      <u>OPTIONAL TEXT</u>
                    </p>
                  </xsl:when>
                  <xsl:otherwise>
                    <p>
                      <u>OPTIONAL TEXTS</u>
                    </p>
                  </xsl:otherwise>
                </xsl:choose>
              </td>
              <td>
                <p>
                  <xsl:apply-templates select="coml:optional-texts"/>
                </p>
              </td>
            </tr>
          </xsl:if>
          <tr>
            <td valign="top">
              <p>
                <u>OUTCOMES</u>
              </p>
            </td>
            <td>
              <p>Students who complete this course should be able to</p>
              <p>
                <xsl:apply-templates select="coml:course-outcomes"/>
              </p>
            </td>
          </tr>
          <tr>
            <td valign="top">
              <p>
                <u>CONTENT</u>
              </p>
            </td>
            <td>
              <p>
                <xsl:apply-templates select="coml:course-content"/>
              </p>
            </td>
          </tr>
          <xsl:if test="coml:laboratory-studio-outcomes">
            <tr>
              <td valign="top">
                <p>
                  <u>LABORATORY/STUDIO OUTCOMES</u>
                </p>
              </td>
              <td>
                <p>
                  <xsl:apply-templates select="coml:laboratory-studio-outcomes"/>
                </p>
              </td>
            </tr>
          </xsl:if>
          <xsl:if test="coml:laboratory-studio-content">
            <tr>
              <td valign="top">
                <p>
                  <u>LABORATORY/STUDIO CONTENT</u>
                </p>
              </td>
              <td>
                <p>
                  <xsl:apply-templates select="coml:laboratory-studio-content"/>
                </p>
              </td>
            </tr>
          </xsl:if>
          <xsl:if test="coml:additional-information">
            <tr>
              <td valign="top">
                <p>
                  <u>ADDITIONAL INFORMATION</u>
                </p>
              </td>
              <td>
                <p>
                  <i>
                    <xsl:value-of select="coml:additional-information"/>
                  </i>
                </p>
              </td>
            </tr>
          </xsl:if>
        </table>
        <!-- Footer -->
        <hr/>
        <!-- &copy; --> Copyright 2003-2013 by <a href="http://www.vtc.edu/">Vermont Technical
          College</a>
      </body>
    </html>
  </xsl:template>

  <!-- ======================= -->
  <!-- PREREQUISITE FORMATTING -->
  <!-- ======================= -->

  <xsl:template match="coml:prerequisites|coml:corequisites">
    <xsl:apply-templates select="coml:AND"/>
  </xsl:template>

  <!-- Most of the difficult work is in formatting the AND and OR groups. -->
  <xsl:template match="coml:AND">
    <xsl:text>{AND: </xsl:text>
    <xsl:for-each select="coml:course">
      <a>
        <xsl:attribute name="href"><xsl:value-of select="."/>.xml</xsl:attribute>
        <xsl:value-of select="."/>
      </a>. </xsl:for-each>
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
      <a>
        <xsl:attribute name="href"><xsl:value-of select="."/>.xml</xsl:attribute>
        <xsl:value-of select="."/>
      </a>. </xsl:for-each>
    <xsl:for-each select="coml:other">
      <xsl:value-of select="."/>. </xsl:for-each>
    <xsl:for-each select="coml:AND">
      <xsl:apply-templates select="coml:AND"/>
    </xsl:for-each>
    <xsl:text>}</xsl:text>
  </xsl:template>

  <!-- =============== -->
  <!-- MISC FORMATTING -->
  <!-- =============== -->

  <!-- The following formats the time information. -->
  <xsl:template match="coml:time">
    <xsl:if test="@lecture">Lecture: <xsl:value-of select="@lecture"/> hrs/wk.</xsl:if>
    <xsl:if test="@laboratory"> Laboratory: <xsl:value-of select="@laboratory"/>
      hrs/wk.</xsl:if>
    <xsl:if test="@studio"> Studio: <xsl:value-of select="@studio"/> hrs/wk.</xsl:if>
    <xsl:if test="@recitation"> Recitation: <xsl:value-of select="@recitation"/>
      hrs/wk.</xsl:if>
    <xsl:if test="@study"> Study: <xsl:value-of select="@study"/> hrs/wk.</xsl:if>
  </xsl:template>

  <!-- The following formats the text list. -->
  <xsl:template match="coml:required-texts|coml:optional-texts">
    <xsl:choose>
      <xsl:when test="count(coml:book) = 1">
        <xsl:apply-templates select="coml:book"/>
      </xsl:when>
      <xsl:otherwise>
        <ol>
          <xsl:for-each select="coml:book">
            <li>
              <xsl:apply-templates select="."/>
            </li>
          </xsl:for-each>
        </ol>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- The following formats a book. -->
  <xsl:template match="coml:book">
    <i>
      <xsl:value-of select="coml:title"/>
    </i>
    <xsl:if test="coml:edition">
      <xsl:text> </xsl:text>
      <xsl:value-of select="coml:edition"/> edition</xsl:if>
    <xsl:text> by </xsl:text>
    <xsl:apply-templates select="coml:authors"/>. <xsl:if test="coml:publisher"> Published by
        <xsl:value-of select="coml:publisher"/>.</xsl:if>
    <xsl:if test="coml:copyright"> Copyright <xsl:value-of select="coml:copyright"/>.</xsl:if>
    <xsl:if test="coml:ISBN"> ISBN=<xsl:value-of select="coml:ISBN"/>.</xsl:if>
  </xsl:template>

  <!-- The following formats an authors list. -->
  <xsl:template match="coml:authors">
    <xsl:if test="count(coml:author) = 1">
      <xsl:value-of select="coml:author"/>
    </xsl:if>
    <xsl:if test="count(coml:author) = 2">
      <xsl:value-of select="coml:author[1]"/>
      <xsl:text> and </xsl:text>
      <xsl:value-of select="coml:author[2]"/>
    </xsl:if>
    <xsl:if test="count(coml:author) > 2">
      <xsl:for-each select="coml:author">
        <xsl:if test="position() > 1">, </xsl:if>
        <xsl:if test="position() = last()">and </xsl:if>
        <xsl:value-of select="."/>
      </xsl:for-each>
    </xsl:if>
  </xsl:template>

  <!-- ================== -->
  <!-- OUTCOME FORMATTING -->
  <!-- ================== -->

  <!-- The following formats a single outcome in an outcome list. -->
  <xsl:template match="coml:outcome">
    <li>
      <xsl:value-of select="."/>
    </li>
  </xsl:template>

  <!-- The following formats a nested outcome list. -->
  <xsl:template match="coml:outcome-group">
    <li>
      <xsl:if test="coml:summary">
        <xsl:value-of select="coml:summary"/>
      </xsl:if>
      <ol>
        <xsl:apply-templates select="coml:outcome|coml:outcome-group"/>
      </ol>
    </li>
  </xsl:template>

  <!-- The formatting of a top level outcomes list is a little different than the nested lists. -->
  <xsl:template match="coml:course-outcomes|coml:laboratory-studio-outcomes">
    <xsl:if test="coml:summary">
      <p>
        <xsl:value-of select="coml:summary"/>
      </p>
    </xsl:if>
    <ol>
      <xsl:apply-templates select="coml:outcome|coml:outcome-group"/>
    </ol>
  </xsl:template>

  <!-- ================== -->
  <!-- CONTENT FORMATTING -->
  <!-- ================== -->

  <!-- The following formats a single topic in a content list. -->
  <xsl:template match="coml:topic">
    <li>
      <xsl:value-of select="."/>
      <xsl:if test="@hours"> (<xsl:value-of select="@hours"/><xsl:text> hours</xsl:text>)
      </xsl:if>
    </li>
  </xsl:template>

  <!-- The following formats a nested content list. -->
  <xsl:template match="coml:topic-group">
    <li>
      <xsl:if test="coml:summary">
        <xsl:value-of select="coml:summary"/>
      </xsl:if>
      <ul>
        <xsl:apply-templates select="coml:topic|coml:topic-group"/>
      </ul>
    </li>
  </xsl:template>

  <!-- The formatting of a top level course-count is a little different than the nested lists. -->
  <xsl:template match="coml:course-content|coml:laboratory-studio-content">
    <xsl:if test="coml:summary">
      <p>
        <xsl:value-of select="coml:summary"/>
      </p>
    </xsl:if>
    <ul>
      <xsl:apply-templates select="coml:topic|coml:topic-group"/>
    </ul>
  </xsl:template>

</xsl:stylesheet>
