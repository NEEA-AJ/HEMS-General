proc surveyselect data=hems_15.Power_fifteen method=srs n=500
out=hems_15.master_xy seed=549;
run;

proc transpose data=hems_15.master_xy out=hems_15.master_xyz (drop=_name_);
by regname min_t;
var power;
id regname min_t max_t;
run;

proc print data=hems_15.master_xyz; run;
