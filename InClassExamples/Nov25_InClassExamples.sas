/***********************************/
/* MA505 November 25, 2025: 
/* Some hypothesis tests & correlation
/***********************************/

/************************
* t-test & a bit of data cleaning
************************/

/* create library ma505 in my day10 folder */
libname ma505 "/home/u63936157/day10/";


/* import overwatch csv into ma505 library */
proc import datafile="/home/u63936157/day10/mock_outplanting_data.csv" dbms=csv 
		out=ma505.outplant;
		GUESSINGROWS = 300;
run;

/* find the unique values of species */
proc freq data=ma505.outplant;
	TABLES species date;
run;

/* recode and clean */
data pandanus_clean;
	set ma505.outplant;
	where Species like "Pan%";
	Species = "Pandanus tectorius";
run;

data premna_clean;
	set ma505.outplant;
	where Species like "Pre%";
	Species = "Premna serratifolia";
run;

data ixora_clean;
	set ma505.outplant;
	where Species like "Ix%";
	Species = "Ixora triantha";
run;

data ma505.outplant_clean;
	set pandanus_clean premna_clean ixora_clean;
run;

/************************/
/* running a two-sample t-test
/************************/


/* what we want: run t-test for second date */
data second_date;
    set ma505.outplant_clean;
    where Date = "01SEP21"d;
run;

/* visualize our data */
/* normality diagnostics */
proc sgplot data=second_date;
    /* Create histogram */
    histogram Height / binwidth=2 fillattrs=(color=white);
    
    /* Overlay density plot */
    density Height / type = kernel group=Species transparency=0.4;
run;

proc sort data = second_date;
	by Species;
run;

proc univariate data=second_date;
   by Species;
   /* / normal adds in the normal line */
   qqplot Height / normal(mu=est sigma=est);
run;

title "Box Plot of Height by Species";
proc sgplot data=second_date;
    vbox Height / category=Species fillattrs=(transparency=0.5);
    xaxis label="Species";
    yaxis label="Height (in cm)";
run;
title;

proc ttest data=second_date;
    class Species;
    var Height;
    where Species ~= "Premna serratifolia";
run;
/* alternative is less than */
proc ttest data=second_date sides=L; /* 'L' specifies a one-sided test for "less" */
    class Species;  /* Grouping variable (independent variable) */
    var Height;     /* Dependent variable */
    where Species ~= "Premna serratifolia";
run;

/************************
* running a paired t-test
************************/


proc sort data=premna_clean;
	by id;
run;

proc transpose data=premna_clean out=prem_wide prefix=Date_;
    by id;         /* Keeps each subject's data together */
    id Date;            /* Turns "before" and "after" into column names */
    var Height;          /* Specifies the variable to transpose */
run;

proc print data=prem_wide;
run;

/* do a paired t-test for PREMNA on both dates */
proc ttest data=prem_wide;
    paired Date_01APR20*Date_01SEP21; /* Paired t-test based on the Time variable */
run;


proc print data=premna_clean;
run;

/************************
* ANOVA 
************************/

proc anova data=second_date;
    class Species;                /* Categorical independent variable */
    model Height = Species;       /* Dependent = Independent */
    means Species / tukey;        /* Optional: Post-hoc test (Tukey) */
run;


/************************
* correlation 
************************/

proc print data = sashelp.heart (obs = 10);
run;

proc contents data = sashelp.heart;
run;

/* want to see relationship between weight & cholesterol*/
proc sgplot data=sashelp.heart;
	scatter x=Weight y=Cholesterol;
run;

proc corr data=sashelp.heart;
	var Weight Cholesterol;
run;

proc corr data=sashelp.heart;
	var Weight Cholesterol;
	with Height;
run;

/* want to see relationship between weight & cholesterol BY SEX*/
proc sgpanel data=sashelp.heart;
	panelby Sex;
	scatter x=Weight y=Cholesterol;
run;
	
proc sort data=sashelp.heart out=heart_sort;
	by Sex;
run;

proc corr data=heart_sort;
	var Weight Cholesterol;
	by Sex;
run;

/************************
* chi-square 
************************/

proc print data = sashelp.cars (obs=10);
run;

proc freq data = sashelp.cars;
	tables Origin*Type / chisq expected;
run;

proc freq data = sashelp.cars;
	tables Origin*Type / chisq expected 
	plots=freqplot(twoway=grouphorizontal);
	where Type ~="Hybrid";
run;

proc freq data = sashelp.cars (obs=50);
	tables Origin*Type / fisher;
run;


/*exercise 1).
Use the SASHELP.CARS dataset to test if the car's DriveTrain 
(e.g., All-wheel, Front-wheel) is associated with its Type.
*/

proc freq data = sashelp.cars;
	tables DriveTrain*Type / chisq expected;
run;

/* 
Question: Do cars with different drivetrains 
(All-Wheel Drive vs. Front-Wheel Drive) differ in their Horsepower? */

proc sgplot data=sashelp.cars (obs = 20);
	histogram Horsepower;
	density Horsepower / group = DriveTrain;
	where DriveTrain in ('All', 'Front');
run;

proc npar1way data=sashelp.cars (obs =20) wilcoxon;
	class DriveTrain;
	var Horsepower;
run;

/************************
* converting char -> num & num -> char 
************************/


data class_char;
    set sashelp.class;
    /* put() converts a numeric to character */
    AgeChar = put(Age, 8.);
run;

data class_num;
    set class_char;
    /* input() converts a CHARACTER to NUMERIC */
    AgeNum = input(AgeChar, 8.);
run;

proc print data=class_num(obs=5); 
run;






