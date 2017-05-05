package edu.vtc.outlier;

import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.XMLReader;
import org.xml.sax.helpers.XMLReaderFactory;
import org.xml.sax.helpers.DefaultHandler;

/**
 * This class illustrates how the SAX might be used. This example is complete enough and yet generic enough to serve as
 * a skeleton for a variety of programs that use SAX. Note that this example does not do a number of things that it
 * might do (like install an error handler). However, I wanted to keep the example small and simple so that the main
 * ideas would not be obscured.
 */
public class SAXExample extends DefaultHandler {

    // These URLs are standard and are just meant to be globally unique IDs.
    private static final String VALIDATION_FEATURE_ID =
        "http://xml.org/sax/features/validation";

    // This is, apparently, Xerces specific.
    private static final String VALIDATION_SCHEMA_ID =
        "http://apache.org/xml/features/validation/schema";

    // Replace this with the name of any suitable SAX parser class.
    private static final String DEFAULT_PARSER_NAME =
        "org.apache.xerces.parsers.SAXParser";

    // Used to hold state information from event to event.
    private String content = null;

    //
    // Public methods. These are callbacks that are invoked by the
    // parser whenever an event occurs.
    //
    public void startDocument()
    {
        System.out.println("Document starting");
    }

    public void endDocument()
    {
        System.out.println("Document ending");
    }

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

    public void characters(char[] buffer, int start, int length)
    {
        // Collect the content into a single String. The parser might call this method many times if the content is
        // long. I really have to collect the results of all calls before I look too closely at it.
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
        XMLReader parser;

        try {
            // Create parser and turn on desired features.
            parser = XMLReaderFactory.createXMLReader(DEFAULT_PARSER_NAME);
            parser.setFeature(VALIDATION_FEATURE_ID, true);
            parser.setFeature(VALIDATION_SCHEMA_ID, true);

            // Parse file.
            parser.setContentHandler(myExample);
            // parser.setErrorHandler(myExample);
            parser.parse(argv[0]);
        }
        catch (SAXException e) {
            System.err.println("Fatal: Caught SAXException: " + e);
        }
        catch (Exception e) {
            System.err.println("Fatal: Caught: " + e);
        }
    }

}
