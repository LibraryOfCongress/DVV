NDNP VALIDATION LIBRARY
Version 2.3.0 (VL 3.39)
April 7, 2023

DESCRIPTION:
The NDNP Validation Library (VL) is a software library intended to perform validation of data for the National Digital Newspaper Project.  It is intended for use by awardees, vendors, and NDNP staff.  The NDNP Validation Library can either be accessed via the command line or embedded in another software application (for example, the NDNP Validation Library is embedded in the NDNP Digital Viewer and Validator).  For more information on embedding the NDNP Validation Library in another application, see below.

USING THE VALIDATOR FROM THE COMMAND LINE (on Windows):
1.  From the command prompt, change to the directory in which the DVV was installed and execute ValidationProcessor.bat.
2.  Running ValidationProcessor.bat without any arguments will print a usage description.
Note:  See the Digital Viewer and Validator User's Guide regarding spaces in the file or path names.

NOTES:
1.  If you encounter memory problems, change MAXMEM in ValidationProcessor.bat.
2.  Logging is performed using the Java Logging APIs (java.util.logging).  These provide the
    user with control over the verbosity of logging, the format of logging (e.g, XML or text),
    and the type of logging (e.g., logging to file or console).  See 
    http://java.sun.com/j2se/1.5.0/docs/guide/logging/overview.html for a description of how to
    use the Java Logging APIs.  Note that validation errors are logged using the SEVERE
    log level.  Also note that logging can be controlled using bin/logging.properties.

CHANGES IN VERSION 3.39:
1. Upgraded JP2 image viewer using ImageIO library.
2. Incorporated ImageMagick version 7.1.1-4 software to facilitate JP2 to JPG conversion for upgraded JP2 viewer. 
3. Upgraded to Java 17. 
4. Upgraded to Gradle 7.6.
5. Fixed bug in Reels section that was causing null pointer errors due to incorrect reel id.
6. GUI Enhancement: Updated file path informational messages in viewer footer.
7. DOCS: Updated User Guide (PDF) to reflect updates. 

CHANGES IN VERSION 3.38:
1. Added support for validation of PDF versions 1.5, 1.6, and 1.7. 
2. Added support for validation of ALTO 3.0 and 3.1.
3. Removed 'OCR Accuracy Threshold' value from OCR tab XSL file.
4. Fixed PREMIS dateCreatedByApplication date formatting error. 

CHANGES IN VERSION 3.37:
1. GUI Bug fix: Fixed Identifier Collisions report error when LCCN not found in Chronicling America

CHANGES IN VERSION 3.36:
1. GUI Bug fix: Final verification success/failure counts reset between verification processes within same GUI session
2. GUI Bug fix: Info Tab LCCN Error Message for titles not found in Chronicling America fixed.

CHANGES IN VERSION 3.35:
1. New Feature: Implemented "Find Identifier Collisions" report.
2. GUI Bug fix: OCR and Thumbs view now update when revisiting previously opened issues.
3. GUI Bug fix: Implemented detailed file type success and failure messages for verification processes.
4. GUI Bug fix: Updated LCCN messages and streamlined hyperlinking to MARC records in Chronicling America.
5. GUI Bug fix: Updated OCR .xsl stylesheet to display "Composed Block" sections of ALTO XML files.
6. DOCS: Updated User Guide (PDF) to reflect updates No object validation changes to VL.

CHANGES IN VERSION 3.32:
1. GUI Bug fix: Metadata displays in GUI now update when revisiting images of previously opened issues.
2. GUI Bug fix: Page advance controllers in GUI now advance to correct page.
3. GUI Bug fix: TIFF headers no longer display erroneous information that was reported by a small set of users.
4. DOCS: Updated User Guide (PDF) with additional Java troubleshooting tips No object validation changes to VL.

CHANGES IN VERSION 3.30:
1. VL: Enabled validation of reel objects lacking non-technical targets
2. VL: Updated strings to UTF-8

CHANGES IN VERSION 3.16:
1. Implemented workaround for JPEG 2000 error when code block length is zero.
2. Fixed OCR xsl - Page Confidence was in the wrong place.

CHANGES IN VERSION 3.15:
1. Updated mix.xsd to accommodate color tiffs.

CHANGES IN VERSION 3.14:
1. Added exemption for bit per sample to accommodate bitonal TIFF images.

