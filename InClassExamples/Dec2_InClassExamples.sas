/***********************************/
/* MA505 Dec 2, 2025: 
/* PROC SQL
/***********************************/

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

PROC SQL;
    select * from hw1.Storm_Summary;
QUIT;

PROC SQL;
    select Season, Name, StartDate format=mmddyy10., MaxWindMPH
    from hw1.Storm_Summary;
QUIT;

PROC SQL;
    select Season, propcase(Name) as Name, StartDate format=mmddyy10., MaxWindMPH
    from hw1.Storm_Summary;
QUIT;

title "International Storms since 2000";
title2 "Category 5 (Wind>156)";
PROC SQL;
    select Season, propcase(Name) as Name, StartDate format=mmddyy10., MaxWindMPH
    from hw1.Storm_Summary
    where MaxWindMPH > 156 and Season >= 2000 
    order by MaxWindMPH desc, Name;
QUIT;

/***********************************/
/* joining tables using PROC SQL */
/***********************************/

libname day9 "/home/u63936157/proc_sql/"; 
 
proc import datafile="/home/u63936157/proc_sql/CLASS_UPDATE.csv" 
    out=day9.class_update 
    dbms=csv; 
RUN; 
 
proc import datafile="/home/u63936157/proc_sql/TEACHERS.csv" 
    out=day9.class_teachers 
    dbms=csv; 
RUN; 


PROC SQL;
    select Grade, Age, Teacher
    from day9.class_update inner join day9.class_teachers
    on class_update.Name = class_teachers.Name;
QUIT;

PROC SQL;
    select class_update.Name, Grade, Age, Teacher
    from day9.class_update inner join day9.class_teachers
    on class_update.Name = class_teachers.Name;
QUIT;

PROC SQL;
    select class_update.Name, Grade, Age, Teacher
    from day9.class_update left join day9.class_teachers
    on class_update.Name = class_teachers.Name;
QUIT;

/***********************************/
/* using aliases */
/***********************************/

PROC SQL;
    select u.Name, grade, Age, Teacher
    from day9.class_update as u
        left join day9.class_teachers as t
    on u.Name = t.Name;
QUIT;
