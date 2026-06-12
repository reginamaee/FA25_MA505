/* Adapted from InClassExamples/Nov18_InClassExamples.sas
   MA-505 Fall 2025 — MORE ABOUT PDV: first./last. by-group cumulative sum,
   plus the merge-prep import/sort section.
   The two PROC IMPORTs of /home/u63936157/merging_data/*.csv are replaced with
   inline copies of the bundled class_teachers.csv / class_1.csv. */

/* PDV demonstrations on sashelp.class */
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

proc print data=sum_by_group;
    title 'Cumulative Score by Restaurant (last row per group)';
run;
title;

/***********************************/
/* MERGING DATA SETS: build the inputs, then sort (prep for a merge) */

data teacher;
    length Name $ 20;
    length Grade $ 12;
    length Teacher $ 16;
    infile datalines dsd missover;
    input Name $ Grade $ Teacher $;
datalines;
Alex Smith,Junior,Ms. Foster
Jordan Brown,Freshman,Dr. Davis
Taylor Williams,Senior,Mr. Evans
Morgan Johnson,Junior,Ms. Clarke
Jamie Davis,Freshman,Mrs. Anderson
Drew Wilson,Sophomore,Mr. Lewis
Casey Taylor,Sophomore,Mrs. Hall
Skyler Martin,Junior,Dr. Garcia
Dakota Moore,Freshman,Mr. Brown
Avery Thompson,Senior,Ms. Foster
Peyton Smith,Sophomore,Mrs. Anderson
Skyler Brown,Junior,Mr. Lewis
Dakota Miller,Freshman,Ms. Clarke
Jordan Taylor,Senior,Mr. Evans
Avery Wilson,Junior,Ms. Foster
Jamie Anderson,Sophomore,Dr. Davis
Cameron Davis,Sophomore,Mr. Brown
Morgan Thompson,Freshman,Ms. Clarke
Jesse Moore,Senior,Mrs. Hall
Bailey White,Sophomore,Dr. Garcia
Logan Harris,Junior,Mrs. Anderson
Alexis Jones,Freshman,Mr. Lewis
Sydney Hall,Senior,Dr. Davis
Rowan Phillips,Sophomore,Ms. Clarke
Drew Hill,Junior,Mr. Brown
Kendall King,Senior,Dr. Garcia
Charlie Martin,Freshman,Mrs. Anderson
Mackenzie Walker,Sophomore,Mr. Evans
Sam Young,Junior,Ms. Foster
Cory Baker,Freshman,Mrs. Hall
Lane Mitchell,Freshman,Dr. Garcia
Reagan Carter,Senior,Ms. Clarke
Robin Garcia,Junior,Mrs. Anderson
Finley Scott,Sophomore,Mr. Brown
Quinn Thomas,Junior,Dr. Davis
Casey Green,Senior,Mr. Lewis
Shawn Lee,Freshman,Mrs. Hall
Blake Robinson,Sophomore,Ms. Foster
Harper Wright,Junior,Dr. Garcia
Shannon Taylor,Senior,Mr. Evans
Carter Davis,Sophomore,Ms. Clarke
;
run;

proc print data=teacher(obs=5);
run;

data class_all;
    length Name $ 20;
    length Grade $ 12;
    infile datalines dsd missover;
    input Name $ Age Weight Height Grade $ GPA;
datalines;
Alex Smith,20,145.6,5.8,Junior,3.27
Jordan Brown,19,134.2,5.7,Freshman,2.89
Taylor Williams,21,180.3,6.1,Senior,3.61
Morgan Johnson,22,155.4,5.9,Junior,3.01
Jamie Davis,18,120.5,5.5,Freshman,2.75
Drew Wilson,20,165.9,6,Sophomore,3.45
Casey Taylor,19,140.7,5.6,Sophomore,2.96
Skyler Martin,21,175.4,6.2,Junior,3.22
Dakota Moore,18,158.8,5.9,Freshman,3.1
Avery Thompson,20,147.3,5.7,Senior,3.5
;
run;


/* need to sort before merging! */
proc sort data=class_all;
	BY Name Grade;
RUN;

proc sort data=teacher;
	BY Name Grade;
RUN;

proc print data=class_all(obs=5);
run;
