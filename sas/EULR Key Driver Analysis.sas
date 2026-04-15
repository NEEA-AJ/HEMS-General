*****************************************************************************************;
***** Program Name: EULR Key Driver Analysis    									*****;
***** Purpose.....: Further understand LLLC Market Size              			   	*****;
***** 																				*****;
***** Author......: Look at the key drivers of electricity use						*****;
***** Date Needed: 		mm/dd/yyyy 													*****;
***** Date Started: 	mm/dd/yyyy 													*****;
***** Date Completed: 	mm/dd/yyyy 													*****;
***** 																				*****;
***** SAS Version.: SAS 9.4 														*****;
***** Input Files.: cbsa.site_sum_p		     										*****;
***** Output Files:  																*****;
***** Subroutines.: None 															*****;
***** User-defined Formats: U														*****;
***** Includes....: None 															*****;
***** Modification History: 														*****;
***** 1.  																			*****;
***** 			  																	*****;
***** References: 																	*****;
***** • 																			*****;
*****************************************************************************************;

*****************************************************************************************;
*                                                                                       *;
* Upon reviewing the data Aaron provided on our previous request for floor area by      *; 
* building size (1/30/17), additional questions emerged.								*;
*                                                                                       *;
* We would like to understand how the average floor area per building changes by        *;
* excluding certain size categories.  Below is the specific info we are looking for.    *;
*                                                                                       *;
* What is the average & median square footage of:                                       *;
*                                                                                       *;
* (1) Offices 5,001+ sf	     													        *;
* (2) Offices 10,001+ sf														        *;
* (3) Warehouses 20,001+ sf														        *;
* (4) Warehouses 50,001+ sf														        *;
*                                                                                       *;
*****************************************************************************************;
/*
DATA PROJECTS.EULR_KDA;
SET PROJECTS.EULR_KDA;
LABEL*/

PROC SORT DATA=PROJECTS.EULR_KDA;
	BY GASFLAG SITEID;


PROC GLMSELECT DATA=PROJECTS.EULR_KDA PLOTS=ASEPLOT;
BY GASFLAG;
CLASS 
WHFuel
ResInt_PortableHeat
ResInt_HeatMostUsed
;
MODEL kwh_nrm_y= heat_clim_zone|ResInt_YearBuilt|SummarySketchSqFt_Calculated|HH_CT|WHFuel|ResInt_PortableHeat|ResInt_HeatTempNight|ResInt_HeatMostUsed/SELECTION=STEPWISE;
WEIGHT SVY_WT;
RUN;

PROC SORT DATA=PROJECTS.EULR_KDA;
	BY SITEID; RUN;


PROC SORT DATA=PROJECTS.EULR_KDA;
	BY GASFLAG SITEID;


PROC GLMSELECT DATA=PROJECTS.EULR_KDA PLOTS=ASEPLOT;
BY GASFLAG;
CLASS 
WHFuel
ResInt_PortableHeat
ResInt_HeatMostUsed
;
MODEL kwh_nrm_y= heat_clim_zone ResInt_YearBuilt SummarySketchSqFt_Calculated HH_CT WHFuel ResInt_PortableHeat ResInt_HeatTempNight ResInt_HeatMostUsed/SELECTION=STEPWISE;
WEIGHT SVY_WT;
RUN;

PROC SORT DATA=PROJECTS.EULR_KDA;
	BY SITEID; RUN;




