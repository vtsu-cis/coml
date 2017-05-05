@echo off

set CLASSPATH=c:\lib\xalan-j_2_7_1\xalan.jar
set CLASSPATH=%CLASSPATH%;c:\lib\xalan-j_2_7_1\xml-apis.jar
set CLASSPATH=%CLASSPATH%;c:\lib\xalan-j_2_7_1\xercesImpl.jar

java org.apache.xalan.xslt.Process -IN %1 -XSL COML.xsl -OUT %2
