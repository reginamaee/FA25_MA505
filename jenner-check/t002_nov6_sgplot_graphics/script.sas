/* Adapted from InClassExamples/Nov6_InClassExamples.sas and
   InClassExamples/Nov25_InClassExamples.sas
   MA-505 Fall 2025 — PROC SGPLOT / SGPANEL graphics
   (the lesson's SGPLOT/SGPANEL techniques shown on sashelp.class and sashelp.heart) */

ods graphics on;

/* scatterplot with grouping (Nov6) */
PROC SGPLOT data=sashelp.class;
    scatter x=height y=weight /
        group=Age markerattrs=(symbol=circlefilled);
    title 'Height vs Weight by Age';
RUN;

/* layering a histogram with density overlays (Nov6) */
PROC SGPLOT data=sashelp.class;
    histogram Height;
    density Height;
    density Height / type=kernel;
    title 'Distribution of Height';
RUN;

/* changing color of histogram and density lines (Nov6) */
PROC SGPLOT data=sashelp.class;
    histogram Weight / fillattrs=(color="yellow" transparency=0.5);
    density Weight / lineattrs=(color="green");
    density Weight / type=kernel lineattrs=(color="pink");
    title 'Distribution of Weight';
RUN;

/* relationship between Weight & Cholesterol (Nov25) */
PROC SGPLOT data=sashelp.heart;
    scatter x=Weight y=Cholesterol;
    title 'Weight vs Cholesterol';
RUN;

/* panel the same relationship by Sex (Nov25) */
PROC SGPANEL data=sashelp.heart;
    panelby Sex;
    scatter x=Weight y=Cholesterol;
RUN;

/* box plot of a measure by category (Nov25 style) */
title 'Box Plot of Cholesterol by Sex';
PROC SGPLOT data=sashelp.heart;
    vbox Cholesterol / category=Sex fillattrs=(transparency=0.5);
    xaxis label="Sex";
    yaxis label="Cholesterol";
RUN;
title;
