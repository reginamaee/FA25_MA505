/***********************************/
/* MA505 November 20, 2025: 
/* Data Restructuring & Do Loops
/***********************************/

/***********************************/
/* Using a DATA step to reshape 
   from long/wide to wide/long */
/***********************************/
/* first step is to sort by the ID variables */
proc sort data=ma505.food_surv out=food_surv_sort;
 BY Student Restaurant;
RUN;

data wide_food_survey;
	set food_surv_sort;
	BY Student Restaurant;
	
	retain FoodQuality Service; 
	DROP Category Score;
	
	if Category="Food Quality" then FoodQuality = Score;
	else if Category="Service" then Service = Score;
	
	if last.Restaurant then output;
RUN;

/* wide to long */ 
data long_food_survey;
    set wide_food_survey;

    Category = "Food Quality";
    Score = FoodQuality;
    output;

    Category = "Service";
    Score = Service;
    output;

    drop FoodQuality Service;
run;


/***********************************/
/* using proc transpose */
/***********************************/
/* need to sort first for long to wide */
PROC TRANSPOSE data=food_surv_sort
	out=wide_transpose(drop=_NAME_);
	by Student Restaurant;
	id Category;
	var Score;
RUN;

PROC TRANSPOSE data=wide_food_survey
	out=long_transpose(rename=(_NAME_=Category
                               COL1=Score));
	by Student Restaurant;
	var FoodQuality Service;
RUN;

/***********************************/
/* iterative do-loops
/***********************************/

data frecast;
    set sashelp.shoes(rename=(Sales=ProjectedSales));
    Year=1;
    ProjectedSales = ProjectedSales*1.05;
    output;
    Year=2;
    ProjectedSales = ProjectedSales*1.05;
    output;
    Year=3;
    ProjectedSales = ProjectedSales*1.05;
    output;
    keep Region Product Year ProjectedSales;
run;

proc print data=frecast;
run;

data frecast;
    set sashelp.shoes(rename=(Sales=ProjectedSales));
    do Year = 1 to 3;
        ProjectedSales = ProjectedSales*1.05;
        output;
    end;
    keep Region Product Year ProjectedSales;
run;

/***********************************/
/* conditional do-loops
/***********************************/

data characters;
    input Name $ Amount;
    datalines;
Elphaba 250
Glinda 300
Fiyero 275
Boq 350
;
run;

data savings3k;
    set savings;
    Month = 0;
    Savings = 0;
    do while (Savings <= 3000);
        Month + 1;
        Savings + Amount;
        Savings + (Savings * 0.02/12);
        output;
    end;
    format Savings comma12.2;
run;

proc print data=savings3k;
run;