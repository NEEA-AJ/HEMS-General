*****************************************************************************************;
***** Program Name: HEMS Weighting HEMS workbook 									*****;
***** Purpose.....: Enter goal/puropose of project			         			   	*****;
***** 																				*****;
***** Author......: NEEA, MARKET INTELLIGENCE ANALYST A								*****;
***** Date Needed: 		mm/dd/20yy 													*****;
***** Date Started: 	mm/dd/20yy 													*****;
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
*                                                                                       *;
*                                                                                       *;
*                                                                                       *;
*                                                                                       *;
*                                                                                       *;
*                                                                                       *;
*                                                                                       *;
*****************************************************************************************;
PROC FREQ DATA=HEMSRBSA.MECHANICAL_HEATINGANDCOOLING;
TABLES EULR_ID*System_Type/MISSING NOCOL NOROW NOCUM NOPERCENT;
RUN;





/*********/

* HEMSRBSA.MECHANICAL_HEATINGANDCOOLING;

DATA HEMSRBSA.MECHANICAL_HEATINGANDCOOLING;
SET HEMSRBSA.MECHANICAL_HEATINGANDCOOLING;

LABEL
	EULR_ID = 'EULR_ID'
	CK_RoomID = 'CK_RoomID'
	PK_Mechanical_ID = 'PK_Mechanical_ID'
	System_Type = 'System_Type'
	Known_to_be_Variable_Speed = 'Known_to_be_Variable_Speed'
	Provides_Heating = 'Provides_Heating'
	Provides_Cooling = 'Provides_Cooling'
	Primary_Heating_System_SelfRepo = 'Primary_Heating_System_SelfReport'
	Primary_Heating_System_Prescrib = 'Primary_Heating_System_Prescribed'
	Primary_Cooling_System_SelfRepo = 'Primary_Cooling_System_SelfReport'
	Primary_Cooling_System_Prescrib = 'Primary_Cooling_System_Prescribed'
	Central_System_Number = 'Central_System_Number'
	Mini_Split_System_Number = 'Mini_Split_System_Number'
	Fuel = 'Fuel'
	Distribution_Type = 'Distribution_Type'
	Mini_Split_Has_Ducts = 'Mini_Split_Has_Ducts'
	Ducted_Mini_Split_Rooms_Served = 'Ducted_Mini_Split_Rooms_Served'
	Mini_Split_is_Multihead = 'Mini_Split_is_Multihead'
	Control_Type = 'Control_Type'
	Zones_Served = 'Zones_Served'
	Zones_Served_Other = 'Zones_Served_Other'
	Make = 'Make'
	Model = 'Model'
	Model_Missing = 'Model_Missing'
	Year_of_Manufacture = 'Year_of_Manufacture'
	Serial_Number = 'Serial_Number'
	Energy_Star_Label_Present = 'Energy_Star_Label_Present'
	Cooling_Capacity_BTUh = 'Cooling_Capacity_BTUh'
	SEER = 'SEER'
	SEER_is_Estimated = 'SEER_is_Estimated'
	EER = 'EER'
	EER_is_Estimated = 'EER_is_Estimated'
	Ignition_Type = 'Ignition_Type'
	Fuel_Valve_Type = 'Fuel_Valve_Type'
	Venting_Type = 'Venting_Type'
	Heating_Size_kW = 'Heating_Size_kW'
	Heating_Size_kW_is_Est = 'Heating_Size_kW_is_Est'
	Heating_Size_BTUh = 'Heating_Size_BTUh'
	Heating_Size_BTUh_is_Est = 'Heating_Size_BTUh_is_Est'
	Baseboard_Length = 'Baseboard_Length'
	Baseboard_Length_is_Est = 'Baseboard_Length_is_Est'
	Single_Stage_Input_Heating_Capa = 'Single_Stage_Input_Heating_Capacity_BTUh'
	VAR45  = 'Single_Stage_Input_Heating_Capacity_BTUh_is_Est'
	Single_Stage_Output_Heating_Cap = 'Single_Stage_Output_Heating_Capacity_BTUh'
	VAR47 = 'Single_Stage_Output_Heating_Capacity_BTUh_is_Est'
	High_Input_Heating_Capacity_BTU = 'High_Input_Heating_Capacity_BTUh'
	VAR51 = 'High_Input_Heating_Capacity_BTUh_is_Est'
	High_Output_Heating_Capacity_BT = 'High_Output_Heating_Capacity_BTUh'
	VAR53 = 'High_Output_Heating_Capacity_BTUh_is_Est'
	High_Heating_Efficiency = 'High_Heating_Efficiency'
	High_Heating_Efficiency_is_Est = 'High_Heating_Efficiency_is_Est'
	Low_Input_Heating_Capacity_BTUh = 'Low_Input_Heating_Capacity_BTUh'
	VAR57 = 'Low_Input_Heating_Capacity_BTUh_is_Est'
	Low_Output_Heating_Capacity_BTU = 'Low_Output_Heating_Capacity_BTUh'
	VAR59 = 'Low_Output_Heating_Capacity_BTUh_is_Est'
	Low_Heating_Efficiency = 'Low_Heating_Efficiency'
	Low_Heating_Efficiency_is_Est = 'Low_Heating_Efficiency_is_Est'
	Heat_Pump_Compressor_Works_in_H = 'Heat_Pump_Compressor_Works_in_Heating_Mode'
	Lockout_HeatPump_Heating_Temp_D = 'Lockout_HeatPump_Heating_Temp_Determined'
	Lockout_HeatPump_Heating_Temp = 'Lockout_HeatPump_Heating_Temp'
	Desuperheater_Present = 'Desuperheater_Present'
	System_on_same_Tstat_as_Heat_Pu = 'System_on_same_Tstat_as_Heat_Pump'
	System_is_Backup_for_Heatpump = 'System_is_Backup_for_Heatpump'
	Fan_Type = 'Fan_Type'
	Filter_Type = 'Filter_Type'
	Dehumidifer_or_Economizer_Part_ = 'Dehumidifer_or_Economizer_Part_of_System'
	Economizer = 'Economizer'
	Humidifier_Present = 'Humidifier_Present'
	Equipment_Use = 'Equipment_Use'
	Equipment_Use_Frequency = 'Equipment_Use_Frequency'
	Days_of_Use_Per_Year = 'Days_of_Use_Per_Year'
	WiFi_Capable = 'WiFi_Capable'
	Fireplace_Type = 'Fireplace_Type'