CHANGES IN VERSION 3.13:
1. Corrected determination/return of value used to indicate successful validation in support of validation of ALTO 2.0.

CHANGES IN VERSION 3.12:
1. Added support for validation of ALTO 2.0.

CHANGES IN VERSION 3.11:
1. Changedaccess for method getDivElement in class MetsPage from private to public to allow DVV class IssueDetails access.

CHANGES IN VERSION 3.10:
1. Changed verification.level from OFF to INFO in log4j.properties to accommodate standalone release of VL.
2. Added ability to encode multiple questionable dateIssued.
3. Added support for encoding language in ALTO files.

CHANGES IN VERSION 3.9:
1. Changed method access to public (from private) in method getFileID in class gov.loc.ndnp.preingest.batch.MetsPage to facilitate access by DVV.

CHANGES IN VERSION 3.8:
1. Added a check for too many arguments when validating a single file.
2. Updated ALTO schematron to check for presence of language attribute in TextBlock element of the ALTO xml file. If present, the attribute value is checked against values deemed valid by ISO639-2.

CHANGES IN VERSION 3.7:
1. Added "error message recap" at the end of the validation log/console message stream.
2. Added new valid tech target mods title - �Preservation Microfilm Scanner Target PMT1�.
3. Updated logic to allow for multiple identifier elements in METS record files.
4. Changed ALTO schema definition make HEIGHT and WIDTH attributes of Page element to required from optional.
5. Version 1.4 of the ALTO schema definition was added to the loc.gov site, previously avaiable only from the previous holder and maintainer of the ALTO specification.
6. PDF specification changed to clarify 1:1 measurement.

CHANGES IN VERSION 3.6:
1.  Suppression of SEVERE VERIFICATION: Failure RECORDSTATUS is not validated messages when the operation is validation.
2.  Added an exemption for "Outline dictionary missing required entry".

CHANGES IN VERSION 3.5:
1.  Bug fix to commandline processor.
2.  Added messages to describe results when exemption set file not found.

CHANGES IN VERSION 3.4.1:
1.  Bug fix to commandline processor.

CHANGES IN VERSION 3.4:
1.  Added capability to restart in place a failed verification.
2.  Added check to make sure that edition order within LCCN within batch is unique.

CHANGES IN VERSION 3.3:
1.  Upgraded to BIL 3.1

CHANGES IN VERSION 3.2:
1.  Added additional exemptions for XMP.

CHANGES IN VERSION 3.1:
1.  Moved version to external configuration file (to aid with building).  This requires adding a new system
	property (ndnp.properties.validationlibrary) when invoking.
2.  Updated version of Xerces and Xalan.
3.  Changed the order of schema loading for some modules so that xlink schema is loaded first.

CHANGES IN VERSION 3.0:
1.  Check the correct LCCN is in Issue's PDF and JPEG2000 files.
2.  TIFF now reports Unique Image Id (tag 42016).
3.  Added check to make sure that letters in LCCN are lowercase.
4.  Changed to support Reel Template v1.7.
5.  Changed to support Batch Template v1.4.
6.  Added validation of issue date in PDF and JP2s.
7.  Added support for bagging.

CHANGES IN VERSION 2.10:
1.	Changed the number of required tech targets to between 1 and 5.  (Reel profile 1.6)

CHANGES IN VERSION 2.9:
1.  Bug fix to NdnpPdfModule's handling of forward slashes in text stream.
2.  Switched to use Maven2's assembly plug-in rather than custom plug-in to create assembly.
3.  Added additional check to MODS for page in issue METS record for pages that aren't microfilmed.

CHANGES IN VERSION 2.8:
1.  Updated the versions of xmldigsig and xmlsec to the versions that ship with JWSDP2.0.
2.  Bug fixes to BatchWriter.

CHANGES IN VERSION 2.7:
1.  Added support for optional name attribute to batch.
2.  Modified NdnpTiff module to allow 300 to 400 dpi ranges (Tiff Profile 2.7).
3.  Added additional checks of page extent for issue METS record.
4.  Additional checks on files after they are written to make sure they are valid.

CHANGES IN VERSION 2.6:
1.  Added validation of encyclopedia entries.
2.  Fixed errors with use of classloader.

CHANGES IN VERSION 2.5:
1.  Fix to checks to insure that the capitalization of filenames on disk is the same as the references.
2.  Modified how errors are reported back to the console.

