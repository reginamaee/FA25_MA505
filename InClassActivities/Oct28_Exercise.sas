/* MA505 Oct 27, Excercise Solutions */

/* 1. Upload the overwatch_stats.csv into your SAS Studio and store it in your MA505 library. */
LIBNAME MA505 "/home/u6396157";

PROC IMPORT datafile="/home/u6396157/overwatch_stats.csv" dbms="csv"
    out=ma505.overwatch;
RUN;

/* 2. Using this new table, tell me the value with the highest frequency for the columns: Mode, Map, and Role. */
PROC FREQ data = ma505.overwatch;
    tables Mode Map Role;
RUN;

/* 3. Compute summary statistics for all numeric columns using the univariate proc function. 
 What are the 5 highest values for damage? 5 lowest for assists? */
PROC UNIVARIATE data=ma505.overwatch;
    var Damage;
RUN;

/* 4. using ods trace then ods select */
ODS TRACE ON;
PROC UNIVARIATE data=ma505.overwatch;
    var Damage;
RUN;

ODS SELECT ExtremeObs;
PROC UNIVARIATE data=ma505.overwatch;
    var Damage;
RUN;

/* 5 Find Player 1's (in maps: Busan, Nepal, Junkertown, and Oasis)
average elimination and deaths number and the top 5 values for damage */

%let p = player1;
%let maps = "Busan", "Nepal", "Junkertown", "Oasis";

PROC MEANS data=ma505.overwatch;
	var Elimination Deaths;
	where Player = "&p" and Map in (&maps);
RUN;

/* option 2: different macrovariable set-up */
%let p = "player1";
%let maps = ("Busan", "Nepal", "Junkertown", "Oasis");

PROC MEANS data=ma505.overwatch;
	var Elimination Deaths;
	where Player = &p and Map in &maps;
RUN;