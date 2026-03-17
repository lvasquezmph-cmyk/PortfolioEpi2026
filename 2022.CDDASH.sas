libname ooe odbc dsn='ooe_SNHD' schema = 'ooe';

proc contents data=ooe.brfss_nv2011; run;
proc contents data=ooe.brfss_nv2012; run;
proc contents data=ooe.brfss_nv2013; run;
proc contents data=ooe.brfss_nv2014; run;
proc contents data=ooe.brfss_nv2015; run;
proc contents data=ooe.brfss_nv2016; run;
proc contents data=ooe.brfss_nv2017; run;
proc contents data=ooe.brfss_nv2018; run;
proc contents data=ooe.brfss_nv2019; run;
proc contents data=ooe.brfss_nv2020; run;
proc contents data=ooe.brfss_nv2021; run;
proc contents data=ooe.brfss_nv2022; run;
/*formatting for output. HSN chronic disease  dashboard*/
proc format; 
	value agegrp
			low-17='<18'
			18-24 ='18-24'
			25-34 ='25-34'
			35-44 ='35-44'
			45-54 ='45-54'
			55-64 ='55-64'
		   65-high='>=65';
	value sexvar
			1='Male'
			2='Female';
	value sex
			1='Male'
			2='Female';
	value sex1
			1='Male'
			2='Female';
	value _racegr4_
			1='White only, Non-Hispanic'
		  	2='Black only, Non-Hispanic'
			3='Other race only, Non-Hispanic'
			4='Multiracial, Non-Hispanic'
			5='Hispanic'
			9='Do not know/Not sure/Refused';
	value _race
			1='White only, Non-Hispanic'
		  	2='Black only, Non-Hispanic'
			3='American Indian or Alaskan Native only, Non-Hispanic'
			4='Asian only, Non-Hispanic'
			5='Native Hawaiian or other Pacific Islander only, Non-Hispanic'
			6='Other race only, Non-Hispanic'
			7='Multiracial, Non-Hispanic'
			8='Hispanic'
			9='Do not know/Not sure/Refused';

/*Would you say that in general your health is:*/
	value GENHLTH
		  1='Excellent'
		  2='Very good'
		  3='Good'
		  4='Fair'
		  5='Poor'
		  7='Do not know/Not sure'
		  9='Refused'
		  .='Not asked or missing';
	value _RFHLTH
		  1='Good or better health'
		  2='Fair or poor health'
		  9='Do not know/Not sure or refused/Missing';
/*(Respondents aged 18-64 years) Do you have any kind of health care coverage, 
  including health insurance, prepaid plans such as HMOs, 
  government plans such as Medicare, or Indian Health Service?*/
	value HLTHPLN1_
		  1='Yes'
		  2='No'
		  7='Do not know/Not sure'
		  9='Refused'
		  .='Not asked or missing';
	value _HCVU651_
		  1='Have health care coverage'
		  2='Do not have health care coverage'
		  9='Do not know/Not sure/Refused/Missing';
/*Do you have one person you think of as your personal doctor or health care provider?*/
	value PERSDOC2_
		  1='Yes, only one'
		  2='More than one'
		  3='No'
		  7='Do not know/Not sure'
		  9='Refused'
		  .='Not asked or missing';
/*Was there a time in the past 12 months when you needed to see a doctor but could
  not because of cost? */
	value MEDCOST
		  1='Yes'
		  2='No'
		  7='Do not know/Not sure'
		  9='Refused'
		  .='Not asked or missing';
/*About how long has it been since you last visited a doctor for a routine checkup?*/
	value CHECKUP1_
		  1='Within past year (anytime less than 12 months ago)'
		  2='Within past 2 years (1 year but less than 2 years ago)'
		  3='within past 5 years (2 years but less than 5 years ago)'
		  4='5 or more years ago'
		  7='Do not know/Not sure'
		  8='Never'
		  9='Refused'
		  .='Not asked or missing';
/*(Ever told) you had a heart attack, also called a myocardial infarction?*/
	value CVDINFR4_
		  1='Yes'
		  2='No'
		  7='Do not know/Not sure'
		  9='Refused'
		  .='Not asked or missing';
