/* Import a csv file from the location specified on the filename statement */
/* The SAS data set created is named by substituting a name for work.mycsv */

filename csv "D:\HEMS 1\Flat_Power_one_DIAG.csv";

/* Import the CSV file  */
proc import datafile=csv out=HEMS.Flat_Power_one_DIAG dbms=csv REPLACE; GUESSINGROWS=1000000;
   getnames=yes;
   run;

/* Print the first 10 observations **/
proc print data=HEMS.Flat_Power_one_DIAG(obs=10);
   run;

filename csv;

PROC CONTENTS DATA=HEMS.Flat_Power_one_DIAG; RUN;

DATA HEMS.Flat_Power_one_DIAG (COMPRESS=YES);
SET  HEMS.Flat_Power_one_DIAG;
FORMAT timestamp DATETIME.;
DO;
DUM1=INPUT('Ductless Heatpump_3 P'n,BEST12.);
DROP 'Ductless Heatpump_3 P'n;
RENAME DUM1='Ductless Heatpump_3 P'n;

DUM2=INPUT('Ductless Heatpump_4 P'n,BEST12.);
DROP 'Ductless Heatpump_4 P'n;
RENAME DUM2='Ductless Heatpump_4 P'n;

DUM3=INPUT('Mains_2 P'n,BEST12.);
DROP 'Mains_2 P'n;
RENAME DUM3='Mains_2 P'n;

DUM4=INPUT('Mains_3 P'n,BEST12.);
DROP 'Mains_3 P'n;
RENAME DUM4='Mains_3 P'n;

DUM5=INPUT('Microwave_2 P'n,BEST12.);
DROP 'Microwave_2 P'n;
RENAME DUM5='Microwave_2 P'n;

DUM6=INPUT('Other Zonal Heat_6 P'n,BEST12.);
DROP 'Other Zonal Heat_6 P'n;
RENAME DUM6='Other Zonal Heat_6 P'n;

DUM7=INPUT('Other Zonal Heat_7 P'n,BEST12.);
DROP 'Other Zonal Heat_7 P'n;
RENAME DUM7='Other Zonal Heat_7 P'n;
END;

DO;
IF 'SOLAR P'n =. THEN 'SOLAR P'n=0;
IF 'MAINS P'n =. THEN 'MAINS P'n=0;
IF 'MAINS_2 P'n =. THEN 'MAINS_2 P'n=0;
IF 'MAINS_3 P'n =. THEN 'MAINS_3 P'n=0;
MAINS=SUM('MAINS P'n, 'MAINS_2 P'n, 'MAINS_3 P'n);
IF 'Mains With Solar P'n = . THEN 'Mains With Solar P'n=0;
MONTH=MONTH(DATEPART(timestamp));
DAY=DAY(DATEPART(timestamp));
HOUR=HOUR(TIMEPART(timestamp));
MINUTE=MINUTE(TIMEPART(timestamp));
DOW=WEEKDAY(DATEPART(timestamp));
END;
IF EE_SITE_ID IN(3636 9041) THEN DO;
	IF 'Other With Solar P'n<0 then 'Solar P'n = 'Other With Solar P'n;
	ELSE 'Other_99 P'n ='Other With Solar P'n;
END;

SERVICE = MAINS+('Mains With Solar P'n-'SOLAR P'n);
IF MONTH=2 THEN MONTH_="FEBRUARY";
	ELSE IF MONTH=7 THEN MONTH_="JULY";
		ELSE MONTH_="WTF";

IF DOW IN (1,7) THEN WEEKEND="WEEKEND";
	ELSE WEEKEND="WEEKDAY";
RUN;


DATA HEMS.Flat_Power_one_DIAG (COMPRESS=YES);
SET  HEMS.Flat_Power_one_DIAG;
rename 'Other Zonal Heat_7 P'n = 'Other Zonal Heat_6 P'n;
RENAME DUM7='Other Zonal Heat_7 P'n;
run;


DATA TEST (COMPRESS=YES);
SET  HEMS.Flat_Power_one_DIAG;

ARRAY ZEROS[89]
'AC P'n
'Central AC P'n
'Central AC_2 P'n
'Central AC_3 P'n
'Central AC_4 P'n
'Central AC_5 P'n
'Central Vacuum P'n
'Clothes Dryer P'n
'Clothes Dryer_2 P'n
'Clothes Washer P'n
'Clothes Washer_2 P'n
'Dishwasher P'n
'Dishwasher_2 P'n
'Ducted Heatpump P'n
'Ducted Heatpump_2 P'n
'Ductless Heatpump P'n
'Ductless Heatpump_2 P'n
'Electric Baseboard Heaters P'n
'Electric Baseboard Heaters_2 P'n
'Electric Baseboard Heaters_3 P'n
'Electric Baseboard Heaters_4 P'n
'Electric Baseboard Heaters_5 P'n
'Electric Baseboard Heaters_6 P'n
'Electric Furnace P'n
'Electric Furnace_2 P'n
'Electric Resistance Storage Wate'n
'EULR BOX P'n
'EVSE P'n
'Garbage Disposal P'n
'Garbage Disposal_2 P'n
'Gas Furnace (Component) P'n
'Gas Furnace (Component)_2 P'n
'Gas Furnace (Component)_3 P'n
'Heat Pump Water Heater P'n
'Heat Pump Water Heater_2 P'n
'Hot Tub P'n
'Hot Tub_2 P'n
'Instantaneous Water Heater (Elec'n
'Instantaneous Water Heater (Gas)'n
'Mains P'n
'Mains With Solar P'n
'Microwave P'n
'Other P'n
'Other Large Load P'n
'Other Large Load_2 P'n
'Other With Solar P'n
'Other Zonal Heat P'n
'Other Zonal Heat_2 P'n
'Other Zonal Heat_3 P'n
'Other Zonal Heat_4 P'n
'Other Zonal Heat_5 P'n
'Other_10 P'n
'Other_11 P'n
'Other_12 P'n
'Other_13 P'n
'Other_14 P'n
'Other_15 P'n
'Other_16 P'n
'Other_17 P'n
'Other_18 P'n
'Other_19 P'n
'Other_2 P'n
'Other_3 P'n
'Other_4 P'n
'Other_5 P'n
'Other_6 P'n
'Other_7 P'n
'Other_8 P'n
'Other_9 P'n
'PUMP P'n
'PUMP_2 P'n
'Refrigerator/Freezer P'n
'Refrigerator/Freezer_2 P'n
'Refrigerator/Freezer_3 P'n
'Refrigerator/Freezer_4 P'n
'Room AC P'n
'Solar P'n
'Stove/Oven/Range P'n
'Stove/Oven/Range_2 P'n
'Stove/Oven/Range_3 P'n
'Sub Panel P'n
'Ductless Heatpump_3 P'n
'Ductless Heatpump_4 P'n
'Mains_2 P'n
'Mains_3 P'n
'Microwave_2 P'n
'Other Zonal Heat_7 P'n
'Other Zonal Heat_6 P'n
'Other_99 P'n
;
DO i=1 TO 89;
IF ZEROS[i]=. THEN ZEROS[i]=0;
END;