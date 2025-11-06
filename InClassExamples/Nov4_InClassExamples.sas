/***********************************/
/* MA505 November 4, 2025: 
/* In Class Examples
/***********************************/


/* if-then in a data step */
data cars_new;
    set sashelp.cars;
    length Cost $ 10;
    if MSRP<30000 then Cost = "Okay";
    if MSRP>=30000 then Cost = "Too High";
    keep Make Model Type MSRP Cost;
run;

/* if-then extension */
DATA under40 over40;
    set sashelp.cars;
    keep Make Model MSRP Cost;
    if MSRP < 20000 then do;
        Cost = 1;
        output under40;
    end;
    else if MSRP < 40000 then do;
        Cost = 2;
        output under40;
    end;
    else do;
        Cost = 3;
        output over40;
    end;
RUN;
/***********************************/



/***********************************/
/* USING PROC FREQ TO CREATE PLOTS */

/* creating a horizontal bar frequency plot */
ods graphics on;

PROC FREQ data=sashelp.cars;
	tables Origin / 
		plots=freqplot(orient=horizontal 
        scale=percent);
RUN;

/* creating a vertical bar freq plot */
PROC FREQ data = sashelp.cars;
    tables Origin*Type /
    plots = freqplot(orient=vertical);
RUN;

/* creating a stacked bar */
title1 'Origin of Cars by Type';
title2 'Sedan, SUV, Truck';
footnote 'Other Types not included: Hybrid, Sports, Wagon';
PROC FREQ data = sashelp.cars;
    tables Origin*Type /
        plots = freqplot(twoway=stacked orient=horizontal);
    where Type in ('Sedan', 'SUV', 'Truck');
RUN;
/***********************************/

/***********************************/
/* PROC SGPLOT */

PROC SGPLOT data=ma505.overwatch; 
	hbar Map; 
RUN; 
 
PROC SGPLOT data=ma505.overwatch; 
	hbar Map / response=Damage; 
RUN; 
 
PROC SGPLOT data=ma505.overwatch; 
	hbar Map / response=Damage stat=mean; 
RUN;
