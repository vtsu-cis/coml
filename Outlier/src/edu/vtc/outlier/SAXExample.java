package edu.vtc.outlier;

import org.xml.sax.*;
import org.xml.sax.helpers.DefaultHandler;

import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;
import javax.xml.validation.Schema;
import javax.xml.validation.SchemaFactory;
import java.io.File;

/**
 * This class illustrates how the SAX might be used. This example is complete enough and yet
 * generic enough to serve as a skeleton for a variety of programs that use SAX. Note that this
 * example does not do a number of things that it might do (like install an error handler).
 * However, I wanted to keep the example small and simple so that the main ideas would not be
 * obscured.
 */
public class SAXExample extends DefaultHandler implements ErrorHandler {

    // Used to hold state information from event to event.
    private String content = null;

    //
    // These are callbacks that are invoked by the parser whenever an error occurs.
    //
    @Override
    public void error(SAXParseException exception)
    {
        int lineNumber = exception.getLineNumber();
        int columnNumber = exception.getColumnNumber();
        String coordinates = "(" + lineNumber + ", " + columnNumber + ") ";

        System.out.println("*** PARSE ERROR: " + coordinates + exception.getMessage());
    }

    //
    // These are callbacks that are invoked by the parser whenever an event occurs.
    //
    @Override
    public void startDocument()
    {
        System.out.println("Document starting");
    }

    @Override
    public void endDocument()
    {
        System.out.println("Document ending");
    }

    @Override
    public void startElement(
        String namespace,
        String elementName,
        String rawName,
        Attributes attrs)
    {
        System.out.println("Entering element: " + elementName +
            " (" + attrs.getLength() + " attributes)");
        content = null;
    }

    @Override
    public void endElement(
        String namespace,
        String elementName,
        String rawName)
    {
        if (content != null) {
            System.out.println("Data: \"" + content + "\"");
        }
        content = null;
        System.out.println("Exiting element: " + elementName);
    }

    @Override
    public void characters(char[] buffer, int start, int length)
    {
        // Collect the content into a single String. The parser might call this method many
        // times if the content is long. I really have to collect the results of all calls
        // before I look too closely at it.
        //
        if (content == null) content = new String(buffer, start, length);
        else content = content + new String(buffer, start, length);
    }

    //
    // MAIN
    //

    public static void main(String[] argv) {

        // Check the command line.
        if (argv.length != 1) {
            System.err.println("Fatal: Expected URI on command line");
            return;
        }

        // Create a ContentHandler object.
        SAXExample myExample = new SAXExample();
        SAXParser parser;
        XMLReader reader;

        try {
            // Create a schema factory that supports the desired schema language:
            SchemaFactory schemaFactory =
                    SchemaFactory.newInstance("http://www.w3.org/2001/XMLSchema");
            Schema schema = schemaFactory.newSchema(new File("../COML.xsd"));

            // Create parser and turn on desired features.
            SAXParserFactory factory = SAXParserFactory.newInstance();
            factory.setSchema(schema);

            // Although it is intuitive to call this method, it isn't what is desired in this
            // situation. Calling setValidation(true) will cause the parser to expect a
            // DOCTYPE declaration in the instance document. When validating using a schema
            // that is not appropriate (setting the schema as above will implies that you want
            // validation.
            //
            //factory.setValidating(true);

            // Create the parser.
            parser = factory.newSAXParser();

            // Parse file.
            reader = parser.getXMLReader();
            reader.setContentHandler(myExample);
            reader.setErrorHandler(myExample);
            reader.parse(argv[0]);
        }
        catch (SAXException e) {
            System.err.println("Fatal: Caught SAXException: " + e);
        }
        catch (Exception e) {
            System.err.println("Fatal: Caught: " + e);
        }
    }

}
