/***********************************/
/* MA505 November 18, 2025: 
/* In Class Examples (MORE ABOUT PDV)
/***********************************/


data drop_height;
    set sashelp.class;
    drop Height;   /* Still enters PDV but not the output dataset */
    BMI = (Weight) / (Height)**2 * 703;  
run;

data teenagers;
    set sashelp.class;
    where Age >= 14;   /* Only these rows enter the PDV */
run;

data example;
    set sashelp.class;
    if Age >= 14 then Teenager = 1;  
    Age = Age + 1;              /* This change happens AFTER the IF */
run;

/***********************************/


/* cumulative sum by group */
/* first step is to sort the data by the group */
proc sort data=ma505.food_surv
    out=food_surv_rest_sort;
    BY Restaurant;
RUN;

DATA sum_by_group;
    SET food_surv_rest_sort;
    BY Restaurant;
    retain RestaurantSum 0;
    if First.Restaurant = 1 then RestaurantSum = 0;
    RestaurantSum = SUM(RestaurantSum,Score);
    if Last.Restaurant = 1; /* only outputs the last grouped row */
RUN;

/***********************************/

/* MERGING DATA SETS */ 
proc import datafile="/home/u63936157/merging_data/class_teachers.csv" dbms=csv
	out = teacher;
run;

proc print data=teacher(obs=5);
run;

proc import datafile="/home/u63936157/merging_data/class_1.csv" dbms=csv
	out = class_all;
run;

/* need to sort before merging! */
proc sort data=class_all;
	BY Name Grade;
RUN;

proc sort data=teacher;
	BY Name Grade;
RUN;

/***********************************/