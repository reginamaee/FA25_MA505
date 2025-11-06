/*******************************/
/* OCT 30 In Class Examples */
/*******************************/


/* defining a numeric macro variable and 
calling it */

%let age_num = 14;

proc print data=sashelp.class;
    where Age = &age_num;
run;

/******************/
/* defining a character macro variable and 
calling it */

%let sex = M;

proc print data=sashelp.class;
    where Sex = "&sex";
run;

/******************/

/* defining a date macro variable and 
calling it */
%let start_date = 01JAN2005;

proc print data=sashelp.stocks(obs=5);
    where date >= "&start_date"d;
run;

/******************/

/* using FORMAT in PROC PRINT */
PROC PRINT data=ma505.overwatch;
    FORMAT Damage COMMA10. Heals COMMA10.;
RUN;

/******************/

/* sorting data using a PROC statement */
PROC SORT data=sashelp.class out=test_sort;
    by DESCENDING age Name;
RUN;

/******************/

/* this code uses the CLASS.csv file in our datasets folder on our moodle page*/
PROC SORT data=ma505.class out = ma505.clean
    nodupkey
    dupout=ma505.duplicates;
by _all_;
RUN;
/******************/

/* creating a NEW table using a DATA step */
DATA cln_class;
    SET ma505.clean;
RUN;

/******************/

/* adding filters in a DATA step */
DATA cln_class;
    SET ma505.clean;
    WHERE age > 14;
RUN;

/******************/

/* Computing new columns in the DATA step */
data cars_new;
    set sashelp.cars;
    where Origin ~= "USA"l 
    Profit = MSRP-Invoice;
    Source = "Non-US Cars"; 
    format Profit dollar10.;
    keep Model Profit Source;
RUN;

/******************/


/* Using functions */
DATA cars_new;
    set sashelp.cars;
    MPG = SUM(MPG_City, MPG_Highway);
    MPGavg = MEAN(MPG_City, MPG_Highway);
    Make = UPCASE(Make);
    Type = UPCASE(Type);
RUN;

PROC PRINT cars_new(obs=10);
RUN;

/******************/