;
RENAME
Single_Stage_Input_Heating_Capa =SS_In_Heat_Cap_BTUH
VAR45 = SS_In_Heat_Cap_BTUH_EST
Single_Stage_Output_Heating_Cap = SS_OUT_Heat_Cap_BTUH
VAR47 = SS_OUT_Heat_Cap_BTUH_EST
High_Input_Heating_Capacity_BTU = High_In_Heat_Cap_BTUH 
VAR51 = High_In_Heat_Cap_BTUH_EST
High_Output_Heating_Capacity_BT = High_OUT_Heat_Cap_BTUH 
VAR53 = High_OUT_Heat_Cap_BTUH_EST
High_Heating_Efficiency = High_Heat_Efficiency
High_Heating_Efficiency_is_Est = High_Heat_Efficiency_EST
Low_Input_Heating_Capacity_BTUh = Low_In_Heat_Cap_BTUh
VAR57= Low_In_Heat_Cap_BTUh_EST
Low_Output_Heating_Capacity_BTU = Low_OUT_Heat_Cap_BTUh
VAR59 = Low_OUT_Heat_Cap_BTUh_EST
Low_Heating_Efficiency = Low_Heat_Efficiency
Low_Heating_Efficiency_is_Est= Low_Heat_Efficiency_EST
;
RUN;
 /*   HEMSRBSA.   */
