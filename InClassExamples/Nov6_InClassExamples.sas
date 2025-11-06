/***********************************/
/* MA505 November 6, 2025: 
/* In Class Examples
/***********************************/


/***********************************/
/* Comparing hbar vs hbarparm */
PROC SGPLOT data=ma505.overwatch;
	hbar Date / response = Damage;
	xaxis min=0 max=200000;
RUN;

PROC SGPLOT data=ma505.overwatch;
	hbarparm category = Date response=Damage;
	xaxis min=0 max=200000;
RUN;

/* using proc means to sum by group */
proc means data=ma505.overwatch;
    class Date;
    var Damage;
    output out=ow_sum sum=Total_Damage;
run;

proc print data=ow_sum;
run;

/***********************************/
/* time series graph */
PROC SGPLOT data=sashelp.pricedata;
    series x=date y=price /
        group = ProductName markers;
    where ProductName IN ('Product1', 'Product2', 'Product3');
RUN;

/* scatterplot */
PROC SGPLOT data=sashelp.class;
    scatter x=height y=weight /
        group=Age markerattrs=(symbol=circlefilled);
RUN;

/* combining a series and scatter */
PROC SGPLOT data=sashelp.pricedata;
    series x=date y=price / group = ProductName markers;
    where ProductName IN ('Product1', 'Product2', 'Product3');
    scatter x=date y=price / group= ProductName;
RUN;
/***********************************/

/***********************************/
/* layering histograms */

PROC SGPLOT data=sashelp.pricedata;
    histogram price;
RUN;

PROC SGPLOT data=sashelp.pricedata;
    histogram price;
    density price;
RUN;

PROC SGPLOT data=sashelp.pricedata;
    histogram price;
    density price;
    density price / type=kernel;
RUN;
/***********************************/

/***********************************/
/* adding additional customizations */

/* changing color of histogram and density lines */
PROC SGPLOT data=sashelp.pricedata;
    histogram price / fillattrs=(color="yellow" transparency=0.95);
    density price / lineattrs=(color="green");
    density price / type=kernel lineattrs=(color="pink");
    title 'Distribution of Price Data for All Products';
RUN;
