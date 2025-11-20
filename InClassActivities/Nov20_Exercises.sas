/***********************************/
/* exercise - yearsaving
/***********************************/

data YearSaving;
    Amount = 200;
    retain Savings 0;
    do Month=1 to 12 by 2;
        Savings = Savings + Amount*2;
        output;
    end;
    format Savings 12.2;
run;

proc print data=YearSaving;
run;

/***********************************/
/* exercise2 - SAVINGS2
/***********************************/

/* creates new table called SAVINGS2 
and reads in data directly from the code below the datalines 
section */

data SAVINGS2;
   /* defines a character variable Name with 8 bytes */
   length Name $ 8; 
   /* defines numeric variables Amount and Savings with 8 bytes */
   length Amount 8;
   length Savings 8;

   /* specifies that the data will be read directly from the code */
   /* dsd means comma separated values */
   infile datalines dsd;

   /* species the order the variables to be read in */
   input
      Name
      Amount
      Savings
   ;
datalines;
Elphaba,250,1250
Glinda,300,3600
Fiyero,275,2200
Boq,350,1750
;
run;

data ex2;
    set SAVINGS2;
    Month = 0;
    do until (Savings > 3000);
        Month + 1;
        Savings + Amount;
        Savings + (Savings * 0.02/12);
        format Savings comma12.2;
    end;
run;