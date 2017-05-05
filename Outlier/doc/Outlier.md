
Outlier
=======

The purpose of Outlier is to perform various semantic checks on course outlines that can't
otherwise be (easily) handled in the schema or by a style sheet. Some of the checks that might
be worth doing are:

+ That all the hours in the course content add up to the right number. The number of weeks of
  the course is implied but the hours of lecture per week is explicit in the <time> element.

+ That the number of words in the course description is limited to 150.

+ That there are no cycles in the pre-requisites (or any other pre/co-requisite anomalies).

It would also be nice if Outlier could produce a report showing which outlines need review and
the "owner" (author) responsible for that review. Another goal of the COML project was to
extract recently changed summary information from the outlines and format it for delivery to
those responsible for the college catalog. The idea was to keep the catalog up-to-date in a
semi-automatic way. Outlier should do this as well.
