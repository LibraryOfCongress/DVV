Digital Viewer and Validator (DVV)
Version 2.3.0 (VL 3.39)
April 7, 2023

DESCRIPTION:
The DVV is a GUI based tool for use by awardees, vendors and NDNP staff.  In addition to incorporating the functionality of the NDNP Validation Library (VL), which is embedded within, the DVV also allows visual inspection of content files submitted for inclusion in the NDNP digital repository.  The capability also exists to view header and metadata file content.

Detailed instructions for using the DVV can be found in the DVV User's Guide. For questions or problems, contact LC NDNP staff (ndnptech@loc.gov).

Note:
Requests to W3C
Previous versions of the validation software made repeated requests to retrieve an xml schema file from w3c. The quantity of requests was at times so large that it prompted a request from the w3c to correct the source of the requests. A fix has been applied in Validator versions 2.4 and later. The fix was included as of version 1.1 of the DVV.

CHANGES IN VERSION 2.3.0 (VL 3.39):
1. Upgraded JP2 image viewer using ImageIO library.
2. Incorporated ImageMagick version 7.1.1-4 software to facilitate JP2 to JPG conversion for upgraded JP2 viewer.
3. Upgraded to Java 17.
4. Upgraded to Gradle 7.6.
5. Fixed bug in Reels section that was causing null pointer errors due to incorrect reel id.
6. GUI Enhancement: Updated file path informational messages in viewer footer.
7. DOCS: Updated User Guide (PDF) to reflect updates.

CHANGES IN VERSION 2.2.4 (VL 3.38):
1. Added support for validation of PDF versions 1.5, 1.6, and 1.7.
2. Added support for validation of ALTO versions 3.0 and 3.1.
3. Removed 'OCR Accuracy Threshold' value from OCR tab XSL file.
4. Fixed PREMIS dateCreatedByApplication date formatting error.

CHANGES IN VERSION 2.2.3 (VL 3.37):
1. GUI Bug fix: Fixed Identifier Collisions report error when LCCN not found in Chronicling America

CHANGES IN VERSION 2.2.2 (VL 3.36):
1. GUI Bug fix: Final verification success/failure counts reset between verification processes within same GUI session
2. GUI Bug fix: Info Tab LCCN Error Message for titles not found in Chronicling America fixed.

CHANGES IN VERSION 2.2.1 (VL 3.35):
1. New Feature: Implemented "Find Identifier Collisions" report.
2. GUI Bug fix: OCR and Thumbs view now update when revisiting previously opened issues.
3. GUI Bug fix: Implemented detailed file type success and failure messages for verification processes.
4. GUI Bug fix: Updated LCCN messages and streamlined hyperlinking to MARC records in Chronicling America.
5. GUI Bug fix: Updated OCR .xsl stylesheet to display "Composed Block" sections of ALTO XML files.
6. DOCS: Updated User Guide (PDF) to reflect updates
No object validation changes to VL.

CHANGES IN VERSION 2.1.12 (VL 3.32):
1. GUI Bug fix: Metadata displays in GUI now update when revisiting images of previously opened issues.
2. GUI Bug fix: Page advance controllers in GUI now advance to correct page.
3. GUI Bug fix: TIFF headers no longer display erroneous information that was reported by a small set of users.
4. DOCS: Updated User Guide (PDF) with additional Java troubleshooting tips
No object validation changes to VL.

CHANGES IN VERSION 2.1.10 (VL 3.30):
1. VL: Enabled validation of reel objects lacking non-technical targets
2. VL: Updated strings to UTF-8
3. Version 2.X change: New GUI introduced that includes new calendar view, updated metadata views, enhanced reporting, and new user guide (PDF).
4. Version 2.X change: Packaging and distribution of software now uses single version name scheme and .ZIP format.
5. Version 2.X change: Java no longer comes pre-packaged with software. Java 7 or newer 32-bit required to run.

CHANGES IN VERSION 1.4.12-dev_3.16-dev
1. Implemented workaround for JPEG 2000 error when code block length is zero.
2. Fixed OCR xsl - Page Confidence was in the wrong place.

CHANGES IN VERSION 1.4.11_3.15
1. VTiff module now reports out of memory error explicitly.

CHANGES IN VERSION 1.4.10_3.14
1. Zoom level is now retained when a new/previous page is viewed.
2. Left navigation panel now has default size (25% of window size).
3. Left navigation panel no longer changes size to accommodate filename length.
4. Enabled selection of the filename of the currently viewed image.
5. Added display of NDNP Technical metadata for Reels.
6. Fixed Predicted Word Accuracy for ALTO 2.0 files.
7. Added date and time that the installer was created to the dvv.properties file.

CHANGES IN VERSION 1.4.9_3.12
1. Added support for ALTO 2.0 to the OCR tab.

CHANGES IN VERSION 1.4.8_3.11
1. Added the encoded language value to the OCR page display.
2. Removed Essay tab.
3. Added new keyboard shortcuts.
4. Determined that the reason for embedded browser failure when viewing PDF files is an incompatibility between Adobe and Internet Explorer.

CHANGES IN VERSION 1.4.7_3.10
1. Eliminated popup dialog when a page is Not Digitized, Published.
2. Removed extraneous comma when edition label is not present and issue has questionable date.

