package edu.vtc.outlier;

import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.XMLReader;
import org.xml.sax.helpers.XMLReaderFactory;
import org.xml.sax.helpers.DefaultHandler;

/**
 * This class verifies that the total number of hours mentioned in the list of topics is consistent with the number of
 * hours mentioned in the summary.
 */
public class CountHours extends DefaultHandler {

    // These URLs are standard and are just meant to be globally unique IDs.
    private static final String VALIDATION_FEATURE_ID =
        "http://xml.org/sax/features/validation";

    // This is, apparently, Xerces specific.
    private static final String VALIDATION_SCHEMA_ID =
        "http://apache.org/xml/features/validation/schema";

    // Replace this with the name of any suitable SAX parser class.
    private static final String DEFAULT_PARSER_NAME =
        "org.apache.xerces.parsers.SAXParser";

    // Holds the number of lecture hours per week for this course.
    private float lectureHours;

    // Holds the total number of topic hours for this course.
    private float totalHours = 0.0F;


    //
    // Public methods.
    // These are callbacks that are invoked by the parser whenever an event occurs.
    //
    @Override
    public void startElement(
        String namespace, String elementName, String rawName, Attributes attrs)
            throws NumberFormatException
    {
        if (elementName.compareTo("time") == 0) {
            lectureHours = Float.parseFloat(attrs.getValue("lecture"));
            System.out.println("Lecture " + lectureHours + " hrs/wk");
        }
        else if (elementName.compareTo("topic") == 0) {
            int hoursIndex = attrs.getIndex("hours");
            if (hoursIndex != -1) {
                totalHours += Float.parseFloat(attrs.getValue(hoursIndex));
            }
        }
    }

    @Override
    public void endDocument()
    {
        if (Math.abs((14.0F * lectureHours) - totalHours) > 0.01F) {
            System.out.println(
                "Warning! Hours assigned to topics inconsistent with lecture hours.");
        }
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
        CountHours hoursCounter = new CountHours();
        XMLReader parser;

        try {
            // Create parser and turn on desired features.
            parser = XMLReaderFactory.createXMLReader(DEFAULT_PARSER_NAME);
            parser.setFeature(VALIDATION_FEATURE_ID, true);
            parser.setFeature(VALIDATION_SCHEMA_ID, true);

            System.out.println("Checking file: " + argv[0]);

            // Parse file.
            parser.setContentHandler(hoursCounter);
            // parser.setErrorHandler(hoursCounter);
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
