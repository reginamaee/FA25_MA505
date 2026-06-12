/* jenner-check autoexec: cap rows + recreate the MA505 library from the
   class food-survey data (Datasets/class_food_survey*.csv), inlined here
   so the lesson's ma505.food_surv / ma505.food_surv_wide references
   resolve without any external files. */
options obs=100;
libname ma505 ".";

data ma505.food_surv_wide;
    length Student $ 12;
    length Restaurant $ 16;
    infile datalines dsd missover;
    input Student $ Restaurant $ FoodQuality Service;
datalines;
Mark,Kings,7,8
Mark,Jamaican Grill,8,6.5
Mark,Fuji,9,6
Rhonda,Kings,9,9
Rhonda,Jamaican Grill,8,9
Rhonda,Fuji,10,9
Dannika,Kings,7,7
Dannika,Jamaican Grill,7,8
Dannika,Fuji,8,6
Robert,Kings,6,7
Robert,Jamaican Grill,7,7
Robert,Fuji,8,7
Tim,Kings,,
Tim,Jamaican Grill,,
Tim,Fuji,,
;
run;

data ma505.food_surv;
    length Student $ 12;
    length Restaurant $ 16;
    length Category $ 16;
    infile datalines dsd missover;
    input Student $ Restaurant $ Category $ Score;
datalines;
Mark,Kings,Food Quality,7
Mark,Kings,Service,8
Mark,Jamaican Grill,Food Quality,8
Mark,Jamaican Grill,Service,6.5
Mark,Fuji,Food Quality,9
Mark,Fuji,Service,6
Rhonda,Kings,Food Quality,9
Rhonda,Kings,Service,9
Rhonda,Jamaican Grill,Food Quality,8
Rhonda,Jamaican Grill,Service,9
Rhonda,Fuji,Food Quality,10
Rhonda,Fuji,Service,9
Dannika,Kings,Food Quality,7
Dannika,Kings,Service,7
Dannika,Jamaican Grill,Food Quality,7
Dannika,Jamaican Grill,Service,8
Dannika,Fuji,Food Quality,8
Dannika,Fuji,Service,6
Robert,Kings,Food Quality,6
Robert,Kings,Service,7
Robert,Jamaican Grill,Food Quality,7
Robert,Jamaican Grill,Service,7
Robert,Fuji,Food Quality,8
Robert,Fuji,Service,7
Tim,Kings,Food Quality,
Tim,Kings,Service,
Tim,Jamaican Grill,Food Quality,
Tim,Jamaican Grill,Service,
Tim,Fuji,Food Quality,
Tim,Fuji,Service,
;
run;
