/* Adapted from InClassExamples/Dec2_InClassExamples.sas
   MA-505 Fall 2025 — PROC SQL on sashelp.cars (the queries that run
   against the built-in cars table). */

PROC SQL;
select Make, Model, Type, Origin, MSRP
    from sashelp.cars;
QUIT;

PROC SQL;
    select Model, Type, Origin, MSRP
    from sashelp.cars
    where MSRP < 25000
    order by MSRP desc;
QUIT;

PROC SQL;
    select Make, Model, Type, Origin,
    (MPG_Highway + MPG_City)/2 as AVG_MPG
    from sashelp.cars;
QUIT;

/* a calculated column reused in a WHERE via CALCULATED, with ordering */
PROC SQL;
    select Make, Model, MSRP, Invoice,
        (MSRP - Invoice) as Markup
    from sashelp.cars
    where calculated Markup > 5000
    order by Markup desc;
QUIT;

/* simple aggregate by group */
PROC SQL;
    select Origin, count(*) as N, mean(MSRP) as AvgMSRP
    from sashelp.cars
    group by Origin;
QUIT;