CHANGES IN VERSION 1.4.6_3.10
1. Changed embedded browser, offering support for Windows 7.

CHANGES IN VERSION 1.4.5_3.9
1. Updated to test for the presence of the WC attribute in the <String> element before comparing to accuracy threshold setting.  If it is not present, it is considered by default to be higher.
2. Added the section label text to each page in the section tree.

CHANGES IN VERSION 1.4.4_3.7
1. Corrected DVV not checking tech target mods title when validating using the GUI.
2. Added the display of the section label to the metadata panel.
3. Fixed navigation artifacts that were not being enabled when necessary.
4. Updated logic to allow for multiple identifier elements in METS record files.
5. Added awardee and awardYear attributes to the batch element in the batch xml file.
6. Added Preservation Microfilm Scanner Target PMT1 as a valid value for the tech target title in the reel xml file.
7. Added display of the tech target title in the metadata display panel.

CHANGES IN VERSION 1.4.4_3.6
1. Added ability to bypass comments in document when scanning XML files to determine type (issue, reel, alto, batch).

CHANGES IN VERSION 1.4.3_3.6
1. Incorporated Validation Library version 3.6.
2. Added support for section labels.
3. Added identifier collision checking.

CHANGES IN VERSION 1.4.2_3.5
1. Incorporated Validation Library version 3.5.

CHANGES IN VERSION 1.4.2_3.4.1
1. Change newspaper title parsing when displaying issues to ignore = in title.
2. Added display of title along with validated LCCN.

CHANGES IN VERSION 1.4.1_3.2
1. Corrected way that pages are tracked when in browse mode to fix crash.
2. Incorporated Validation Library version 3.2.
3. Added check for LCCN validity in encyclopedia entries.
4. Added support for sections in issue pages.
5. Added display of title to validated LCCN.

CHANGES IN VERSION 1.4.1_3.1
1. Added check that disables all tabs except Info and Metadata Viewer when page is "Not digitized, published".
2. Updates to ensure that issues are presented by date within LCCN order.
3. Updates to ensure that pages are presented in the proper order, regardless of out of order metadata.
4. Updates to validate LCCNs from NDNP 2.0.

CHANGES IN VERSION 1.4_3.1
1. Incorporated version 3.1 of the Validation Library.

CHANGES IN VERSION 1.4_3.0
1. Incorporated version 3.0 of the Validation Library.
2. Added display of TIFF tag numbers to the TIFF header panel.
3. Corrected erroneous reporting of extraneous files in Path Check.

CHANGES IN VERSION 1.3.1_2.10
1. Changed the version number scheme to include an underscore between the DVV version number and the Validation Library version number to allow for easier identification of version number of each of the components.
2. Increased the out of work detection period from ten seconds to five minutes.
3. Changed OCR selectivity threshold to 0.0.
4. Fixed incorrect display of validated essay icons.

CHANGES IN VERSION 1.3.2.10
1. Incorporated version 2.10 of the Validation Library.
2. Improved viewer logic to preclude display of issue and reel images while essay title panel is enabled and to preclude the display of the essay title panel when reel or issue images are shown.
3. Eliminated error dialog for absence of images when an issue is not digitized.  Additionally, enhanced tab enable/disable logic to more accurately represent which data types are available.

CHANGES IN VERSION 1.3.2.9
1. Changed the version number scheme to include the version of the Validation Library currently incorporated as part of the DVV. In this instance, the Validation Library version is 2.9.  The DVV version is 1.3.
2. Added test for questionable Date Issued. Questionable dates are now identified in the batch tree with question marks preceding and appending the issue date.  Such dates are also identified in the Metadata Viewer.
3. Added automatic validation of LCCNs via HTTP call to the live NDNP Repository.


CHANGES IN VERSION 1.2
1. Added support for title essays.
2. Deactivated message.log logging file.
3. Deactivated inclusion of default exemptionset. User must now manually load exemptions.
4. Changed the method of displaying file names to reduce the possibility of extremely long names being truncated.
5. Updated Validation Library to version 2.8.
6. Changed "Validation completed" dialog frequency to end of batch.
7. Added support for pages that have been published but not digitized.
8. Set confidence level threshold for OCR file processing to zero, allowing unaltered view of content.

CHANGES IN VERSION 1.1
1.  Internal improvements in memory management to preclude out of memory conditions.
2.  New Batch menu item - Cancel Current Processing, allows the user to cancel a long running task such as validation or verification without stopping and restarting the DVV.
3.  Better progress reporting.
4.  Issues in batch tree now sorted by issue date within title.
5.  Removal of prompt for JP2 plug-in options. JP2 plug-ins are no longer supported.
6.  Added the ability to identify non-digitized pages and issues and report them as such, no longer described as "not found".
7.  Updated documentation to include special notes on ensuring console log output during batch verification from the command line.
8.  Renamed viewer tabs, making them more intuitive.
9.  Set default OCR confidence threshold to zero, providing a more accurate representation of the quality of the OCR data.
10. New Batch menu item - Verify, a new addition to the Validation Library.
11. Added support for exemptions, allowing specified validation rules to be ignored during validation processing.