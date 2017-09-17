LIBNAME mydata "/courses/d1406ae5ba27fe300 " access=readonly;
DATA new; set mydata.gapminder; 
LABEL internetuserate="internet user rate"
	  polityscore="polity score"
	  urbanrate="urban rate";
	  
/*subsetting the data to include only Korea, Rep.*/
IF country="Korea, Rep." OR country="Germany" OR country="United States";
	 
PROC SORT; by COUNTRY;  
PROC FREQ; TABLES internetuserate polityscore urbanrate;

RUN;


LIBNAME mydata "/courses/d1406ae5ba27fe300 " access=readonly;
DATA new; set mydata.gapminder; 
LABEL internetuserate="internet user rate"
	  polityscore="polity score"
	  urbanrate="urban rate";
	  
/*subsetting the data to include Korea, Rep., Germany, and United States*/
IF country="Korea, Rep." OR country="Germany" OR country="United States";

PROC FORMAT;
	value internetrange 0-50 = 'Low'
			50-100 		      ='High';
	value urbanrange    0-50  = 'Low'
			50-100 		      ='High';
RUN;
PROC SORT; by COUNTRY;  
PROC FREQ; TABLES internetuserate polityscore urbanrate / NOCUM;
format internetuserate internetrange.
	   urbanrate urbanrange.;

RUN;

LIBNAME mydata "/courses/d1406ae5ba27fe300 " access=readonly;
DATA new; set mydata.gapminder; 
LABEL internetuserate="internet user rate"
	  polityscore="polity score"
	  urbanrate="urban rate";	
	  
/*subsetting the data to include Argentina, Botswana, Denmark, Morocco, 
Bangladesh, Djibouti, Iraq, United States, Belarus, Vietnam, Korea, Rep., and Eritrea */

IF country="Argentina"  OR country="Botswana" OR country="Denmark" OR country='Morocco'
OR country="Bangladesh" OR country="Djibouti" OR country="Iraq" OR country='United States'
OR country="Belarus" OR country="Vietnam" OR country="Eritrea" OR country='Korea, Rep.';

PROC FORMAT;
	value internetrange 0-25  = 'Lowest'
			25-50 		      ='Low'
			50-75			  ='Average'
			75-100			  ='High';
	value urbanrange    0-35  ='Low'
			35-75             ='Average'
			75-95			  ='High';
	value polityrange -10--6  = 'Autocracy'
            -5-5              ='Anocracy'
            6-10		      ='Democracy';
RUN;           

PROC SORT; by COUNTRY;  
PROC FREQ; TABLES internetuserate polityscore urbanrate / NOCUM;
format internetuserate internetrange.
	   urbanrate urbanrange.
	   polityscore polityrange.;
RUN;


LIBNAME mydata "/courses/d1406ae5ba27fe300 " access=readonly;
DATA new; set mydata.gapminder; 
	  
KEEP COUNTRY internetuserate polityscore urbanrate internetuse polity urbanpop ; 
	  
IF country="Argentina"  OR country="Botswana" OR country="Denmark" OR country='Morocco'
OR country="Bangladesh" OR country="Djibouti" OR country="Iraq" OR country='United States'
OR country="Belarus" OR country="Vietnam" OR country="Eritrea" OR country='Korea, Rep.'; 

IF internetuserate <= 25 THEN internetuse= "Lowest"; /*0-25*/
IF internetuserate > 25 AND internetuserate <= 50 THEN internetuse= "Low"; /*25-50*/
IF internetuserate > 50 AND internetuserate <= 75 THEN internetuse= "Average"; /*50-75*/
IF internetuserate > 75 THEN internetuse= "High"; /*75-100*/

IF polityscore >= -10 AND polityscore <= -6 THEN polity= "Autocracy"; /*-10--6*/
ELSE IF polityscore >= -5 AND polityscore <= 5 THEN polity= "Anocracy"; /*-5-5*/
ELSE IF polityscore > 5 THEN polity= "Democracy"; /*6-10*/

IF urbanrate <= 33 THEN urbanpop= "Small"; /*0-33*/
ELSE IF urbanrate > 33 AND urbanrate <= 66 THEN urbanpop= "Average"; /*33-66*/
ELSE IF urbanrate > 66 THEN urbanpop= "Large"; /*66-100*/

RUN;
    
PROC SORT; by COUNTRY;  
PROC FREQ; TABLES internetuse polity urbanpop;
RUN;



LIBNAME mydata "/courses/d1406ae5ba27fe300 " access=readonly;
DATA new; set mydata.gapminder; 

IF internetuserate eq . THEN internetuse=.;
ELSE IF internetuserate LE 9.999 THEN internetuse=1;
ELSE IF internetuserate LE 31.810 THEN internetuse=2;
ELSE IF internetuserate LE 56.532 THEN internetuse=3;
ELSE IF	internetuserate GT 56.532 THEN internetuse=4;

PROC SORT; by COUNTRY;

PROC FREQ; TABLES internetuse polity;

PROC UNIVARIATE; VAR internetuserate polityscore;

PROC GCHART; VBAR internetuse/ DISCRETE TYPE=MEAN SUMVAR=polityscore; 

RUN;

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

PROC GPLOT; PLOT internetuserate*polityscore;
RUN;

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
