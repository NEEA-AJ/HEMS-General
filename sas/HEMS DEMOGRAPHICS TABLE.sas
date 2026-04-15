*****************************************************************************************;
***** Program Name: HEMS DEMOGRAPHICS TABLE  					  					*****;
***** Purpose.....: Enter goal/purpose of project			         			   	*****;
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

*********************;
*** RBSA SITE IDS ***;
****************************************************************************;
DATA HEMSRBSA.SITEIDS;
SET  HEMSRBSA.BASE_TABLE;
KEEP SiteID ee_site_id 'RBSA Data Source'n;
RUN;
PROC SORT DATA=HEMSRBSA.SITEIDS;
BY SiteID;
RUN;

***************************;
*** PULL ROWS FROM RBSA ***;
****************************************************************************;
PROC SORT DATA=	RBSA2.SITEINTERVIEW_DEMOGRAPHICS;
	BY SITEID;
PROC SORT DATA=	RBSA3.SITEINTERVIEW_DEMOGRAPHICS;
	BY SiteID;
DATA DEMO2;
	MERGE HEMSRBSA.SITEIDS(IN=i) RBSA2.SITEINTERVIEW_DEMOGRAPHICS(IN=j);
	BY SITEID;
	IF i=1 AND j=1 THEN OUTPUT;
DATA DEMO2;
SET  DEMO2;
LENGTH
Qty_Occupants_Moved_Out_Past_Ye	$	9.
Qty_Occupants_Moved_In_Past_Yea	$	9.
Home_Usage_Type	$	43.
Household_Education_Level_Other	$	50.
Race_Ethnicity	$	114.
;
RENAME Business_Operated_Out_of_Home = Business_Operated_Out_of_the_Ho;
RENAME Any_Occpt_Moved_In_within_Last_Y = Any_Occupants_Moved_In_within_L;
RENAME Any_OccptMoved_Out_within_Last_Y = Any_Occupant_Moved_Out_within_L;
RENAME Planning_to_Move_Within_Six_Mont = Planning_to_Move_Within_Six_Mon;
RENAME Qty_Occpt_Less_than_1_Year = Qty_Occupants_Less_than_1_Year;
RENAME Qty_Occpt_1_and_5_Years = Qty_Occupants_Between_1_and_5_Y;
RENAME Qty_Occpt_1_and_5_Years_Notes = ;
RENAME Qty_Occpt_6_and_10_Years_Notes = ;
RENAME Qty_Occpt_11_and_18_Years_Notes = ;
RENAME Qty_Occpt_19_and_45_Years_Notes = ;
RENAME Qty_Occpt_46_and_64_Years_Notes = ;
RENAME Qty_Occpt_65_Years_or_Older_Note = ;
RENAME Qty_Occpt_Work_Outside_Home_Note = ;
RENAME Qty_Occpt_notes = ;
RENAME Qty_Adults_notes = ;
RENAME have_a_carbon_monoxide_alarm = ;
RENAME Who_pays_e_bill_Other_Specified = ;
RENAME financial_assistance_for_e_bill = ;
RENAME Percent_assistance_for_e_bill = ;
RENAME Who_pays_gas_bill_Other_Specifie = ;
RENAME financial_assistance_for_gas_bil = ;
RENAME Percent_assistance_for_gas_bill = ;
RENAME Qualify_for__assistance = ;
RENAME Home_Business = ;
RENAME Reported_Income = Household_Income;

DROP 
Move_In_Year_Notes
Qty_Occpt_Less_than_1_Year_Notes
Qty_Occpt_1_and_5_Years_Notes
Qty_Occpt_6_and_10_Years_Notes
Qty_Occpt_11_and_18_Years_Notes
Qty_Occpt_19_and_45_Years_Notes
Qty_Occpt_46_and_64_Years_Notes
Qty_Occpt_65_Years_or_Older_Note
Qty_Occpt_Work_Outside_Home_Note
Qty_Occpt_notes
Qty_Adults_notes
have_a_carbon_monoxide_alarm
Who_pays_e_bill_Other_Specified
financial_assistance_for_e_bill
Percent_assistance_for_e_bill
Who_pays_gas_bill_Other_Specifie
financial_assistance_for_gas_bil
Percent_assistance_for_gas_bill
Qualify_for__assistance
Home_Business
;


