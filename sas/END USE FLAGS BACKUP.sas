*****************************************************************************************;
***** Program Name: END USE FLAGS BACKUP  					  							*****;
***** Purpose.....: Dvelop some sample Load Shapes for analyst presentations	   	*****;
***** 																				*****;
***** Author......: NEEA, MARKET INTELLIGENCE ANALYST A								*****;
***** Date Needed: 		         													*****;
***** Date Started: 	03/31/2022 													*****;
***** Date Completed: 	mm/dd/20yy 													*****;
***** 																				*****;
***** SAS Version.: SAS 9.4M5 														*****;
***** Input Files.: cbsa.site_sum_p		     										*****;
***** Output Files:  																*****;
***** Subroutines.: None 															*****;
***** User-defined Formats:  														*****;
***** Includes....: None 															*****;
***** Modification History: 														*****;
***** 1.  																			*****;
***** 			  																	*****;
***** References: 																	*****;
***** 			  																	*****;
***** 			  																	*****;
*****************************************************************************************;

*********  
* NOTES *
*****************************************************************************************;
*  Develop flags for particular end-uses in HEMS                                        *;
                                                                                        *;
*   KEEP EE_SITE_ID HP_FL 
	EDWH_FL 
	EV_FL 
	CAC_FL 
	EF_FL 
	HPWH_FL 
	dhp_fl 
	EDWHI_FL 
	BBOZ_FL                                                                             *;
*                                                                                       *;
*                                                                                       *;
*****************************************************************************************;



PROC FREQ DATA=HEMS_15.POINTS;
TABLES circuit_label_type_desc;
RUN;

DATA IDX_HP;
SET HEMS_15.POINTS;

LENGTH HP_FL 3.0
	EDWH_FL 3.0
	EV_FL 3.0
	CAC_FL 3.0
	EF_FL 3.0
	HPWH_FL 3.0
	dhp_fl 3.0
	EDWHI_FL 3.0
	BBOZ_FL 3.0
	GAS_FL 3.0;
DO;
IF circuit_label_type_desc="Ducted Heatpump" THEN HP_FL=1; ELSE HP_FL=0;
IF circuit_label_type_desc="Electric Resistance Storage Water Heaters" THEN EDWH_FL=1; ELSE EDWH_FL=0;
IF circuit_label_type_desc="Electric Vehicle Charger" THEN EV_FL=1; ELSE EV_FL=0;
IF circuit_label_type_desc="Central AC" THEN CAC_FL=1; ELSE CAC_FL=0;
IF circuit_label_type_desc="Electric Furnace" THEN EF_FL=1; ELSE EF_FL=0;
IF circuit_label_type_desc="Heat Pump Water Heater" THEN HPWH_FL=1; ELSE HPWH_FL=0;
IF circuit_label_type_desc="Ductless Heatpump" THEN DHP_FL=1; ELSE DHP_FL=0;
IF circuit_label_type_desc="Instantaneous Water Heater (Elec)" THEN EDWHI_FL=1; ELSE EDWHI_FL=0;
IF circuit_label_type_desc in ("Electric Baseboard Heaters" "Other Zonal Heat")THEN BBOZ_FL=1; ELSE BBOZ_FL=0;
IF circuit_label_type_desc="Gas Furnace (Component)" THEN GAS_FL=1; ELSE GAS_FL=0;
	END;
KEEP EE_SITE_ID HP_FL 
	EDWH_FL 
	EV_FL 
	CAC_FL 
	EF_FL 
	HPWH_FL 
	dhp_fl 
	EDWHI_FL 
	BBOZ_FL ;
RUN;
PROC SQL THREADS;
CREATE TABLE HEMS_15.IDX_HP AS 
SELECT  
	MAX(EE_SITE_ID ) AS EE_SITE_ID ,
	SUM(HP_FL ) AS HP_FL ,
	SUM(EDWH_FL ) AS EDWH_FL ,
	SUM(EV_FL ) AS EV_FL ,
	SUM(CAC_FL ) AS CAC_FL ,
	SUM(EF_FL ) AS EF_FL ,
	SUM(HPWH_FL ) AS HPWH_FL ,
	SUM(dhp_fl ) AS dhp_fl ,
	SUM(EDWHI_FL ) AS EDWHI_FL ,
	SUM(BBOZ_FL) AS BBOZ_FL
FROM IDX_HP
GROUP BY EE_SITE_ID;
QUIT;
DATA HEMS_15.IDX_HP;
SET  HEMS_15.IDX_HP;
LABEL HP_FL= "Has a HeatPump"
	EDWH_FL = "Has Electric Water Heater"
	EV_FL = "Has EV Charger"
	CAC_FL = "Has Central AC (not HP)"
	EF_FL = "Has Electric Furnace"
	HPWH_FL = "Has HPWH"
	DHP_FL = "Has DHP"
	EDWHI_FL = "Has Instantaneous Water Heater (Elec)" 
	BBOZ_FL = "Has Electric Baseboard/Other Zonal Heat"
	GAS_FL = "Gas Furnace (Component)";
RUN;

PROC SORT DATA= HEMS_15.IDX_HP nodupkey;
BY EE_SITE_ID;
RUN;