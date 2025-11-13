/***********************************/
/* MA505 November 13, 2025: 
/* In Class Examples (LEARNING ABOUT PDV)
/***********************************/



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