/*  RBSA3.MECHANICAL_ONE_LINE  */
PROC SQL;
	CREATE TABLE BRIDGE
	AS SELECT
	MAX(EULR_ID) AS EULR_ID LABEL = 'EULR_ID' ,
	MAX(CK_RoomID) AS CK_RoomID LABEL = 'CK_RoomID' ,
	MAX(PK_Mechanical_ID) AS PK_Mechanical_ID LABEL = 'PK_Mechanical_ID' ,
	MAX(System_Type) AS System_Type LABEL = 'System_Type' ,
	MAX(Known_to_be_Variable_Speed) AS Known_to_be_Variable_Speed LABEL = 'Known_to_be_Variable_Speed' ,
	MAX(Provides_Heating) AS Provides_Heating LABEL = 'Provides_Heating' ,
	MAX(Provides_Cooling) AS Provides_Cooling LABEL = 'Provides_Cooling' ,
	MAX(Primary_Heating_System_SelfRepo) AS Primary_Heating_System_SelfRepo LABEL = 'Primary_Heating_System_SelfReport' ,
	MAX(Primary_Heating_System_Prescrib) AS Primary_Heating_System_Prescrib LABEL = 'Primary_Heating_System_Prescribed' ,
	MAX(Primary_Cooling_System_SelfRepo) AS Primary_Cooling_System_SelfRepo LABEL = 'Primary_Cooling_System_SelfReport' ,
	MAX(Primary_Cooling_System_Prescrib) AS Primary_Cooling_System_Prescrib LABEL = 'Primary_Cooling_System_Prescribed' ,
	MAX(Central_System_Number) AS Central_System_Number LABEL = 'Central_System_Number' ,
	MAX(Mini_Split_System_Number) AS Mini_Split_System_Number LABEL = 'Mini_Split_System_Number' ,
	MAX(Fuel) AS Fuel LABEL = 'Fuel' ,
	MAX(Distribution_Type) AS Distribution_Type LABEL = 'Distribution_Type' ,
	MAX(Mini_Split_Has_Ducts) AS Mini_Split_Has_Ducts LABEL = 'Mini_Split_Has_Ducts' ,
	MAX(Ducted_Mini_Split_Rooms_Served) AS Ducted_Mini_Split_Rooms_Served LABEL = 'Ducted_Mini_Split_Rooms_Served' ,
	MAX(Mini_Split_is_Multihead) AS Mini_Split_is_Multihead LABEL = 'Mini_Split_is_Multihead' ,
	MAX(Control_Type) AS Control_Type LABEL = 'Control_Type' ,
	MAX(Zones_Served) AS Zones_Served LABEL = 'Zones_Served' ,
	MAX(Zones_Served_Other) AS Zones_Served_Other LABEL = 'Zones_Served_Other' ,
	MAX(Make) AS Make LABEL = 'Make' ,
	MAX(Model) AS Model LABEL = 'Model' ,
	MAX(Model_Missing) AS Model_Missing LABEL = 'Model_Missing' ,
	MAX(Year_of_Manufacture) AS Year_of_Manufacture LABEL = 'Year_of_Manufacture' ,
	MAX(Serial_Number) AS Serial_Number LABEL = 'Serial_Number' ,
	MAX(Energy_Star_Label_Present) AS Energy_Star_Label_Present LABEL = 'Energy_Star_Label_Present' ,
	MAX(Cooling_Capacity_BTUh) AS Cooling_Capacity_BTUh LABEL = 'Cooling_Capacity_BTUh' ,
	MAX(SEER) AS SEER LABEL = 'SEER' ,
	MAX(SEER_is_Estimated) AS SEER_is_Estimated LABEL = 'SEER_is_Estimated' ,
	MAX(EER) AS EER LABEL = 'EER' ,
	MAX(EER_is_Estimated) AS EER_is_Estimated LABEL = 'EER_is_Estimated' ,
	MAX(Ignition_Type) AS Ignition_Type LABEL = 'Ignition_Type' ,
	MAX(Fuel_Valve_Type) AS Fuel_Valve_Type LABEL = 'Fuel_Valve_Type' ,
	MAX(Venting_Type) AS Venting_Type LABEL = 'Venting_Type' ,
	MAX(Heating_Size_kW) AS Heating_Size_kW LABEL = 'Heating_Size_kW' ,
	MAX(Heating_Size_kW_is_Est) AS Heating_Size_kW_is_Est LABEL = 'Heating_Size_kW_is_Est' ,
	MAX(Heating_Size_BTUh) AS Heating_Size_BTUh LABEL = 'Heating_Size_BTUh' ,
	MAX(Heating_Size_BTUh_is_Est) AS Heating_Size_BTUh_is_Est LABEL = 'Heating_Size_BTUh_is_Est' ,
	MAX(Baseboard_Length) AS Baseboard_Length LABEL = 'Baseboard_Length' ,
	MAX(Baseboard_Length_is_Est) AS Baseboard_Length_is_Est LABEL = 'Baseboard_Length_is_Est' ,
	MAX(HSPF) AS HSPF LABEL = 'HSPF' ,
	MAX(HSPF_is_Est) AS HSPF_is_Est LABEL = 'HSPF_is_Est' ,
	MAX(SS_In_Heat_Cap_BTUH) AS SS_In_Heat_Cap_BTUH LABEL = 'Single_Stage_Input_Heating_Capacity_BTUh' ,
	MAX(SS_In_Heat_Cap_BTUH_EST) AS SS_In_Heat_Cap_BTUH_EST LABEL = 'Single_Stage_Input_Heating_Capacity_BTUh_is_Est' ,
	MAX(SS_OUT_Heat_Cap_BTUH) AS SS_OUT_Heat_Cap_BTUH LABEL = 'Single_Stage_Output_Heating_Capacity_BTUh' ,
	MAX(SS_OUT_Heat_Cap_BTUH_EST) AS SS_OUT_Heat_Cap_BTUH_EST LABEL = 'Single_Stage_Output_Heating_Capacity_BTUh_is_Est' ,
	MAX(COP_or_AFUE) AS COP_or_AFUE LABEL = 'COP_or_AFUE' ,
	MAX(COP_or_AFUE_is_Est) AS COP_or_AFUE_is_Est LABEL = 'COP_or_AFUE_is_Est' ,
	MAX(High_In_Heat_Cap_BTUH) AS High_In_Heat_Cap_BTUH LABEL = 'High_Input_Heating_Capacity_BTUh' ,
	MAX(High_In_Heat_Cap_BTUH_EST) AS High_In_Heat_Cap_BTUH_EST LABEL = 'High_Input_Heating_Capacity_BTUh_is_Est' ,
	MAX(High_OUT_Heat_Cap_BTUH) AS High_OUT_Heat_Cap_BTUH LABEL = 'High_Output_Heating_Capacity_BTUh' ,
	MAX(High_OUT_Heat_Cap_BTUH_EST) AS High_OUT_Heat_Cap_BTUH_EST LABEL = 'High_Output_Heating_Capacity_BTUh_is_Est' ,
	MAX(High_Heat_Efficiency) AS High_Heat_Efficiency LABEL = 'High_Heating_Efficiency' ,
	MAX(High_Heat_Efficiency_EST) AS High_Heat_Efficiency_EST LABEL = 'High_Heating_Efficiency_is_Est' ,
	MAX(Low_In_Heat_Cap_BTUh) AS Low_In_Heat_Cap_BTUh LABEL = 'Low_Input_Heating_Capacity_BTUh' ,
	MAX(Low_In_Heat_Cap_BTUh_EST) AS Low_In_Heat_Cap_BTUh_EST LABEL = 'Low_Input_Heating_Capacity_BTUh_is_Est' ,
	MAX(Low_OUT_Heat_Cap_BTUh) AS Low_OUT_Heat_Cap_BTUh LABEL = 'Low_Output_Heating_Capacity_BTUh' ,
	MAX(Low_OUT_Heat_Cap_BTUh_EST) AS Low_OUT_Heat_Cap_BTUh_EST LABEL = 'Low_Output_Heating_Capacity_BTUh_is_Est' ,
	MAX(Low_Heat_Efficiency) AS Low_Heat_Efficiency LABEL = 'Low_Heating_Efficiency' ,
	MAX(Low_Heat_Efficiency_EST) AS Low_Heat_Efficiency_EST LABEL = 'Low_Heating_Efficiency_is_Est' ,
	MAX(Heat_Pump_Compressor_Works_in_H) AS Heat_Pump_Compressor_Works_in_H LABEL = 'Heat_Pump_Compressor_Works_in_Heating_Mode' ,
	MAX(Lockout_HeatPump_Heating_Temp_D) AS Lockout_HeatPump_Heating_Temp_D LABEL = 'Lockout_HeatPump_Heating_Temp_Determined' ,
	MAX(Lockout_HeatPump_Heating_Temp) AS Lockout_HeatPump_Heating_Temp LABEL = 'Lockout_HeatPump_Heating_Temp' ,
	MAX(Desuperheater_Present) AS Desuperheater_Present LABEL = 'Desuperheater_Present' ,
	MAX(System_on_same_Tstat_as_Heat_Pu) AS System_on_same_Tstat_as_Heat_Pu LABEL = 'System_on_same_Tstat_as_Heat_Pump' ,
	MAX(System_is_Backup_for_Heatpump) AS System_is_Backup_for_Heatpump LABEL = 'System_is_Backup_for_Heatpump' ,
	MAX(Fan_Type) AS Fan_Type LABEL = 'Fan_Type' ,
	MAX(Filter_Type) AS Filter_Type LABEL = 'Filter_Type' ,
	MAX(Dehumidifer_or_Economizer_Part_) AS Dehumidifer_or_Economizer_Part_ LABEL = 'Dehumidifer_or_Economizer_Part_of_System' ,
	MAX(Economizer) AS Economizer LABEL = 'Economizer' ,
	MAX(Humidifier_Present) AS Humidifier_Present LABEL = 'Humidifier_Present' ,
	MAX(Equipment_Use) AS Equipment_Use LABEL = 'Equipment_Use' ,
	MAX(Equipment_Use_Frequency) AS Equipment_Use_Frequency LABEL = 'Equipment_Use_Frequency' ,
	MAX(Days_of_Use_Per_Year) AS Days_of_Use_Per_Year LABEL = 'Days_of_Use_Per_Year' ,
	MAX(WiFi_Capable) AS WiFi_Capable LABEL = 'WiFi_Capable' ,
	MAX(Fireplace_Type) AS Fireplace_Type LABEL = 'Fireplace_Type' 
