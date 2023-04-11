/*
Programmed by: Naman Pujani
Programmed on: 2022/11/9
Course and Section Number: ST 445 (001)
Intent: Match Duggins HW6 PDF Report
*/

*To clear the log and the listing windows*;
DM "log;clear";
DM "output;clear"; 

*Setting up my librefs, filrefs, and working directory*;
X "cd L:\st445";
libname InputDS "Data";
libname Results "Results";
filename RawData "Data";

X "cd S:\HW";
libname HW6 "";
filename HW6 "HW6";

ods listing close;

*Reading in the Cities.txt file*;
data HW6.HW6PujaniCities (drop=_:);
  infile RawData("Cities.txt") dlm="09"x firstobs=2;
  input _City : $40.
        CityPop : comma.
;
  City = input(tranwrd(_city, "/", "-"), $40.); 
run;

*Reading in States.txt file*;
data HW6.HW6PujaniStates;
  infile RawData("States.txt") truncover dlm="09"x firstobs=2;
  input Serial 
        State $20.
        City $ 28-73
;
run;

*Reading in Contract.txt; 
data HW6.HW6PujaniContract;
  infile RawData("Contract.txt") dlm="09"x firstobs=2;
  input Serial :
        Metro :
        CountyFIPS : $3.
        MortPay : DOLLAR6.
        HHI : DOLLAR10.
        HomeVal : DOLLAR10.
;
run;

*Reading in Mortgaged.txt;
data HW6.HW6PujaniMortgaged;
  infile RawData("Mortgaged.txt") dlm="09"x firstobs=2 truncover;
  input Serial :
        Metro :
        CountyFIPS : $3.
        MortPay : DOLLAR6.
        HHI : DOLLAR10.
        HomeVal : DOLLAR10.
;
run;

*Sorting the Pujani Cities Data by City;
proc sort data = HW6.HW6PujaniCities;
  by City;
run;

*Sorting the Pujani States Data by City;
proc sort data = HW6.HW6PujaniStates;
  by City;
run;

*Combining the two sorted States and Cities datasets and setting City to 0 if it's
not identifiable;
data HW6.HW6PujaniMerge1;
  merge HW6.HW6PujaniCities
        HW6.HW6PujaniStates ;
  by City;
  if City = "Not in identifiable city (or size group)" then do;
     CityPop = 0;
       end;
run;
*Combining the Contract, Mortgage, Renters, and Freeclear datasets and using tracking
variables to change the missing values in order to show M or .R*;
data HW6.HW6PujaniMerge2;
  set InputDS.Freeclear (in = Free)
      InputDS.Renters (in = Rent rename=(FIPS=CountyFIPS))
      HW6.HW6PujaniContract (in = Contract)
      HW6.HW6PujaniMortgaged (in = Mortgage);
  attrib MortStat length = $45.
         Ownership length = $6.
;
  if Free eq 1 then do;
    MortStat = "No, owned free and clear";
    Ownership = "Owned";
  end;
  if HomeVal = . then do;
     HomeVal = .M;
    end;
  if Rent eq 1 then do;
     MortStat = "N/A";
     Ownership = "Rented";
  end;
    if HomeVal = 9999999 then do;
       HomeVal = .R;
    end;
  if Contract eq 1 then do;
     MortStat = "Yes, contract to purchase";
     Ownership = "Owned";
  end;
    if HomeVal = . then do;
       HomeVal = .M;
    end;
  if Mortgage eq 1 then do;
     MortStat = "Yes, mortgaged/ deed of trust or similar debt";
     Ownership = "Owned";
  end;
    if HomeVal = . then do;
       HomeVal = .M;
    end;
run;

*Sorting PujaniMerge1 by Serial*;
proc sort data=HW6.HW6PujaniMerge1;
 by Serial;
run;

*Sorting PujaniMerge 2 by Serial.;
proc sort data=HW6.HW6PujaniMerge2;
  by Serial; 
run;

*Creating a format for MetroDesc*;
proc format library=HW6.formats fmtlib ;
  value MetroDesc(fuzz=0)
    0 = "Indeterminable"
    1 = "Not in a Metro Area"
    2 = "In Central/Principal City"
    3 = "Not in Central/Principal City"
    4 = "Central/Principal Indeterminable"
;
run;

options fmtsearch = (HW6);

