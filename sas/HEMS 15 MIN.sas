proc contents data=hems.Hems_sites;
run;

proc contents data=hems.Points;
run;

proc contents data=hems.Power_fifteen;
run;

proc contents data=hems.Humidity_fifteen_stg;
run;

proc contents data=hems.Temperature_fifteen;
run;

proc contents data=hems.Thd_fifteen;
run;

proc contents data=Humidity_fifteen;
run;
DATA HEMS_15.POWER_FIFTEEN (COMPRESS="YES");
SET HEMS.POWER_FIFTEEN;
LENGTH REGNAME $ 25.;
RUN;

  /***********************/
 /***** P O I N T S *****/
/***********************/
proc sql THREADS;
   create table HEMS_15.POINTS as
   select  
		circuit_label AS circuit_label FORMAT = $18. LENGTH=18, 
		circuit_label_type_desc AS circuit_label_type_desc format = $32. LENGTH=32, 
		circuit_label_type_id, 
		day_zero_dt,  
		ee_site_id , 
		equipment_type_desc AS equipment_type_desc format = $32. LENGTH=32, 
		point_id ,
		regname AS regname format = $12. LENGTH=12
		FROM HEMS.POINTS
		GROUP by ee_site_id ,regname
		order by ee_site_id ,regname;
quit;

  /*********************/
 /***** S I T E S *****/
/*********************/
  proc import datafile="M:\HEMS Public Data\sites.csv"
       out=HEMS_15.SITES  /* adapted */
       dbms=csv
       replace;
       getnames=YES; guessingrows=1000;
PROC SORT DATA=HEMS_15.SITES THREADS;
	BY ee_site_id;
RUN;

  /************************************************/
 /***** T E M P E R A T U R E  - P O I N T S *****/
/************************************************/
  proc import datafile="M:\HEMS Public Data\temperature-points.csv"
       out=HEMS_15.temperature_points  /* adapted */
       dbms=csv
       replace;
       getnames=YES; guessingrows=1000;
PROC SORT DATA=HEMS_15.temperature_points THREADS;
	BY ee_site_id;
RUN;



  /************************************/
 /***** P O W E R  F I F T E E N *****/
/************************************/

/* This macro should import all files specified in the list and save them as datasets */
%macro loop;
%do i = 1 %to &Total;
  proc import datafile="&path\&&FileA&i"
       out=&&name&i  /* adapted */
       dbms=csv
       replace;
       getnames=YES;

DATA HEMS_15.POWER_FIFTEEN (COMPRESS="YES");
SET &&name&i;
  run;

%end;
%mend loop;
 
%loop
%let path=M:\HEMS Public Data\2018_Q3_v3\2018_Q3_v3\Sep\power;
/*%let FOLDER=power;*/

/*******************************************/
/*********************************************/
%MACRO IDIOT(V1);
filename folder "&V1\";
/*libname c 'C:\Temp';         /* just an example destination folder */
options validmemname=extend; /* to allow non-standard dataset names */
 
/* Making a list of all files in the folder */
data FilesInFolder;
   length Line 8 File $300;
   List = dopen('folder');  /* corrected the function argument */
   do Line = 1 to dnum(List);
        FileA = trim(dread(List,Line));
        output;
   end;
   drop list line;
run;

DATA FilesInFolder;
SET  FilesInFolder;
FILE=CATT('POWER_FIFTEEN',SUBSTR(FILEA,14));
RUN;
PROC PRINT DATA=FILESINFOLDER;
RUN;
 
/* Creating global macro variables */  /* not "local" */
data _NULL_;
     set FilesInFolder end=final;
	 call symput(cats('FileA', _N_), trim(FileA));  
     call symput(cats('File', _N_), trim(File));     /* used CATS instead of COMPRESS (...||...) */
     call symput(cats('Name', _N_), trim(nliteral(substr(File,1,min(32, length(File)-4))))); /* inserted */
     if final then call symputx(trim('Total'), _N_); /* replaced symput by symputx */
run;

/* This macro should import all files specified in the list and save them as datasets */
%macro loop;
%do i = 1 %to &Total;
  proc import datafile="&V1\&&FileA&i"
       out=&&name&i  /* adapted */
       dbms=csv
       replace;
       getnames=YES; guessingrows=10000;