FROM HEMSRBSA.MECHANICAL_HEATINGANDCOOLING
GROUP BY EULR_ID, PK_Mechanical_ID
ORDER BY EULR_ID, PK_Mechanical_ID;
QUIT;

PROC FREQ DATA=BRIDGE;
WHERE Provides_Heating="Yes";
TABLES System_Type/MISSING NOCOL NOROW NOCUM NOPERCENT;
RUN;

/*
Primary_Heating_System_SelfRepo
Primary_Heating_System_Prescrib
Primary_Cooling_System_Prescrib
Primary_Cooling_System_SelfRepo
*/

PROC FREQ DATA=BRIDGE;
WHERE Provides_Heating="Yes" and Primary_Heating_System_Prescrib="Yes";
TABLES EULR_ID*System_Type/MISSING NOCOL NOROW NOCUM NOPERCENT;
RUN;


PROC FREQ DATA=BRIDGE;
WHERE Provides_Cooling="Yes";
TABLES System_Type/MISSING NOCOL NOROW NOCUM NOPERCENT;
RUN;

PROC FREQ DATA=BRIDGE;
WHERE Provides_Cooling="Yes" and Primary_Cooling_System_Prescrib="Yes";
TABLES EULR_ID*System_Type/MISSING NOCOL NOROW NOCUM NOPERCENT;
RUN;




