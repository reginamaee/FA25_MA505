/* print the first 10 observations of the sashelp.cars table */
PROC PRINT data = sashelp.cars (obs=10);
    var Make Model Type MSRP;
RUN;

/* prints summary statistics for EngineSize and Horsepower */
PROC MEANS data=sashelp.cars;
    var EngineSize Horsepower;
RUN;

/* provide descriptive statistics/dist. for MPG_Highway */
PROC UNIVARIATE data=sashelp.cars;
    var MPG_Highway;
RUN;

/* create freq. tables for categorical obs. */
PROC FREQ data=sashelp.cars;
    tables Origin;
RUN;

/* FILTERING WITH PROCEDURES */

/* using AND */
PROC PRINT data = sashelp.cars;
    WHERE TYPE = "SUV" and MSRP <= 30000;
RUN;


/* using IN */
PROC PRINT data = sashelp.cars;
    WHERE TYPE in ("Suv", "Truck");
RUN;

/* find MISSING */
PROC PRINT data = sashelp.cars;
    WHERE TYPE is missing;
RUN;

/* using BETWEEN */
PROC PRINT data = sashelp.cars;
    WHERE MSRP between 36000 and 50000;
run;

/* USING MACRO VARIABLES */

%let CarMake = Kia;

PROC PRINT data=sashelp.cars;
     where Make="&CarMake";
     var Type Make Model MSRP;
RUN;

PROC FREQ data=sashelp.cars;
     where MAKE="&CarMake";
     tables Origin;
RUN;