/*(Ever told) you had a stroke? */
	value CVDSTRK3_
		  1='Yes'
		  2='No'
		  7='Do not know/Not sure'
		  9='Refused'
		  .='Not asked or missing';
/*Adults who have been told they have high blood pressure by a doctor, nurse, 
  or other health professional */
	value _RFHYPE5_
		  1='No'
		  2='Yes'
		  9='Do not know/Not sure/Refused/Missing';
/*Are you currently taking medicine for your high blood pressure? */
	value BPMEDS
		  1='Yes'
		  2='No'
		  7='Do not know/Not sure'
		  9='Refused'
		  .='Not asked or missing';
/*(Ever told) you have chronic obstructive pulmonary disease,C.O.P.D., emphysema or
chronic bronchitis?*/
	value CHCCOPD1_
		  1='Yes'
		  2='No'
		  7='Do not know/Not sure'
		  9='Refused'
		  .='Not asked or missing';
/*(Ever told) you have diabetes? */
	value DIABETE3_
		  1='Yes'
		  2='Yes, but female told only during pregnancy'
		  3='No'
		  4='No, pre-diabetes or borderline diabetes'
		  7='Do not know/Not sure'
		  9='Refused'
		  .='Not asked or missing';
/*(Ever told) you had skin cancer? */
	value CHCSCNCR
		  1='Yes'
		  2='No'
		  7='Do not know/Not sure'
		  9='Refused'
		  .='Not asked or missing';
/*(Ever told) you had any other types of cancer? */
	value CHCOCNCR
		  1='Yes'
		  2='No'
		  7='Do not know/Not sure'
		  9='Refused'
		  .='Not asked or missing';
/*Respondents aged 50-75 who have fully met the USPSTF recommendation */
	value _CRCREC
		  1='Received one or more of the recommended CRC tests within the recommended time interval'
		  2='Did not receive one or more of the recommended CRC tests within the recommended time interval'
		  .='Missing or age less than 50 or age greater than 75';
/*How long has it been since you had your last Pap test?*/
	value LASTPAP2_
		  1='Within the past year (anytime less than 12 months ago)'
		  2='Within the past 2 years (1 year but less than 2 years ago)'
		  3='Within the past 3 years (2 years but less than 3 years ago)'
		  4='Within the past 5 years (3 years but less than 5 years ago)'
		  5='5 or more years ago'
		  7='Do not know/Not sure'
		  9='Refused'
		  .='Not asked or Missing';
	value LASTPAP2R
		  1='Received a Pap test within the past 3 years'
		  2='Received a Pap test within the past 3 years'
		  3='Received a Pap test within the past 3 years'
		  4='Did not receive a Pap test within the past 3 years'
		  5='Did not receive a Pap test within the past 3 years'
		  7='Do not know/Not sure'
		  9='Refused'
		  .='Not asked or Missing';
/*Women respondents aged 21-65 who have had a pap test in the past three years */
	value _RFPAP33_
		  1='Received a Pap test within the past 3 years'
		  2='Did not receive a Pap test within the past 3 years'
		  .='Missing or male or age less than 21 or age greater than 65';
/*(Ever told) you have kidney disease? Do not include kidney stones, bladder infection 
  or incontinence */
	value CHCKIDNY
 		  1='Yes'
		  2='No'
		  7='Do not know/Not sure'
		  9='Refused'
		  .='Not asked or missing';
/*Adults who are current smokers */
	value _RFSMOK3_
		  1='No'
		  2='Yes'
		  9='Do not know/Refused/Missing';
/*Four-categories of Body Mass Index*/
	value _BMI5CAT
		  1='Underweight'
		  2='Normal weight'
		  3='Overweight'
		  4='Obese'
		  .='Do not know/Refused/Missing';
/*Adults who have a body mass index greater than 25.00 (overweight or obese) */
	value _RFBMI5_
		  1='No'
		  2='Yes'
		  9='Do not know/Refused/Missing';
/*(Ever told) you that you have a depressive disorder, including depression, 
   major depression, dysthymia, or minor depression? */
	value ADDEPEV2_
		  1='Yes'
		  2='No'
		  7='Do not know/Not sure'
		  9='Refused'
		  .='Not asked or missing';
