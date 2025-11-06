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
/***********************************/

/***********************************/
/* Using PROC SGPANEL */

/* scatter of sales and returns by region*/
PROC SGPLOT data=sashelp.shoes;
    scatter x=Sales y=Inventory / group=Region;
    where Sales < 150000;
    title 'Shoe Sales vs Inventory';
RUN;

/* panel by region instead */
PROC SGPANEL data=sashelp.shoes;
    panelby Region / rows=2 columns=5;
    scatter x=Sales y=Inventory / group=Region;
    where Sales < 150000;
RUN;

/* 2 different panels */
PROC SGPANEL data=sashelp.shoes;
    panelby Region Product / layout=lattice rows=8;
    histogram Inventory;
    where Region IN ('Pacific', 'United States');
RUN;


/***********************************/
/* EXPORTING RESULTS */


ods graphics / reset imagename="Inventory_Distribution" imagefmt=png 
    width=800px height=1200px;
ods listing gpath="/home/u63936157/";

title 'Shoe Inventory Distribution in the Pacific and United States';
proc sgpanel data=sashelp.shoes;
    panelby Region Product / layout=lattice rows=8;
    histogram inventory;
    where Region IN ('Pacific', 'United States');
run;

ods listing close;
