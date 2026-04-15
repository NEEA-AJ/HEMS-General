proc contents data=hems_15.Power_fifteen_raw;
	run;
proc contents data=hems.Power_fifteen;
	run;
proc freq data=hems_15.Power_fifteen_raw;
	tables regname;
run;
proc import datafile="M:\HEMS Public Data\regname index.csv"
        out=HEMS_15.REGNAME_IDX
        dbms=csv
        replace;
    

     getnames=yes;
run;

proc print data=work.shoes;
run;


PROC SURVEYSELECT data=hems_15.Power_fifteen_raw method=srs n=1000
                  seed=1953 out=SQL_TEST ;

run;

/*
apparent_power
ee_site_id
max_t
min_t
n
pf
power
regname
REG_IDX

from L.smokers as s left join L.drinkers as d
on s.id=d.id;
*/
PROC SQL THREADS;
CREATE TABLE IDX AS 
SELECT a.apparent_power AS apparent_power,
a.ee_site_id AS ee_site_id,
month(datepart(a.max_t)) as MONTH,
DAY(datepart(a.max_t)) as DAY,
HOUR(TIMEPART(a.max_t)) AS HOUR,
MINUTE(TIMEPART(a.max_t)) AS MINUTE,
a.max_t AS max_t,
a.min_t AS min_t,
a.n AS n,
a.pf AS pf,
a.power AS power,
b.REG_IDX AS REG_IDX
FROM (SQL_TEST AS a LEFT JOIN HEMS_15.Regname_idx AS b 
	ON a.regname = b.regname) 
GROUP BY  a.min_t
;
QUIT;

proc print data=IDX(OBS=100); RUN;

PROC SQL THREADS;
CREATE TABLE HEMS_15.ANNUAL AS 
SELECT a.apparent_power AS apparent_power,
MAX(YEAR(datepart(a.max_t))) as YEAR,
MAX(month(datepart(a.max_t))) as MONTH,
MAX(DAY(datepart(a.max_t))) as DAY,
MAX(HOUR(TIMEPART(a.max_t))) AS HOUR,
MAX(MINUTE(TIMEPART(a.max_t))) AS MINUTE,
MAX(a.max_t) AS max_t FORMAT=DATETIME.,
MAX(a.min_t) AS min_t FORMAT=DATETIME.,
MEAN(a.n) AS n,
/*MEAN(a.pf) AS pf,*/
MEAN(a.power) AS power,
MAX(b.REG_IDX) AS REG_IDX,
COUNT(a.min_t) AS OBS
FROM (hems.Power_fifteen AS a LEFT JOIN HEMS_15.Regname_idx AS b 
	ON a.regname = b.regname) 
GROUP BY  a.min_t, B.REG_IDX
;
QUIT;

proc print data=HEMS_15.ANNUAL(OBS=100); RUN;