/*Now thinking about your mental health, 
  which includes stress, depression, and problems with emotions, 
  for how many days during the past 30 days was your mental health not good? */
	value MENTHLTH
		  low-13='less than 14 days'
		  14-30='14 or more days'
		  88='None'
		  77='Do not know/Not sure'
		  99='Refused'
		  .='Not asked or missing';
	value _MENT14D
		  1='Zero days when mental health not good'
		  2='1-13 days when mental health not good'
		  3='14+ days when mental health not good'
		  9='Do not know/Refused/Missing';
/*How long has it been since you last visited a dentist or a dental clinic for 
  any reason? Include visits to deantl specialists, such as orthodontists. */
	value LASTDEN3_
		  1='Within the past year (anytime less than 12 months ago)'
		  2='Within the past 2 years (1 year but less than 2 years ago)'
		  3='Within the past 5 years (2 years but less than 5 years ago)'
		  4='5 or more years ago'
		  7='Do not know/Not sure'
		  8='Never'
		  9='Refused'
		  .='Missing';
	value _DENVST2_ /*Adults who have visited a dentist, dental hygenist or dental clinic
					 within the past year */
	      1='Yes'
		  2='No'
		  9='Do not know/Not sure or refused/Missing';
/*During the last 12 months, was there a time when you were not able to pay your 
  mortgage, rent or utility bills?*/
	value SDHBILLS
		  1='Yes'
		  2='No'
		  7='Do not know/Not sure'
		  9='Refused'
		  .='Not asked or missing';
/* Please tell me whether the statement was often true, sometimes true, or
never true for you in the last 12 months:
   I couldn't afford to eat balanced meals */
	value SDHMEALS
		  1='Often true'
		  2='Sometimes true'
		  3='Never true'
		  7='Do not know/Not sure'
		  9='Refused'
		  .='Not asked or missing';
	value SDHMEALSR
		  1='Often or sometimes true'
		  2='Often or sometimes true'
		  3='Never true'
		  7='Do not know/Not sure'
		  9='Refused'
		  .='Not asked or missing';
/*How difficult is it for you to get advice or information about health or medical 
  topics if you need it? */
	value MEDADVIC
		  1='Very easy'
		  2='Somewhat easy'
		  3='Somewhat difficult'
		  4='Very difficult'
		  5='I do not look for health information'
		  7='Do not know/Not sure'
		  9='Refused'
		  .='Not asked or missing';
	value MEDADVICR
		  1='Very or somewhat easy'
		  2='Very or somewhat easy'
		  3='Very or somewhat difficult'
		  4='Very or somewhat difficult'
		  5='I do not look for health information'
		  7='Do not know/Not sure'
		  9='Refused'
		  .='Not asked or missing';
/*How difficult is it for you to understand information that doctors, nurses, 
  and other health professionals tell you? */
	value UNDRSTND
		  1='Very easy'
		  2='Somewhat easy'
		  3='Somewhat difficult'
		  4='Very difficult'
		  7='Do not know/Not sure'
		  9='Refused'
		  .='Not asked or missing';
	value UNDRSTNDR
		  1='Very or somewhat easy'
		  2='Very or somewhat easy'
		  3='Very or somewhat difficult'
		  4='Very or somewhat difficult'
		  7='Do not know/Not sure'
		  9='Refused'
		  .='Not asked or missing';
/*You can find written information about health on the internet, in newspaper and
  magazines, and in brochure in the doctor's office and clinic. In general, how 
  difficult is it for you to understand written health information? */
	value WRITTEN
		  1='Very easy'
		  2='Somewhat easy'
		  3='Somewhat difficult'
		  4='Very difficult'
		  5='I do not pay attention to written health information'
		  7='Do not know/Not sure'
		  9='Refused'
		  .='Not asked or missing';
	value WRITTENR
		  1='Very or somewhat easy'
		  2='Very or somewhat easy'
		  3='Very or somewhat difficult'
		  4='Very or somewhat difficult'
		  5='I do not pay attention to written health information'
		  7='Do not know/Not sure'
		  9='Refused'
		  .='Not asked or missing';

