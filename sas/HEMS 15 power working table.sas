DATA HEMS15_POWER (COMPRESS=YES);
SET HEMS_15.POWER_FIFTEEN;
format min_t DATETIME.
	max_t DATETIME.;
informat min_t ANYDTDTM40.
	max_t ANYDTDTM40.;
SERVICE= SUM('Mains With Solar'n, 'Mains'n, 'Mains Without Solar'n);
CIRCUIT_TOT=SUM(
'Ductless Heatpump'n ,
'Electric Resistance Storage Wate'n ,
'Garbage Disposal'n ,
'Electric Baseboard Heaters'n ,
'Stove/Oven/Range'n ,
'Other'n ,
'Hot Tub'n ,
'Dishwasher'n ,
'Clothes Dryer'n ,
'Clothes Washer'n ,
'Refrigerator/Freezer II'n ,
'Other Zonal Heat'n ,
'Refrigerator/Freezer'n ,
'Heat Pump Water Heater'n ,
'Microwave'n ,
'Gas Furnace (Component)'n ,
'Ducted Heatpump'n ,
'Electric Furnace'n ,
'MISC HEAT'n ,
'Central AC'n ,
'Other With Solar'n ,
'Electric Vehicle Charger'n ,
'Instantaneous Water Heater (Elec'n ,
'Electric - Air Source Heat Pump'n ,
'Instantaneous Water Heater (Gas)'n ,
'Room AC'n );
DO; 
	RENAME 	min_t=TEMP1
			max_t=min_t;
RENAME		TEMP1=max_t;
END;
RUN;

DATA HEMS15_POWER (COMPRESS=YES);
set  HEMS15_POWER;
	RENAME 	
			TEMP1=max_t;
RUN;

proc stdize data=HEMS15_POWER 
	out=HEMS15_POWER 
	reponly missing=0;

RUN;
PROC SORT DATA=HEMS15_POWER threads;
	by ee_site_id min_t;
run;

/*****************************************************/

/*****************************************************/
PROC SQL THREADS;
CREATE TABLE TEMP AS 
SELECT 	a.*,b.* 
FROM (HEMS_15.WEATHER_FIFTEEN_ALT AS a LEFT JOIN HEMS15_POWER AS b 
	ON a.ee_site_id= b.ee_site_id AND a.min_t= b.min_t) 
order BY  b.ee_site_id, a.min_t
;
QUIT;
/*****************************************************/

DATA TEMP (COMPRESS=YES);
SET  TEMP;
IF YEAR(DATEPART(MIN_T))=2018 THEN DELETE;

format O_min_t DATETIME.
	P_min_t DATETIME.;
informat O_min_t ANYDTDTM40.
	P_min_t ANYDTDTM40.;
DO;
DROP cz dew_point hz temp WIND_DIR wind_spd atm_pres state station_id ;

END;
DO;
	DUM5 = INPUT(temp_f,8.2);
	DROP temp_f;
	RENAME DUM5=temp_f;
END;

OFFSET=tz_utc_offset*3600;
O_min_t=min_t+OFFSET;
DO;
/**************************/
IF tz_utc_offset = -8 THEN TZ= "America/Los_Angeles";
ELSE IF tz_utc_offset = -7 THEN TZ = "America/Boise";
END;  

P_min_t = tzones2u(min_t,tz);
/**************************/
HOUR=HOUR(TIMEPART(O_min_t));
DAY=DAY(DATEPART(O_min_t));
MONTH=MONTH(DATEPART(O_min_t));
YEAR=YEAR(DATEPART(O_min_t));
MINUTE=MINUTE(TIMEPART(O_min_t));
YMDH=(YEAR*1000000)+(MONTH*10000)+(DAY*100)+HOUR;
MDH = (MONTH*10000)+(DAY*100)+HOUR;
MH=(MONTH*100)+HOUR;
RUN;



DATA HEMS35040 (COMPRESS=YES);
MERGE TEMP HEMS_15.IDX_HP;
BY ee_site_id; run;