DATA HEMS_15.POWER_FIFTEEN (COMPRESS="YES");
SET HEMS_15.POWER_FIFTEEN &&name&i;
  run;

%end;
%mend loop;
%mend idiot;



  /*******************************/
 /***** T E M P R A T U R E *****/
/*******************************/

%MACRO IDIOT(V1);
filename folder "&V1\";
/*libname c 'C:\Temp';         /* just an example destination folder */
options validmemname=extend; /* to allow non-standard dataset names */
 
/* Making a list of all files in the folder */
data FilesInFolder;
   length Line 8 File $300;
   List = dopen('folder');  /* corrected the function argument */
   do Line = 1 to dnum(List);
        FileA = trim(dread(List,Line));
        output;
   end;
   drop list line;
run;

DATA FilesInFolder;
SET  FilesInFolder;
FILE=CATT('TEMPERATURE_FIFTEEN',SUBSTR(FILEA,20));/* Creates SAS Friendly File Name */
RUN;
PROC PRINT DATA=FILESINFOLDER;
RUN;
 
/* Creating global macro variables */  /* not "local" */
data _NULL_;
     set FilesInFolder end=final;
	 call symput(cats('FileA', _N_), trim(FileA));  
     call symput(cats('File', _N_), trim(File));     /* used CATS instead of COMPRESS (...||...) */
     call symput(cats('Name', _N_), trim(nliteral(substr(File,1,min(32, length(File)-4))))); /* inserted */
     if final then call symputx(trim('Total'), _N_); /* replaced symput by symputx */
run;

/* This macro should import all files specified in the list and save them as datasets */
%macro loop;
%do i = 1 %to &Total;
  proc import datafile="&V1\&&FileA&i"
       out=&&name&i  /* adapted */
       dbms=csv
       replace;
       getnames=YES; guessingrows=10000;

DATA HEMS_15.TEMPERATURE_FIFTEEN (COMPRESS="YES");
SET HEMS_15.TEMPERATURE_FIFTEEN &&name&i;
  run;

%end;
%mend loop;
 
%loop

%mend idiot;
%idiot(M:\HEMS Public Data\2018_Q3_v3\2018_Q3_v3\SEP\TEMPERATURE);
%idiot(M:\HEMS Public Data\2018_Q4_v3\2018_Q4_v3\OCT\TEMPERATURE);
%idiot(M:\HEMS Public Data\2018_Q4_v3\2018_Q4_v3\NOV\TEMPERATURE);
%idiot(M:\HEMS Public Data\2018_Q4_v3\2018_Q4_v3\DEC\TEMPERATURE);
%idiot(M:\HEMS Public Data\2019_Q1_v3\2019_Q1_v3\JAN\TEMPERATURE);
%idiot(M:\HEMS Public Data\2019_Q1_v3\2019_Q1_v3\FEB\TEMPERATURE);
%idiot(M:\HEMS Public Data\2019_Q1_v3\2019_Q1_v3\MAR\TEMPERATURE);
%idiot(M:\HEMS Public Data\2019_Q2_v3\2019_Q2_v3\APR\TEMPERATURE);
%idiot(M:\HEMS Public Data\2019_Q2_v3\2019_Q2_v3\MAY\TEMPERATURE);
%idiot(M:\HEMS Public Data\2019_Q2_v3\2019_Q2_v3\JUN\TEMPERATURE);
%idiot(M:\HEMS Public Data\2019_Q3_v3\2019_Q3_v3\JUL\TEMPERATURE);
%idiot(M:\HEMS Public Data\2019_Q3_v3\2019_Q3_v3\AUG\TEMPERATURE);
%idiot(M:\HEMS Public Data\2019_Q3_v3\2019_Q3_v3\SEP\TEMPERATURE);
%idiot(M:\HEMS Public Data\2019_Q4_v3\2019_Q4_v3\OCT\TEMPERATURE);
%idiot(M:\HEMS Public Data\2019_Q4_v3\2019_Q4_v3\NOV\TEMPERATURE);
/*%idiot(M:\HEMS Public Data\2019_Q4_v3\2019_Q4_v3\DEC\TEMPERATURE);*/
%idiot(M:\HEMS Public Data\2020_Q1_v3\2020_Q1_v3\JAN\TEMPERATURE);
%idiot(M:\HEMS Public Data\2020_Q1_v3\2020_Q1_v3\FEB\TEMPERATURE);
%idiot(M:\HEMS Public Data\2020_Q1_v3\2020_Q1_v3\MAR\TEMPERATURE);



  /***************************/
 /***** H U M I D I T Y *****/
