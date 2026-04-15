DATA WEATHER (COMPRESS=YES);
SET HEMS_15.WEATHER_FIFTEEN;
IF TEMP_F="NA" THEN TEMP_F="";
DO;
	DUM=INPUT(TEMP_F,BEST8.2);
	DROP TEMP_F;
	RENAME DUM=temp_f;
END;
MONTH=MONTH(DATEPART(MIN_T));
YEAR=YEAR(DATEPART(MIN_T));
DAY=DAY(DATEPART(MIN_T));
MINUTE=MINUTE(TIMEPART(MIN_T));
HOUR=HOUR(TIMEPART(MIN_T));
RUN;

PROC SORT DATA=WORK.WEATHER THREADS;
	BY station_id min_t;
PROC SORT DATA=HEMS_15.SITES THREADS;
	BY station_id;
RUN;

DATA WORK.WEATHER (COMPRESS=YES);
MERGE WORK.WEATHER (IN=i) HEMS_15.SITES (IN=j);
	BY station_id;
	IF i=1 THEN OUTPUT;
RUN;	
ods graphics / reset width=6.4in height=4.8in imagemap;

proc sgplot data=WORK.WEATHER;
where year=2021 and state="OR";
	scatter x=HOUR y=temp_f / group=MONTH;
	xaxis grid;
	yaxis grid;
run;

ods graphics / reset;
PROC UNIVARIATE DATA = WEATHER;
CLASS STATION_ID;
VAR TEMP_F;
RUN;

/*************************************************/
/*************************************************/
/*************************************************/
/*************************************************/
/*************************************************/
DATA WEATHER (COMPRESS=YES);
SET HEMS_15.WEATHER_FIFTEEN;
IF TEMP_F="NA" THEN TEMP_F="";
DO;
	DUM=INPUT(TEMP_F,BEST8.2);
	DROP TEMP_F;
	RENAME DUM=temp_f;
END;

RUN;

PROC SORT DATA=WORK.WEATHER THREADS;
	BY station_id min_t;
PROC SORT DATA=HEMS_15.SITES THREADS;
	BY station_id;
RUN;

DATA WORK.WEATHER (COMPRESS=YES);
MERGE WORK.WEATHER (IN=i) HEMS_15.SITES (IN=j);
	BY station_id;
	IF i=1 THEN OUTPUT;
RUN;	

DATA WEATHER (COMPRESS=YES);
SET  WEATHER;
format O_min_t DATETIME.
	P_min_t DATETIME.;
informat O_min_t ANYDTDTM40.
	P_min_t ANYDTDTM40.;
DO;
 IF cz="NA" THEN cz =".";
 IF dew_point="NA" THEN dew_point =".";
 IF hz="NA" THEN hz =".";
 IF temp="NA" THEN temp =".";
 IF temp_f="NA" THEN temp_f =".";
 IF WIND_DIR="NA" THEN WIND_DIR ="."; 
IF wind_spd="NA" THEN wind_spd =".";
IF atm_pres="NA" THEN atm_pres =".";

END;

DO;
DUM1 = INPUT(CZ,8.2);
DROP CZ;
RENAME DUM1=CZ;
END;
DO;
DUM2 = INPUT(dew_point,8.2);
DROP dew_point;
RENAME DUM2=dew_point;
END;
DO;
DUM3 = INPUT(HZ,8.2);
DROP HZ;
RENAME DUM3=HZ;
END;
DO;
DUM4 = INPUT(temp,8.2);
DROP temp;
RENAME DUM4=temp;
END;
DO;
DUM6 = INPUT(wind_spd,8.2);
DROP wind_spd;
RENAME DUM6=wind_spd;
END;
DO;
DUM7 = INPUT(wind_dir,8.2);
DROP wind_dir;
RENAME DUM7=wind_dir;
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
HOUR=HOUR(TIMEPART(P_min_t));
DAY=DAY(DATEPART(P_min_t));
MONTH=MONTH(DATEPART(P_min_t));
YEAR=YEAR(DATEPART(P_min_t));
MINUTE=MINUTE(TIMEPART(P_min_t));
YMDH=(YEAR*1000000)+(MONTH*10000)+(DAY*100)+HOUR;
MDH = (MONTH*10000)+(DAY*100)+HOUR;
MH=(MONTH*100)+HOUR;


RUN;
DATA PROJECTS.WEATHER;
SET WEATHER; RUN;
