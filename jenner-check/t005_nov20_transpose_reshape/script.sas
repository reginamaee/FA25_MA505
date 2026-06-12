/* Adapted from InClassExamples/Nov20_InClassExamples.sas
   MA-505 Fall 2025 — Data Restructuring: long<->wide via DATA step and PROC TRANSPOSE */

/* first step is to sort by the ID variables */
proc sort data=ma505.food_surv out=food_surv_sort;
 BY Student Restaurant;
RUN;

/* long -> wide via DATA step (retain + first./last.) */
data wide_food_survey;
	set food_surv_sort;
	BY Student Restaurant;

	retain FoodQuality Service;
	DROP Category Score;

	if Category="Food Quality" then FoodQuality = Score;
	else if Category="Service" then Service = Score;

	if last.Restaurant then output;
RUN;

proc print data=wide_food_survey;
    title 'Long to Wide (DATA step)';
run;

/* wide -> long via DATA step */
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
/* need to sort first for long to wide */
PROC TRANSPOSE data=food_surv_sort
	out=wide_transpose(drop=_NAME_);
	by Student Restaurant;
	id Category;
	var Score;
RUN;

proc print data=wide_transpose;
    title 'Long to Wide (PROC TRANSPOSE)';
run;

PROC TRANSPOSE data=wide_food_survey
	out=long_transpose(rename=(_NAME_=Category
                               COL1=Score));
	by Student Restaurant;
	var FoodQuality Service;
RUN;

proc print data=long_transpose(obs=10);
    title 'Wide to Long (PROC TRANSPOSE)';
run;
title;