/***************************/

%MACRO IDIOT(V1);
filename folder "&V1\";
/*libname c 'C:\Temp';         /* just an example destination folder */
options validmemname=extend; /* to allow non-standard dataset names */
 
/* Making a list of all files in the folder */
data FilesInFolder;
   length Line 8 File $300;
   List = dopen('folder');  /* corrected the function argument */
   do Line = 1 to dnum(List);
        FileA = trim(dread(List,Line));
        output;
   end;
   drop list line;
run;

DATA FilesInFolder;
SET  FilesInFolder;
FILE=CATT('HUMIDITY_FIFTEEN',SUBSTR(FILEA,16));/* Creates SAS Friendly File Name */
RUN;
PROC PRINT DATA=FILESINFOLDER;
RUN;
 
/* Creating global macro variables */  /* not "local" */
data _NULL_;
     set FilesInFolder end=final;
	 call symput(cats('FileA', _N_), trim(FileA));  
     call symput(cats('File', _N_), trim(File));     /* used CATS instead of COMPRESS (...||...) */
     call symput(cats('Name', _N_), trim(nliteral(substr(File,1,min(32, length(File)-4))))); /* inserted */
     if final then call symputx(trim('Total'), _N_); /* replaced symput by symputx */
run;

/* This macro should import all files specified in the list and save them as datasets */
%macro loop;
%do i = 1 %to &Total;
  proc import datafile="&V1\&&FileA&i"
       out=&&name&i  /* adapted */
       dbms=csv
       replace;
       getnames=YES; guessingrows=10000;

DATA HEMS_15.HUMIDITY_FIFTEEN (COMPRESS="YES");
SET HEMS_15.HUMIDITY_FIFTEEN &&name&i;
  run;

%end;
%mend loop;
 
%loop

%mend idiot;
%idiot(M:\HEMS Public Data\2018_Q3_v3\2018_Q3_v3\SEP\HUMIDITY);
%idiot(M:\HEMS Public Data\2018_Q4_v3\2018_Q4_v3\OCT\HUMIDITY);
%idiot(M:\HEMS Public Data\2018_Q4_v3\2018_Q4_v3\NOV\HUMIDITY);
%idiot(M:\HEMS Public Data\2018_Q4_v3\2018_Q4_v3\DEC\HUMIDITY);
%idiot(M:\HEMS Public Data\2019_Q1_v3\2019_Q1_v3\JAN\HUMIDITY);
%idiot(M:\HEMS Public Data\2019_Q1_v3\2019_Q1_v3\FEB\HUMIDITY);
%idiot(M:\HEMS Public Data\2019_Q1_v3\2019_Q1_v3\MAR\HUMIDITY);
%idiot(M:\HEMS Public Data\2019_Q2_v3\2019_Q2_v3\APR\HUMIDITY);
%idiot(M:\HEMS Public Data\2019_Q2_v3\2019_Q2_v3\MAY\HUMIDITY);
%idiot(M:\HEMS Public Data\2019_Q2_v3\2019_Q2_v3\JUN\HUMIDITY);
%idiot(M:\HEMS Public Data\2019_Q3_v3\2019_Q3_v3\JUL\HUMIDITY);
%idiot(M:\HEMS Public Data\2019_Q3_v3\2019_Q3_v3\AUG\HUMIDITY);
%idiot(M:\HEMS Public Data\2019_Q3_v3\2019_Q3_v3\SEP\HUMIDITY);
%idiot(M:\HEMS Public Data\2019_Q4_v3\2019_Q4_v3\OCT\HUMIDITY);
%idiot(M:\HEMS Public Data\2019_Q4_v3\2019_Q4_v3\NOV\HUMIDITY);
%idiot(M:\HEMS Public Data\2019_Q4_v3\2019_Q4_v3\DEC\HUMIDITY);
%idiot(M:\HEMS Public Data\2020_Q1_v3\2020_Q1_v3\JAN\HUMIDITY);
%idiot(M:\HEMS Public Data\2020_Q1_v3\2020_Q1_v3\FEB\HUMIDITY);
%idiot(M:\HEMS Public Data\2020_Q1_v3\2020_Q1_v3\MAR\HUMIDITY);

  /*************************/
 /***** W E A T H E R *****/