DATA DEMO3a;
	MERGE HEMSRBSA.SITEIDS(IN=i) RBSA3.SITEINTERVIEW_DEMOGRAPHICS(IN=j);
	BY SITEID;
	IF i=1 AND j=1 THEN OUTPUT;
RUN;
DATA DEMO3a;
SET  DEMO3a;
DO;
DUM10=INPUT(Qty_Occupants_Less_than_1_Year,BEST12.); DROP Qty_Occupants_Less_than_1_Year; RENAME DUM10=Qty_Occupants_Less_than_1_Year;
DUM11=INPUT(Qty_Occupants_Between_1_and_5_Y,BEST12.); DROP Qty_Occupants_Between_1_and_5_Y; RENAME DUM11=Qty_Occupants_Between_1_and_5_Y;
DUM12=INPUT(Qty_Occupants_Between_6_and_10_,BEST12.); DROP Qty_Occupants_Between_6_and_10_; RENAME DUM12=Qty_Occupants_Between_6_and_10_;
DUM13=INPUT(Qty_Occupants_Between_11_and_18,BEST12.); DROP Qty_Occupants_Between_11_and_18; RENAME DUM13=Qty_Occupants_Between_11_and_18;
DUM14=INPUT(Qty_Occupants_Between_19_and_45,BEST12.); DROP Qty_Occupants_Between_19_and_45; RENAME DUM14=Qty_Occupants_Between_19_and_45;
DUM15=INPUT(Qty_Occupants_Between_46_and_64,BEST12.); DROP Qty_Occupants_Between_46_and_64; RENAME DUM15=Qty_Occupants_Between_46_and_64;
DUM16=INPUT(Qty_Occupants_65_Years_or_Older,BEST12.); DROP Qty_Occupants_65_Years_or_Older; RENAME DUM16=Qty_Occupants_65_Years_or_Older;
DUM17=INPUT(Qty_Occupants_Work_Outside_the_,BEST12.); DROP Qty_Occupants_Work_Outside_the_; RENAME DUM17=Qty_Occupants_Work_Outside_the_;
DUM19=INPUT(Qty_Adults,BEST12.); DROP Qty_Adults; RENAME DUM19=Qty_Adults;
END;
RUN;

************************;
*** IMPORT HEMS RBSA ***;
****************************************************************************;
PROC IMPORT DATAFILE="D:\HEMS RBSA TABLES\hems rbsa raw tables\HEMS FULL RBSA\SiteInterview_Demographics.csv"
    OUT=HEMSRBSAa
    DBMS=CSV
    REPLACE;
    GUESSINGROWS=ALL;
RUN;
PROC SORT DATA=HEMSRBSAa;
	BY EULR_ID;
DATA HEMSRBSAa;
SET  HEMSRBSAa;
RENAME EULR_ID=SITEID;
DO;
LENGTH DUM22 $ 10.; DUM22 = Who_pays_the_gas_bill; DROP Who_pays_the_gas_bill; RENAME DUM22=Who_pays_the_gas_bill;
LENGTH DUM23 $ 9.; DUM23 = Qty_Occupants_Moved_Out_Past_Ye; DROP Qty_Occupants_Moved_Out_Past_Ye; RENAME DUM23=Qty_Occupants_Moved_Out_Past_Ye;
LENGTH DUM24 $ 9.; DUM24 = Qty_Occupants_Moved_In_Past_Yea; DROP Qty_Occupants_Moved_In_Past_Yea; RENAME DUM24=Qty_Occupants_Moved_In_Past_Yea;
LENGTH DUM25 $ 43.; DUM25 = Home_Usage_Type; DROP Home_Usage_Type; RENAME DUM25=Home_Usage_Type;
LENGTH DUM26 $ 53.; DUM26 = Household_Education_Level; DROP Household_Education_Level; RENAME DUM26=Household_Education_Level;
LENGTH DUM28 $ 32.; DUM28 = Household_Income; DROP Household_Income; RENAME DUM28=Household_Income;
END;
RUN;
DATA HEMSRBSA;
	MERGE HEMSRBSA.SITEIDS(IN=i) HEMSRBSAa(IN=j);
	BY SITEID;
	IF i=1 AND j=1 THEN OUTPUT;
RUN;

DATA DEMO3;
SET DEMO3a HEMSRBSA;
RUN;


proc contents data=HEMSRBSA;
PROC CONTENTS DATA=DEMO2;
PROC CONTENTS DATA=DEMO3a;
RUN;
