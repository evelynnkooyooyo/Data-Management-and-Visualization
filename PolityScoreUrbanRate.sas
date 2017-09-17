LIBNAME mydata "/courses/d1406ae5ba27fe300 " access=readonly;
DATA new; set mydata.gapminder; 

IF internetuserate <= 25 THEN internetuse= "Lowest"; /*0-25*/
IF internetuserate > 25 AND internetuserate <= 50 THEN internetuse= "Low"; /*25-50*/
IF internetuserate > 50 AND internetuserate <= 75 THEN internetuse= "Average"; /*50-75*/
IF internetuserate > 75 THEN internetuse= "High"; /*75-100*/

IF polityscore >= -10 AND polityscore <= -6 THEN polity= "Autocracy"; /*-10--6*/
ELSE IF polityscore >= -5 AND polityscore <= 5 THEN polity= "Anocracy"; /*-5-5*/
ELSE IF polityscore > 5 THEN polity= "Democracy"; /*6-10*/

IF urbanrate <= 33 THEN urbanpop=3; /*0-33*/
ELSE IF urbanrate > 33 AND urbanrate <= 66 THEN urbanpop=2; /*33-66*/
ELSE IF urbanrate > 66 THEN urbanpop=1; /*66-100*/
RUN;
 
PROC FREQ; TABLES internetuse polity urbanpop;
RUN;

PROC GCHART; VBAR internetuserate/ type=PCT; /*quantitative variable*/
RUN; 

PROC GCHART; VBAR polityscore/ DISCRETE type=PCT width=3; /*quantitative variable*/ 
RUN;

PROC GCHART; VBAR urbanrate/ type=PCT; /*quantitative variable*/
RUN;

PROC GCHART; VBAR internetuse/ DISCRETE TYPE=MEAN SUMVAR=polityscore; 

PROC GCHART; VBAR urbanpop/ DISCRETE TYPE=MEAN SUMVAR=polityscore; 
RUN;