/*************************/

%MACRO IDIOT(V1);
filename folder "&V1\";
/*libname c 'C:\Temp';         /* just an example destination folder */
options validmemname=extend; /* to allow non-standard dataset names */
 
/* Making a list of all files in the folder */
data FilesInFolder;
   length Line 8 File $300;
   List = dopen('folder');  /* corrected the function argument */
   do Line = 1 to dnum(List);
        FileA = trim(dread(List,Line));
        output;
   end;
   drop list line;
run;

DATA FilesInFolder;
SET  FilesInFolder;
FILE=CATT('WEATHER_FIFTEEN',SUBSTR(FILEA,16));/* Creates SAS Friendly File Name */
RUN;
PROC PRINT DATA=FILESINFOLDER;
RUN;
 
/* Creating global macro variables */  /* not "local" */
data _NULL_;
     set FilesInFolder end=final;
	 call symput(cats('FileA', _N_), trim(FileA));  
     call symput(cats('File', _N_), trim(File));     /* used CATS instead of COMPRESS (...||...) */
     call symput(cats('Name', _N_), trim(nliteral(substr(File,1,min(32, length(File)-4))))); /* inserted */
     if final then call symputx(trim('Total'), _N_); /* replaced symput by symputx */
run;

/* This macro should import all files specified in the list and save them as datasets */
%macro loop;
%do i = 1 %to &Total;
  proc import datafile="&V1\&&FileA&i"
       out=&&name&i  /* adapted */
       dbms=csv
       replace;
       getnames=YES; guessingrows=10000;

DATA HEMS_15.WEATHER_FIFTEEN (COMPRESS="YES");
SET HEMS_15.WEATHER_FIFTEEN &&name&i;
  run;

%end;
%mend loop;
 
%loop
 

%mend idiot;
%idiot(M:\HEMS Public Data\2018_Q3_v3\2018_Q3_v3\SEP\WEATHER);
%idiot(M:\HEMS Public Data\2018_Q4_v3\2018_Q4_v3\OCT\WEATHER);
%idiot(M:\HEMS Public Data\2018_Q4_v3\2018_Q4_v3\NOV\WEATHER);
%idiot(M:\HEMS Public Data\2018_Q4_v3\2018_Q4_v3\DEC\WEATHER);
%idiot(M:\HEMS Public Data\2019_Q1_v3\2019_Q1_v3\JAN\WEATHER);
%idiot(M:\HEMS Public Data\2019_Q1_v3\2019_Q1_v3\FEB\WEATHER);
%idiot(M:\HEMS Public Data\2019_Q1_v3\2019_Q1_v3\MAR\WEATHER);
%idiot(M:\HEMS Public Data\2019_Q2_v3\2019_Q2_v3\APR\WEATHER);
%idiot(M:\HEMS Public Data\2019_Q2_v3\2019_Q2_v3\MAY\WEATHER);
%idiot(M:\HEMS Public Data\2019_Q2_v3\2019_Q2_v3\JUN\WEATHER);
%idiot(M:\HEMS Public Data\2019_Q3_v3\2019_Q3_v3\JUL\WEATHER);
%idiot(M:\HEMS Public Data\2019_Q3_v3\2019_Q3_v3\AUG\WEATHER);
%idiot(M:\HEMS Public Data\2019_Q3_v3\2019_Q3_v3\SEP\WEATHER);
%idiot(M:\HEMS Public Data\2019_Q4_v3\2019_Q4_v3\OCT\WEATHER);
%idiot(M:\HEMS Public Data\2019_Q4_v3\2019_Q4_v3\NOV\WEATHER);
%idiot(M:\HEMS Public Data\2019_Q4_v3\2019_Q4_v3\DEC\WEATHER);
%idiot(M:\HEMS Public Data\2020_Q1_v3\2020_Q1_v3\JAN\WEATHER);
%idiot(M:\HEMS Public Data\2020_Q1_v3\2020_Q1_v3\FEB\WEATHER);
%idiot(M:\HEMS Public Data\2020_Q1_v3\2020_Q1_v3\MAR\WEATHER);




