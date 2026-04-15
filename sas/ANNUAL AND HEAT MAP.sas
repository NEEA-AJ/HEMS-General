proc contents data=hems_15.power_test; run;
proc contents data=hems_15.points; run;
PROC SORT DATA=HEMS_15.POINTS THREADS;
	BY REGNAME;
DATA HEMS_15.Regname;
	MERGE HEMS_15.Regname_idx HEMS_15.POINTS;
	BY REGNAME;
PROC SORT DATA=	HEMS_15.Regname THREADS;
		BY ee_site_id REG_IDX;
PROC SORT DATA=hems_15.power_test THREADS;
	BY ee_site_id REG_IDX;
RUN;

proc contents data=hems_15.MASTER_X; run;

DATA hems_15.MASTER_X (COMPRESS="YES");
SET  hems_15.MASTER_X;
DO;
	YEAR=YEAR(datepart(MIN_t));
	MONTH=month(datepart(MIN_t));
	DAY=DAY(datepart(MIN_t));
	HOUR=HOUR(TIMEPART(MIN_t));
	MINUTE=MINUTE(TIMEPART(MIN_t));
END;
YMD=(YEAR*10000)+(MONTH*100)+DAY;

RUN;

PROC SQL THREADS;
CREATE TABLE HEMS_15.ANNUAL_P AS 
SELECT 
MAX(min_t) AS min_t,
MAX(max_t) AS max_t,
MAX(YEAR) AS YEAR,
MAX(MONTH ) AS MONTH ,
MAX(DAY) AS DAY,
MAX(HOUR) AS HOUR,
MAX(MINUTE) AS MINUTE,
MAX(YMD) AS YMD,
MEAN(Other) AS Other,
MEAN(Electric_Baseboard_Heaters) AS Electric_Baseboard_Heaters,
MEAN(Garbage_Disposal) AS Garbage_Disposal,
MEAN(Clothes_Dryer) AS Clothes_Dryer,
MEAN(Dishwasher) AS Dishwasher,
MEAN(Clothes_Washer) AS Clothes_Washer,
MEAN(Ductless_Heatpump) AS Ductless_Heatpump,
MEAN(Electric_Resistance_Storage_Wate) AS Electric_Resistance_Storage_Wate,
MEAN(Hot_Tub) AS Hot_Tub,
MEAN(Mains_With_Solar) AS Mains_With_Solar,
MEAN(Stove_Oven_Range) AS Stove_Oven_Range,
MEAN(Other_Zonal_Heat) AS Other_Zonal_Heat,
MEAN(Mains) AS Mains,
MEAN(Refrigerator_Freezer) AS Refrigerator_Freezer,
MEAN(Heat_Pump_Water_Heater) AS Heat_Pump_Water_Heater,
MEAN(Microwave) AS Microwave,
MEAN(Gas_Furnace__Component_) AS Gas_Furnace__Component_,
MEAN(Ducted_Heatpump) AS Ducted_Heatpump,
MEAN(Electric_Furnace) AS Electric_Furnace,
MEAN(Central_AC) AS Central_AC,
MEAN(Room_AC) AS Room_AC,
MEAN(Other_With_Solar) AS Other_With_Solar,
MEAN(Electric_Vehicle_Charger) AS Electric_Vehicle_Charger,
MEAN(Instantaneous_Water_Heater__Elec) AS Instantaneous_Water_Heater__Elec,
MEAN(Solar) AS Solar,
MEAN(Instantaneous_Water_Heater__Gas_) AS Instantaneous_Water_Heater__Gas_,
MEAN(Other_ap) AS Other_ap,
MEAN(Electric_Baseboard_Heaters_ap) AS Electric_Baseboard_Heaters_ap,
MEAN(Garbage_Disposal_ap) AS Garbage_Disposal_ap,
MEAN(Clothes_Dryer_ap) AS Clothes_Dryer_ap,
MEAN(Dishwasher_ap) AS Dishwasher_ap,
MEAN(Clothes_Washer_ap) AS Clothes_Washer_ap,
MEAN(Ductless_Heatpump_ap) AS Ductless_Heatpump_ap,
MEAN(Hot_Tub_ap) AS Hot_Tub_ap,
MEAN(Mains_With_Solar_ap) AS Mains_With_Solar_ap,
MEAN(Stove_Oven_Range_ap) AS Stove_Oven_Range_ap,
MEAN(Other_Zonal_Heat_ap) AS Other_Zonal_Heat_ap,
MEAN(Mains_ap) AS Mains_ap,
MEAN(Refrigerator_Freezer_ap) AS Refrigerator_Freezer_ap,
MEAN(Heat_Pump_Water_Heater_ap) AS Heat_Pump_Water_Heater_ap,
MEAN(Microwave_ap) AS Microwave_ap,
MEAN(Gas_Furnace__Component__ap) AS Gas_Furnace__Component__ap,
MEAN(Ducted_Heatpump_ap) AS Ducted_Heatpump_ap,
MEAN(Electric_Furnace_ap) AS Electric_Furnace_ap,
MEAN(Central_AC_ap) AS Central_AC_ap,
MEAN(Room_AC_ap) AS Room_AC_ap,
MEAN(Other_With_Solar_ap) AS Other_With_Solar_ap,
MEAN(Electric_Vehicle_Charger_ap) AS Electric_Vehicle_Charger_ap,
MEAN(Solar_ap) AS Solar_ap,
MEAN(Other_pf) AS Other_pf,
MEAN(Electric_Baseboard_Heaters_pf) AS Electric_Baseboard_Heaters_pf,
MEAN(Garbage_Disposal_pf) AS Garbage_Disposal_pf,
MEAN(Clothes_Dryer_pf) AS Clothes_Dryer_pf,
MEAN(Dishwasher_pf) AS Dishwasher_pf,
MEAN(Clothes_Washer_pf) AS Clothes_Washer_pf,
MEAN(Ductless_Heatpump_pf) AS Ductless_Heatpump_pf,
MEAN(Hot_Tub_pf) AS Hot_Tub_pf,
MEAN(Mains_With_Solar_pf) AS Mains_With_Solar_pf,
MEAN(Stove_Oven_Range_pf) AS Stove_Oven_Range_pf,
MEAN(Other_Zonal_Heat_pf) AS Other_Zonal_Heat_pf,
MEAN(Mains_pf) AS Mains_pf,
MEAN(Refrigerator_Freezer_pf) AS Refrigerator_Freezer_pf,
MEAN(Heat_Pump_Water_Heater_pf) AS Heat_Pump_Water_Heater_pf,
MEAN(Microwave_pf) AS Microwave_pf,
MEAN(Gas_Furnace__Component__pf) AS Gas_Furnace__Component__pf,
MEAN(Ducted_Heatpump_pf) AS Ducted_Heatpump_pf,
MEAN(Electric_Furnace_pf) AS Electric_Furnace_pf,
MEAN(Central_AC_pf) AS Central_AC_pf,
MEAN(Room_AC_pf) AS Room_AC_pf,
MEAN(Other_With_Solar_pf) AS Other_With_Solar_pf,
MEAN(Electric_Vehicle_Charger_pf) AS Electric_Vehicle_Charger_pf,
MEAN(Solar_pf) AS Solar_pf,
MAX(transmitter_code) AS transmitter_code,
MEAN(temp) AS temp,
MEAN(humidity) AS humidity,
MEAN(hz) AS hz,
MEAN(cz) AS cz,
MAX(tz_abbr) AS tz_abbr,
MEAN(tz_utc_offset) AS tz_utc_offset,
MAX(station_id) AS station_id

FROM hems_15.MASTER_X
GROUP BY  min_t
;
QUIT;

proc sgplot data=hems_15.MASTER_X SUBPIXEL;
TITLE BOLD FONT=Helvetica HEIGHT=14PT COLOR=GREEN "Electric Load (kWh)" ;
TITLE2 FONT=Helvetica HEIGHT=12PT COLOR=BLACK "HEAT MAP" ;
TITLE3 ITALIC FONT=Helvetica HEIGHT=10PT COLOR=BLACK "y=month/day x=hour" ;
heatmap x=HOUR y=YMD /  name="heatmap"
 colorResponse=Mains colorstat=MEAN  discreteY  discreteX colorModel=(PURPLE BLUE GREEN YELLOW ORANGE red);
run;