/* DATA PREP - HEATING SYSTEM FLAGS */
DATA BRIDGE;
SET  BRIDGE;




DATA PROJECTS.HEMS_WEIGHTS;
SET  PROJECTS.HEMS_WEIGHTS;
WHERE Building_Type="Single Family";
LENGTH 
AC_BIN $ 21.
FUEL_BIN $ 20.
HEAT_BIN $ 20.
TEMP $ 20.
FHEAT_BIN $ 19.
VINTAGE_BIN $ 16.
SQFT_BIN $ 17.;
IF Primary_Cooling_System_Type IN ("None")
	THEN AC_BIN="NONE";
	ELSE IF Primary_Cooling_System_Type IN ("Central AC" "Central Air Source Heat Pump")
	THEN AC_BIN="CENTRAL AC";
	ELSE AC_BIN="WINDOW/PORTABLE/OTHER";

IF Primary_Heating_System_Type IN ("Furnace")
	THEN HEAT_BIN="FURNACE";
	ELSE IF Primary_Heating_System_Type IN ("Ductless Mini-split Heat Pump" "Central Air Source Heat Pump")
	THEN HEAT_BIN="HEAT PUMP";
	ELSE HEAT_BIN="OTHER";

IF Primary_Heating_Fuel_Type IN ("Natural gas")
	THEN FUEL_BIN="GAS";
	ELSE IF Primary_Heating_Fuel_Type ="Electric"
	THEN FUEL_BIN="ELECTRIC";
	ELSE FUEL_BIN="OTHER";
TEMP=CATX(": ",FUEL_BIN,HEAT_BIN);
IF Conditioned_Area<1400 
	THEN SQFT_BIN="LESS THAN 1,400";
	ELSE IF Conditioned_Area<2000 
	THEN SQFT_BIN="1,400-1,999";
	ELSE IF Conditioned_Area<2500 
	THEN SQFT_BIN="2,000-2,499";
	ELSE IF Conditioned_Area>=2500 
	THEN SQFT_BIN="2,500 OR LARGER";
	ELSE  SQFT_BIN="UNKNOWN";
IF Home_Vintage<1960 
	THEN VINTAGE_BIN="PRE-1960";
	ELSE IF Home_Vintage<1990 
	THEN VINTAGE_BIN="1960-1989";
	ELSE IF Home_Vintage<2005 
	THEN VINTAGE_BIN="1990-2004";
	ELSE IF Home_Vintage>=2005 
	THEN VINTAGE_BIN="BUILT AFTER 2005";
	ELSE  VINTAGE_BIN="UNKNOWN";

DO;
	IF TEMP IN ("GAS: FURNACE" "GAS: OTHER")
		THEN FHEAT_BIN="GAS HEAT";
	ELSE IF TEMP IN ("OTHER: FURNACE" "OTHER: OTHER")
		THEN FHEAT_BIN="OTHER HEAT"; 
	ELSE FHEAT_BIN=TEMP;
END;

DROP TEMP;

RUN;

proc contents data=HEMSRBSA.MECHANICAL_HEATINGANDCOOLING;
run;