/*Sexual orientation and gender identity*/
	value SXORIENT
		  1='Straight'
		  2='Lesbian or gay'
		  3='Bisexual'
		  4='Other'
		  7='Do not know/Not sure'
		  9='Refused'
		  .='Not asked or missing';
	value TRNSGNDR
		  1='Yes, transgender, male-to-female'
		  2='Yes, transgender, female-to-male'
		  3='Yes, transgender, gender nonconforming'
		  4='No'
		  7='Do not know/Not sure'
		  9='Refused'
		  .='Not asked or missing';
/* Fruit Consumption*/
	Value _FRTLT1A 

		1= 'Consumed fruit one or more times per day' 
		2= 'Consumed fruit < one time per day' 
		9= 'Don�t know, refused or missing values'; 
/* Veggie Consumption*/
	Value _VEGLT1A 
		1= 'Consumed vegetables one or more times per day' 
		2= 'Consumed vegetables < one time per day' 
		9= 'Don�t know, refused or missing values'  ;

		/* four categories of BMI*/
	value _BMI5CAT
		1= 'Underweight' 
		2= 'Normal Weight' 
		3= 'Overweight' 
		4= 'Obese'
		9= 'Don�t know, refused or missing values';

/*ever been told by a doctor or other health professional that you have pre-diabetes or borderline 
diabetes*/
	Value PREDIAB2_
		1= 'Yes'
		2='Yes, During pregnancy'
		3= 'No'
		7= 'Don�t know not sure'
		9= 'Refused';
/*Ever taken diabetes management class*/
		value DIABEDU
			1='Yes'
		  	2='No'
		 	7='Do not know/Not sure'
		 	9='Refused'
		  	.='Not asked or missing';

/*Times in last year where individual saw a health professional for diabetes*/
		value DOCTDIAB
		1-76= 'number of times'
		88= 'None'
		77= 'Dont know/not sure'
		99= 'refused'
		.= 'Not asked/Missing';
/*Times a Health Professional checked A1C*/
		value CHKHEMO3_
		1-76= 'number of times'
		88= 'None'
		77= 'Dont know/not sure'
		99= 'refused'
		.= 'Not asked/Missing';
/* Currently taking perscribed cholesterol medication*/
		value CHOLMED3_
		1='yes'
		2='no'
		7='Dont know/ not sure'
		9='refused'
		.='missing';
		/* Currently taking perscribed cholesterol medication 2019*/
		value CHOLMED2_
		1='yes'
		2='no'
		7='Dont know/ not sure'
		9='refused'
		.='missing';
		/* Currently taking perscribed cholesterol medication 2017*/
		value CHOLMED1_
		1='yes'
		2='no'
		7='Dont know/ not sure'
		9='refused'
		.='missing';
/* Ever told had a heart attack*/
		value CVDINFR4_
		1='yes'
		2='no'
		7='Dont know/ not sure'
		9='refused'
		.='missing';
/* Currently use tobacco */
		value USENOW3_
		1='Every Day'
		2= 'Some Days'
		3= 'Not at all'
		7= 'DOnt know/ Not sure'
		9= 'Refused' 
		.= 'Missing';
/*During the last year, tried to quit*/
		value STOPSMK2_
		1='yes'
		2='no'
		7='Dont know/ not sure'
		9='refused'
		.='missing';
/* Current ECig Users*/ 
		value _CURECI1_ 
		1= ' Not currently using'
		2= 'Current User'
		9= ' Dont know/refused/missing';
/* Current Smokers */ 
		value _RFSMOK3_ 
		1= 'No'
		2= 'Yes'
		9= ' Dont know/refused/missing';
/*Sedentary adults*/ 
		value _TOTINDA
		1= "Had PA"
		2= "No PA"
		9="Don't Know/Refused/Missing";
/*Electronic cig*/
value ECIGNOW
		1='Every Day'
		2= 'Some Days'
		3= 'Not at all'
		7= 'DOnt know/ Not sure'
		9= 'Refused' 
		.= 'Missing';
		/*Electronic cig*/
