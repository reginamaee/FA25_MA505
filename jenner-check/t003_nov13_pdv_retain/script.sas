/* Verbatim from InClassExamples/Nov13_InClassExamples.sas
   MA-505 Fall 2025 — LEARNING ABOUT PDV (Program Data Vector) */

DATA food_survey;
	set ma505.food_surv_wide;
	Score_Sum = FoodQuality + Service;
	Score_avg = MEAN(FoodQuality, Service);
RUN;

DATA food_survey;
	set ma505.food_surv_wide;
	Score_Sum = FoodQuality + Service;
	output;
	Score_avg = MEAN(FoodQuality, Service);
	output;
RUN;

DATA food;
	set ma505.food_surv;
	retain Total 0;
	Total = SUM(Total, Score);
RUN;

/* show the PDV results */
proc print data=food_survey(obs=10); run;
proc print data=food(obs=10); run;