CHANGES IN VERSION 2.4:
1.  Changed to use local copy of xml.xsd.
2.  Upgraded to Xerces 2.8.1.
3.  Added checks to insure that the capitalization of filenames on disk is the same as the references.

CHANGES IN VERSION 2.3:
1.  Modified MarcXmlHolding module to allow upper or lower case in 852 $t.
2.  Modified NewspaperTitle module to allow titles without holding records.
3.  Removed check of code block style for JPEG2000.
4.  Added support for additional exemptions for reels.
5.  Fixed the rule checking extent in MODS for page in issue METS record.
6.  Upgraded ALTO version to 1.2, including modification to make backwards compatible.
7.  Added no_update_ignore_existing command line option.

CHANGES IN VERSION 2.2
1.  Completed refactoring of Newspaper titles to meet Newspaper Tile Template v2.5.  (This should not effect Awardees.)
2.  Added test for dmdSec added to techtargetreel children tech targets to meet Reel Template v1.5.
3.  Added support for numerous additional exemptions.
4.  Added test for physicalDescription added to page and target mods to meet Reel Template v1.5 and Issue Template v1.9.

CHANGES IN VERSION 2.1
1.  Fix to Jhove's PDF module to correctly handle double-byte escapes in Literals.
2.  Fix in NDNP PDF module to correctly handle parsing of content streams.

CHANGES IN VERSION 2.0
1.  Modified creation of checksums in Jhove to improve performance.
2.  Added multithreading at page level to improve performance.  This improves performance on multiprocessor machines and does not effect single processor machines.
3.  Fixed bug with PDF Validator that incorrectly recognized escapes in textstreams.
4.  Fixed bug in logging so that finest events are reported as finest, not fine.
5.  Merged with NDNP Ingest Core project.
6.  Updated to Xalan 2.7.0 and made endorsed.
7.  Large refactoring of batch handling intended to ensure that integrity is checked before any further processing.
8.  Large refactoring of logging to provide finer control and separate validation logging from development logging.
9.  Add verify command line option for batches.  Verify only performs a verification that the batch is completely signed.  It does not create any new files.
10.  Added test of issues to ensure that issues that are not present do not have children divs.
11.  Added support for exemptions, allowing some rules to be bypassed.  When an exemption is used, it is recorded in the premis.
12.  Changed ndnpmets.v1-4 so that ID is required for mdSecType.
13.  Added rule checked that dmdSec ID is referenced by a DMDID.
14.  Added rule checked that amdSec ID is referenced by a AMDID.
15.  Added rule checking that reel sequence number must be a positive integer.
16.  Added rule checking that tech targets divs not have DMDID.
17.  Reverted to using standard IO for generating fixity instead of NIO.
18.  Refactoring of signing scheme, removing digital signatures from batch file and placing in mets files (as enveloped digital signature).
     Thus, mets files are signed by an enveloped digital signature; child files have fixity values recorded in their PREMIS records (which in turn are fixed by the mets file's dig sig).
     NOTE:  This means that 2.0 will not work with batches signed by an earlier version.
19.  Discredited versions 1.1 and 1.2.

CHANGES IN VERSION 1.2
1.  Changed commandline interface to ValidationProcessor to allow outputting of representation information.
2.  Fixed bug in PDF validator that incorrectly reported PDFs with multiple contentstreams as invalid.
3.  Fixed bug in PDF validator that causes exception when trailer dictionary info key contains a direct dictionary.
4.  PDF validator no longer prohibits text from being placed in the same location.  (PDF Profile 2.0)
5.  Issue validator now correctly handles issues that are not "Present."
6.  Moved to MODS 3.1 from modified MODS 3.0.
7.  Added some support for UNC filenames on Windows platform.
8.  Moved to standard Xerces release for DOM level 3 support.
9.  Fixed bug where a missing issue/reel mets was left out of updated batch.xml.

CHANGES IN VERSION 1.1
1.  Validation Library version number logged using the INFO log level.
2.  Updated validation of reel template to version 1.4, which includes handling of NDNP technical targets.

EMBEDDING IN ANOTHER APPLICATION:
The interface gov.loc.ndnp.ingest.validation.Validator (implemented by gov.loc.ndnp.ingest.validation.ValidationProcessor)
offers a facade for the NDNP Validation Library.  

For questions or problems, contact LC NDNP staff (ndnptech@loc.gov).