value ECIGNOW2_
		1='never'
		2= 'every day'
		3= 'some days'
		7= 'Not at all'
		9= 'Dont know' 
		9='refused'
		.= 'Missing';

Value DIABEDU1_
		1-6= "within the last 10 years"
		7= 'Dont know'
		8='never'
		9= 'refused'
		.='missing'

run;


/* Change BRFSS Year */
data CDDB;
	set ooe.Brfss_nv2022;
	run;
	/* By Clark County*/
proc surveyfreq data=CDDB;
	      STRATUM _ststr;
          CLUSTER _psu;
          WEIGHT _llcpwt; 
		  Tables _FRTLT1A _region sex/ row cl;
		  where _region=1  /* Clark County */ and _FRTLT1A=2; 
		  format _FRTLT1A _FRTLT1A. sex sex.;
run;

proc surveyfreq data=CDDB;
	      STRATUM _ststr;
          CLUSTER _psu;
          WEIGHT _llcpwt; 
		  Tables _VEGLT1A sex/ row cl;
		  where _region=1 /* Clark County */ and _VEGLT1A=2; 
		  format _VEGLT1A _VEGLT1A. sex sex.;
run;
proc surveyfreq data=CDDB;

	      STRATUM _ststr;
          CLUSTER _psu;
          WEIGHT _llcpwt; 
		  Tables _BMI5CAT sex/ row cl;
		  where _region=1 /* Clark County */ and _BMI5CAT=3; 
		  format _BMI5CAT _BMI5CAT. sex sex.;
run;
proc surveyfreq data=CDDB;
	      STRATUM _ststr;
          CLUSTER _psu;
          WEIGHT _llcpwt; 
		  Tables PREDIAB1 sex/ row cl;
		  where _region=1 /* Clark County */ and PREDIAB1=1; 
		  format PREDIAB1_ PREDIAB1_. sex sex.;
run;

proc surveyfreq data=CDDB;
	      STRATUM _ststr;
          CLUSTER _psu;
          WEIGHT _llcpwt; 
		  Tables DIABEDU sex/ row cl;
		  where _region=1 /* Clark County */ and DIABEDU=1; 
		  format DIABEDU DIABEDU. sex sex.;
run;

proc surveyfreq data=CDDB;
	      STRATUM _ststr;
          CLUSTER _psu;
          WEIGHT _llcpwt; 
		  Tables DOCTDIAB sex/ row cl;
		  where _region=1 /* Clark County */ and DOCTDIAB^=1; 
		  format DOCTDIAB DOCTDIAB. sex sex.;
run;

proc surveyfreq data=CDDB;
	      STRATUM _ststr;
          CLUSTER _psu;
          WEIGHT _llcpwt; 
		  Tables DOCTDIAB sex/ row cl;
		  where _region=1 /* Clark County */ and sex= 1; 
		  format DOCTDIAB DOCTDIAB. sex sex.;
run;
proc surveyfreq data=CDDB;
	      STRATUM _ststr;
          CLUSTER _psu;
          WEIGHT _llcpwt; 
		  Tables CHOLMED3 sex/ row cl;
		  where _region=1 /* Clark County */ and CHOLMED3=1; 
		  format CHOLMED3 CHOLMED3_. sex sex.;
run;

proc surveyfreq data=CDDB;
	      STRATUM _ststr;
          CLUSTER _psu;
          WEIGHT _llcpwt; 
		  Tables CVDINFR4 sex/ row cl;
		  where _region=1 /* Clark County */ and CVDINFR4=1; 
		  format CVDINFR4 CVDINFR4_. sex sex.;
run;

proc surveyfreq data=CDDB;
	      STRATUM _ststr;
          CLUSTER _psu;
          WEIGHT _llcpwt; 
		  Tables _RFSMOK3 _racegr3/ row cl;
		  where _region=1 /* Clark County */ and _RFSMOK3=1; 
		  format  _RFSMOK3 _RFSMOK3_. _racegr3 _racegr3_;
run;

proc surveyfreq data=CDDB;
	      STRATUM _ststr;
          CLUSTER _psu;
          WEIGHT _llcpwt; 
		  Tables STOPSMK2 _racegr3/ row cl;
		  where _region=1 /* Clark County */ and STOPSMK2=1; 
		  format STOPSMK2 STOPSMK2_. _racegr3 _racegr3_.;