*Combining the two merged datasets and applying formats and labels*;
data HW6.HW6PujaniIpums2005;
  attrib Serial     label = "Household Serial Number"
         CountyFIPS label = "County FIPS Code"
         Metro      label = "Metro Status Code"
         MetroDesc  label = "Metro Status Description"
                    length = $32.
         CityPop    label = "City Population (in 100s)"
                    format = COMMA6.
         MortPay    label = "Monthly Mortgage Payment"
                    format = DOLLAR6.
         HHI        label = "Household Income"
                    format = DOLLAR10.
         HomeVal    label = "Home Value"
                    format = DOLLAR10.
         State      label = "State, District, or Territory"
         City       label = "City Name"
         MortStat   label = "Mortgage Status"
         Ownership  label = "Ownership Status"
;
  merge HW6.HW6PujaniMerge2
        HW6.HW6PujaniMerge1;
  by Serial;
  MetroDesc = put(Metro, MetroDesc.);
run;

*Using PROC CONTENTS to produce metadata for PujaniIpums2005*;
ods output position=HW6.HW6PujaniDesc (drop = member);
proc contents data=HW6.HW6PujaniIpums2005 varnum;
run;

*Creating a macrovariable for the compare step to reduce redundancy*;
%let CompOpts =
             outbase outcompare outdiff outnoequal
             method = absolute criterion = 1E-15;

*Comparing my PujaniIpums dataset against Dr.Duggins'*;
proc compare base=Results.HW6DugginsIpums2005 compare=HW6.HW6PujaniIpums2005
             out = work.diffsA
             &CompOpts;
run;

*Comparing my PujaniDesc dataset against Dr.Duggins'*;
proc compare base=Results.HW6DugginsDesc compare=HW6.HW6PujaniDesc
             out = work.diffsB
             &CompOpts;
run;

options nodate;
options nonumber;
ods noproctitle;

*Sending following output to a pdf. Setting startpage=NEVER*;
ods pdf file = "HW6 Pujani IPUMS Report.pdf" startpage=NEVER;

*Using PROC REPORT to find all NC households with incomes over $500,000*;
title "Listing of Households in NC with Incomes Over $500,000";
proc report data = HW6.HW6PujaniIpums2005;
  columns City Metro MortStat HHI HomeVal;
  where (State = "North Carolina") & (HHI > 500000);
run;
title;

*Using PROC UNIVARIATE to produce output for the variables*;
ods trace on;
ods noproctitle;
proc univariate data = HW6.HW6PujaniIpums2005;
  histogram CityPop / kernel;
  var CityPop MortPay HHI HomeVal;
  ods select  Univariate.CityPop.BasicMeasures
              Univariate.CityPop.Quantiles
              Univariate.CityPop.Histogram.Histogram
              Univariate.MortPay.Quantiles
              Univariate.HHI.BasicMeasures
              Univariate.HHI.ExtremeObs
              Univariate.HomeVal.BasicMeasures
              Univariate.HomeVal.ExtremeObs
              Univariate.HomeVal.MissingValues;
              
run;
ods trace off;
ods pdf startpage = never;

*Adding graphic options*;
ods listing image_dpi=300;
ods graphics / reset width=5.5in imagename="CityPop";
*Creating a histogram for CityPop*;
title "Distribution of City Population";
title2 "(For Households in a Recongnized City)";
footnote j=l "Recognized cities have a non-zero value for City Population";
proc sgplot data = HW6.HW6PujaniIpums2005;
  where CityPop ne 0;
  histogram CityPop / scale = proportion;
  density CityPop / type = kernel
                    lineattrs=(color=Red thickness=3);
  xaxis label = "City Population (in 100s)";
  yaxis display = (nolabel)
        valuesformat = percent.;
  keylegend / location = inside;
run;
title;
footnote;

*Adding graphic options*;
ods graphics / reset width=5.5in imagename="HHIpanel";
*Creating histograms for HHI, panelled by MortStat*;
title "Distribution of Household Income Stratified by Mortgage Status";
footnote "Kernel estimate parameters were determined automatically.";
proc sgpanel data=HW6.HW6PujaniIpums2005 noautolegend;
  panelby MortStat / novarname;
  histogram HHI / scale = proportion ;
  density HHI / type = kernel
                lineattrs=(color=Red);
  rowaxis display = (nolabel)
          valuesformat = percent.;
  colaxis label = "Household Income";
run;
title;
footnote;
  

ods pdf close;
ods listing;
quit; 