%MACRO EU(V, V1);
PROC SQL THREADS;
CREATE TABLE HEMS15.HEMS35040_&V AS 
SELECT   
	MAX(&V1) AS &V1,
	MAX('MDHM'n) AS 'MDHM'n,
	MAX('MONTH'n) AS 'MONTH'n,
	MAX('HOUR'n) AS 'HOUR'n,
	MAX('MINUTE'n) AS 'MINUTE'n,
	MEAN(temp) AS temp,
	MEAN(temp_f) AS temp_f,
	SUM('Ductless Heatpump'n ) as 'Ductless Heatpump'n ,
	SUM('Electric Resistance Storage Wate'n ) as 'Electric Resistance Storage Wate'n ,
	SUM('Garbage Disposal'n ) as 'Garbage Disposal'n ,
	SUM('Electric Baseboard Heaters'n ) as 'Electric Baseboard Heaters'n ,
	SUM('Stove/Oven/Range'n ) as 'Stove/Oven/Range'n ,
	SUM('Other'n ) as 'Other'n ,
	SUM('Hot Tub'n ) as 'Hot Tub'n ,
	SUM('Dishwasher'n ) as 'Dishwasher'n ,
	SUM('Solar'n ) as 'Solar'n ,
	SUM('Mains With Solar'n ) as 'Mains With Solar'n ,
	SUM('Clothes Dryer'n ) as 'Clothes Dryer'n ,
	SUM('Clothes Washer'n ) as 'Clothes Washer'n ,
	SUM('Refrigerator/Freezer II'n ) as 'Refrigerator/Freezer II'n ,
	SUM('Other Zonal Heat'n ) as 'Other Zonal Heat'n ,
	SUM('Mains'n ) as 'Mains'n ,
	SUM('Refrigerator/Freezer'n ) as 'Refrigerator/Freezer'n ,
	SUM('Heat Pump Water Heater'n ) as 'Heat Pump Water Heater'n ,
	SUM('Microwave'n ) as 'Microwave'n ,
	SUM('Gas Furnace (Component)'n ) as 'Gas Furnace (Component)'n ,
	SUM('Ducted Heatpump'n ) as 'Ducted Heatpump'n ,
	SUM('Electric Furnace'n ) as 'Electric Furnace'n ,
	SUM('MISC HEAT'n ) as 'MISC HEAT'n ,
	SUM('Central AC'n ) as 'Central AC'n ,
	SUM('Other With Solar'n ) as 'Other With Solar'n ,
	SUM('Electric Vehicle Charger'n ) as 'Electric Vehicle Charger'n ,
	SUM('Instantaneous Water Heater (Elec'n ) as 'Instantaneous Water Heater (Elec'n ,
	SUM('Electric - Air Source Heat Pump'n ) as 'Electric - Air Source Heat Pump'n ,
	SUM('Instantaneous Water Heater (Gas)'n ) as 'Instantaneous Water Heater (Gas)'n ,
	SUM('Mains Without Solar'n ) as 'Mains Without Solar'n ,
	SUM('Room AC'n ) as 'Room AC'n ,
	SUM('SERVICE'n ) as 'SERVICE'n ,
	SUM('CIRCUIT_TOT'n ) as 'CIRCUIT_TOT'n ,
	MAX('site_id'n) AS 'site_id'n,
	MAX('state'n) AS 'state'n,
FROM TEMP
GROUP BY ee_site_id, MDHM;
quit;

*******************************************************;
/* SOME CLEANUP TO MAKE ANY NULL VALUES = 0 */
*******************************************************;

DATA HEMS60_POWER (COMPRESS=YES);
SET  HEMS60_POWER;
IF 'Clothes Dryer'n = . THEN 'Clothes Dryer'n = 0 ;
IF 'Mains With Solar'n = . THEN 'Mains With Solar'n = 0 ;
IF 'Electric Baseboard Heaters'n = . THEN 'Electric Baseboard Heaters'n = 0 ;
IF 'Solar'n = . THEN 'Solar'n = 0 ;
IF 'Ductless Heatpump'n = . THEN 'Ductless Heatpump'n = 0 ;
IF 'Other'n = . THEN 'Other'n = 0 ;
IF 'Dishwasher'n = . THEN 'Dishwasher'n = 0 ;
IF 'Hot Tub'n = . THEN 'Hot Tub'n = 0 ;
IF 'Garbage Disposal'n = . THEN 'Garbage Disposal'n = 0 ;
IF 'Stove/Oven/Range'n = . THEN 'Stove/Oven/Range'n = 0 ;
IF 'Clothes Washer'n = . THEN 'Clothes Washer'n = 0 ;
IF 'Electric Resistance Storage Wate'n = . THEN 'Electric Resistance Storage Wate'n = 0 ;
IF 'Mains'n = . THEN 'Mains'n = 0 ;
IF 'Other Zonal Heat'n = . THEN 'Other Zonal Heat'n = 0 ;
IF 'Refrigerator/Freezer'n = . THEN 'Refrigerator/Freezer'n = 0 ;
IF 'Microwave'n = . THEN 'Microwave'n = 0 ;
IF 'Heat Pump Water Heater'n = . THEN 'Heat Pump Water Heater'n = 0 ;
IF 'Gas Furnace (Component)'n = . THEN 'Gas Furnace (Component)'n = 0 ;
IF 'Ducted Heatpump'n = . THEN 'Ducted Heatpump'n = 0 ;
IF 'HEAT_MISC'n = . THEN 'HEAT_MISC'n = 0 ;
IF 'Electric Furnace'n = . THEN 'Electric Furnace'n = 0 ;
IF 'Central AC'n = . THEN 'Central AC'n = 0 ;
IF 'BATH_HEAT'n = . THEN 'BATH_HEAT'n = 0 ;
IF 'Other With Solar'n = . THEN 'Other With Solar'n = 0 ;
IF 'Electric Vehicle Charger'n = . THEN 'Electric Vehicle Charger'n = 0 ;
IF 'Instantaneous Water Heater (Elec'n = . THEN 'Instantaneous Water Heater (Elec'n = 0 ;
IF 'Instantaneous Water Heater (Gas)'n = . THEN 'Instantaneous Water Heater (Gas)'n = 0 ;
IF 'Mains Without Solar'n = . THEN 'Mains Without Solar'n = 0 ;
IF 'Room AC'n = . THEN 'Room AC'n = 0 ;
IF 'CIRCUIT_TOT'n = . THEN 'CIRCUIT_TOT'n = 0 ;
MDH = (MONTH*10000)+(DAY*100)+HOUR;
************************************************************;
MH = (MONTH*100)+HOUR;
RUN;
PROC SORT DATA=HEMS60_POWER;
	BY ee_site_id;
DATA HEMS60_POWER;
MERGE HEMS60_POWER HEMS_15.IDX_HP;
	BY 	ee_site_id;
RUN;