run;
proc surveyfreq data=CDDB;
	      STRATUM _ststr;
          CLUSTER _psu;
          WEIGHT _llcpwt; 
		  Tables _CURECI1 sex/ row cl;
		  where _region=1 /* Clark County */ and _CURECI1=2; 
		  format _CURECI1 _CURECI1_. sex sex.;
run;

/* UPDATED 2.14 FOR ADDITIONAL CD INDICATORS*/
proc surveyfreq data=CDDB;

	      STRATUM _ststr;
          CLUSTER _psu;
          WEIGHT _llcpwt; 
		  Tables ECIGNOW2  _racegr4/ row cl;
		  where _region=1 /* Clark County */ and _racegr4=1   ; 
		  format ECIGNOW2_ ECIGNOW2_.  _racegr4 _racegr4_.;
run;
proc surveyfreq data=CDDB;

	      STRATUM _ststr;
          CLUSTER _psu;
          WEIGHT _llcpwt; 
		  Tables ECIGNOW2  _racegr4/ row cl;
		  where _region=1 /* Clark County */ and _racegr4=2  ; 
		  format ECIGNOW2_ ECIGNOW2_.  _racegr4 _racegr4_.;
run;
proc surveyfreq data=CDDB;

	      STRATUM _ststr;
          CLUSTER _psu;
          WEIGHT _llcpwt; 
		  Tables ECIGNOW2  _racegr4/ row cl;
		  where _region=1 /* Clark County */ and _racegr4=5   ; 
		  format ECIGNOW2_ ECIGNOW2_.  _racegr4 _racegr4_.;
run;
proc surveyfreq data=CDDB;

	      STRATUM _ststr;
          CLUSTER _psu;
          WEIGHT _llcpwt; 
		  Tables ECIGNOW2  _racegr4/ row cl;
		  where _region=1 /* Clark County */ and _racegr4=3   ; 
		  format ECIGNOW2_ ECIGNOW2_.  _racegr4 _racegr4_.;
run;
*****************/
proc surveyfreq data=CDDB;
	      STRATUM _ststr;
          CLUSTER _psu;
          WEIGHT _llcpwt; 
		  Tables _TOTINDA _racegr3/ row cl;
		  where _region=1 /* Clark County */ and _racegr3=5 ; 
		  format  _TOTINDA _TOTINDA. _racegr3_ _racegr3_.;
run;
/* REDO ALL BRFSS INDICATORS NEXT WEEK*/ 
/*-----------------------------------------------------------------------------------------------------
--------------BY STATE*/


data CDDB;
	set ooe.Brfss_nv2021;
	IF 0 <= (_FRUTSU1/100) < 1 THEN _FRTLT1=2; 
	ELSE IF (_FRUTSU1/100) >= 1 THEN _FRTLT1=1; *Respondents that reported consuming Fruit 1 or more times a day;
	ELSE _FRTLT1=9;

	IF 0 <= (_VEGESU1/100) < 1 THEN _VEGLT1=2; 
 	ELSE IF (_VEGESU1/100) >= 1 THEN _VEGLT1=1; *Respondents who reported consuming vegetables 1 or more times a day;
	ELSE _VEGLT1=9;
run;

/* SEX VAR*/
proc surveyfreq data=CDDB;

	      STRATUM _ststr;
          CLUSTER _psu;
          WEIGHT _llcpwt; 
		  Tables ECIGNOW2  sexvar/ row cl;
		  where _region=1 /* Clark County */ and sexvar=1   ; 
		  format ECIGNOW2 ECIGNOW2_.  sexvar sexvar.;
run;
proc surveyfreq data=CDDB;

	      STRATUM _ststr;
          CLUSTER _psu;
          WEIGHT _llcpwt; 
		  Tables ECIGNOW2  sexvar/ row cl;
		  where _region=1 /* Clark County */ and sexvar=2   ; 
		  format ECIGNOW2 ECIGNOW2_.  sexvar sexvar.;
run;
