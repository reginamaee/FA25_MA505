/* Adapted from InClassExamples/Nov25_InClassExamples.sas
   MA-505 Fall 2025 — hypothesis tests & correlation on the outplanting data.
   The species-comparison t-test, ANOVA, and correlation are the student's
   code; the date filter uses the CSV's "YYYY-MM" Date values. */

ods graphics off;

/* unique values of species and date */
proc freq data=ma505.outplant;
	TABLES Species Date;
run;

/* restrict to the second sampling date */
data second_date;
    set ma505.outplant;
    where Date = "2021-09";
run;

/* normality diagnostics by group */
proc sort data=second_date;
	by Species;
run;

proc univariate data=second_date;
   by Species;
   var Height;
   title 'Height distribution by Species';
run;
title;

/* two-sample t-test comparing two species */
proc ttest data=second_date;
    class Species;
    var Height;
    where Species ~= "Premna serratifolia";
    title 'Two-sample t-test: Ixora vs Pandanus';
run;
title;

/* one-sided alternative ("less") */
proc ttest data=second_date sides=L;
    class Species;
    var Height;
    where Species ~= "Premna serratifolia";
run;

/* one-way ANOVA across all three species */
proc anova data=second_date;
    class Species;
    model Height = Species;
    means Species / tukey;
    title 'One-way ANOVA of Height by Species';
run;
title;

/* correlation summary for Height */
proc corr data=ma505.outplant;
	var Height;
	title 'Correlation summary for Height';
run;
title;
