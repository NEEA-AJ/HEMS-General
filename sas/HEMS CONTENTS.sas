DATA HEMS_W.POWER (COMPRESS="YES");
SET HEMS.POWER;
RUN;
DATA HEMS_W.THD (COMPRESS="YES");
SET HEMS.THD;
RUN;
ODS OUTPUT variables=allvarout;

proc contents data=hems._all_ memtype=data;
run;

proc sort data=allvarout;
by member num;
run;
ODS TAGSETS.EXCELXP FILE="C:\Users\ajames\OneDrive - NEEA\Current Projects\#2020 Projects\#2020-06152020 HEMS\HEMS RAW table contents.xls"
STYLE=minimal options( sheet_name='member' sheet_interval = 'page' contents = 'yes' contents_workbook='yes' embedded_titles = 'yes' autofit_height='yes' ABSOLUTE_COLUMN_WIDTH='24' PAGES_FITHEIGHT='2') ;
;

proc print data=allvarout noobs;
by member;
pageby member;
title "Variables in #BYVAL(member) data set";
run;
ods tagsets.EXCELXP close;
