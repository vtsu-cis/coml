package edu.vtc.outlier;

import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;
import javax.xml.validation.Schema;
import javax.xml.validation.SchemaFactory;

import org.xml.sax.*;
import org.xml.sax.helpers.DefaultHandler;

import java.io.File;

/**
 * This class verifies that the total number of hours mentioned in the list of topics is
 * consistent with the number of hours mentioned in the summary.
 */
public class CountHours extends DefaultHandler {

    // Holds the number of lecture hours per week for this course.
    private float lectureHours;

    // Holds the total number of topic hours for this course.
    private float totalHours = 0.0F;

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
    public void startElement(
        String namespace, String elementName, String rawName, Attributes attrs)
            throws NumberFormatException
    {
       if (elementName.equals("time")) {
            lectureHours = Float.parseFloat(attrs.getValue("lecture"));
            System.out.println("Lecture " + lectureHours + " hrs/wk");
        }
        else if (elementName.equals("topic")) {
            String hoursString = attrs.getValue("hours");
            System.out.println("Found topic! hoursString = " + hoursString);
            if (hoursString != null) {
                totalHours += Float.parseFloat(hoursString);
            }
            //int hoursIndex = attrs.getIndex("hours");
            //if (hoursIndex != -1) {
            //    totalHours += Float.parseFloat(attrs.getValue(hoursIndex));
            //}
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

            // Create the parser.
            parser = factory.newSAXParser();

            // Parse file.
            System.out.println("Checking file: " + argv[0]);
            reader = parser.getXMLReader();
            reader.setContentHandler(hoursCounter);
            reader.setErrorHandler(hoursCounter);
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
