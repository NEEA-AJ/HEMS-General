*****************************************************************************************;
***** Program Name: CREATE HEMS WASHER DRYER FILE  									*****;
***** Purpose.....: Create a table for HEMS wahser and dryers			         	*****;
***** 																				*****;
***** Author......: NEEA, MARKET INTELLIGENCE ANALYST A								*****;
***** Date Started: 	mm/dd/20yy 													*****;
***** Date Completed: 	mm/dd/20yy 													*****;
***** 																				*****;
***** Input Files:  					     										*****;
***** Output Files:  																*****;
***** Modification History: 														*****;
***** Date:mm/dd/20yy LOREM IPSOM													*****;
***** 			  																	*****;
***** References: 																	*****;
***** 			  																	*****;
***** 			  																	*****;
*****************************************************************************************;

***************  
***  NOTES  ***
*****************************************************************************************;
*                                                                                       *;
*                                                                                       *;
*                                                                                       *;
*                                                                                       *;
*                                                                                       *;
*                                                                                       *;
*                                                                                       *;
*****************************************************************************************;


/** Initial Import of combined RBSA washer/dryer tables **/

FILENAME CSV "D:\HEMS RBSA TABLES\HEMS_W_D_TEMP.csv" TERMSTR=CRLF;
PROC IMPORT DATAFILE=CSV 
		    OUT=WASHDRY
		    DBMS=CSV
		    REPLACE;
		    GUESSINGROWS=ALL;
RUN;
FILENAME CSV;

DATA SITES;
SET HEMS.SITES;
rename rbsa_site_id = SiteID;
KEEP ee_site_id site_id rbsa_site_id rbsa_version;
run;

PROC SORT DATA=SITES;
BY SiteID;
PROC SORT DATA=WASHDRY;
BY SiteID;

DATA HEMS_RBSA_WASHER_DRYER;
MERGE SITES (IN=i) WASHDRY(IN=j);
BY SiteID;
IF i=1 THEN OUTPUT;
RUN;


PROC PRINT DATA=HEMS_RBSA_WASHER_DRYER; RUN;
DATA DRYERS;
SET  HEMS_RBSA_WASHER_DRYER;
WHERE  TYPE="Dryer";RUN;
DATA HEMSRBSA.HEMS_RBSA_WASHER_DRYER;
SET  HEMS_RBSA_WASHER_DRYER;
RUN;

DATA PROJECTS.DRYER_DETS;
SET  PROJECTS.DRYER_DETS;
DROP Washer 
