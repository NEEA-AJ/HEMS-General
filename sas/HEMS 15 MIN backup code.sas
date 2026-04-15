%let path=M:\HEMS Public Data\2018_Q3_v3\2018_Q3_v3\Sep\power;
/*%let FOLDER=power;*/

filename folder "&path\";
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
