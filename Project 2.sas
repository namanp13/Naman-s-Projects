/*
Programmed by: Naman Pujani
Programmed on: 2022-10-15
Course and Section Number: ST 445 (001)
Intent: Match Duggins HW4 PDF Report
*/

*To clear the log and the listing windows;
DM "log;clear";
DM "output;clear"; 

*Setting up my librefs, filrefs, and working directory*;
X "cd L:\st445";
libname InputDS "Data";
libname Results "Results";
filename RawData "Data";


X "cd S:\HW";
libname HW4 ".";
filename HW4 ".";

ods listing close;

*Using a data step to read the raw data in*;
data HW4.HW4PujaniLead(drop = _:);
  infile RawData("LeadProjects.txt") firstobs = 2 dsd truncover;
  attrib StName label = "State Name" length = $2
         Region                      length = $9
         JobID                       length = 8.
         Date                        format = DATE9.
         PolType label = "Pollutant Name" length = $4
         PolCode label = "Pollutant Code" length = $8
         Equipment                   format = DOLLAR11.
         Personnel                   format = DOLLAR11.
         JobTotal                    format = DOLLAR11.
         ;
 input _StName : $2.  _JobID : $5.  _DateRegion : $13. _CodeType : $5. _Equipment : $9.
 _Personnel : $9.
;
  StName = upcase(_StName);
  Region = substr(_DateRegion,6); Region =  propcase(Region);
  Date = substr(_DateRegion, 1, 5); PolType = substr(_CodeType,2);
  PolCode = substr(_CodeType,1,1);
  _JobIDfix = tranwrd(tranwrd(_JobID,"O","0"),"l", "1");
  JobID = input(_JobIDfix, 8.2);
  Equipment = compress(_Equipment, "$,"); 
  Personnel = compress(_Personnel, "$,");
  JobTotal = Equipment + Personnel;
run;
*Sorting the raw data that was read in to match Duggins Report*;
proc sort data = HW4.HW4PujaniLead;
  by Region StName descending JobTotal;
run;
*Creating a macrovariable for PROC COMPARE steps*;
%let CompOpts =
             outbase outcompare outdiff outnoequal
             method = absolute criterion = 1E-15;


*Comparing HW4PujaniLead to HW4DugginsLead dataset*;
proc compare base = Results.hw4dugginslead compare = HW4.HW4PujaniLead
             out = work.diffsB
             &CompOpts;
run;
*Creating the metadata and dropping the member variable*;
ods output position = HW4.HW4PujaniLeadDesc (drop = member);
proc contents data = HW4.HW4PujaniLead varnum;
run;
*Comparing my metadata to Duggins' Metadata*;
proc compare base = Results.hw4dugginsdesc compare = HW4.HW4PujaniLeadDesc
             out = work.diffsA
             &CompOpts;
run;

*Creating a format for the date variable called MyQtr*;
proc format library = HW4.formats fmtlib;
  value MyQtr (fuzz=0) low - 13969 = "Jan/Feb/March"
                      13970 -< 14060 = "April/May/June"
                      14061 -< 14152 = "July/August/September"
                      14153 - high = "October/November/December" 
;
run;

*Creating a pdf to send the output to*;
ods pdf file = "HW4 Pujani Lead Report.pdf";
*Setting no date and no proc title options and searching for formats*;
options nodate;
ods noproctitle;
options fmtsearch = (HW4);

*Creating the proc means table on the first page of the Duggins Lead Report*;
title '90th Percentile of Total Job Cost by Region and Quarter';
title2 'Data for 1998';
ods output summary = HW4.HW4Pctile90;
proc means data = HW4.HW4PujaniLead p90;
  class Region Date;
  var JobTotal;
  format Date MyQtr.;
run;
title;

*Creating a horizontal bar graph to match the second page of Duggins Lead Report of
the pdf*;
ods listing image_dpi = 300;
ods graphics / reset width = 6in imagename="HW4Pctile90";
proc sgplot data = HW4.HW4Pctile90;
  hbar region / response = JobTotal_p90 group = Date groupdisplay = cluster datalabel = nobs
                 DATALABELATTRS = (Size=6);
  keylegend / position = top title = "Date";
  yaxis label = "Region";
  xaxis label = "90th Percentile of Total Job Cost"
    valuesformat = dollar8.
    grid;
run;
ods listing close;

*Creating a frequency graph of region by date and matching to page 3 of Duggins
Lead Report pdf*;
title 'Frequency of Cleanup by Region and Date';
title2 'Data for 1998';
ods output CrossTabFreqs=HW4.HW4RegionPct (keep = Date Region rowpercent);
proc freq data = HW4.HW4PujaniLead;
  table region*date / nocol nopercent;
  format Date MyQtr.;
run;
title;

*Creating a vertical bar chart to match page 4 of Duggins Lead Report pdf*;
ods listing image_dpi=300;
ods graphics / reset width = 6in imagename = "HW4RegionPct";
ods output sgplot=HW4.HW4PujaniLeadGraph2;
proc sgplot data = HW4.HW4RegionPct;
  styleattrs datacolors = (CXE8D898 CXFF00FF CXFF0000 CX16A629);
  vbar region / response = rowpercent group = date groupdisplay = cluster;
 
  yaxis label = "Region Percentage within Pollutant"
    labelattrs = (size = 16pt)
    values = (0 to 45 by 5)
    valueattrs = (size = 12pt)
    valuesformat = data
    offsetmax = 0.05
    grid
    gridattrs = (color = grayCC thickness = 3)
;

  xaxis label = "Region"
    labelattrs = (size = 16pt)
    valueattrs = (size = 14pt)
;

    keylegend / location = inside position = topright across = 1;

    format rowpercent 6.1; 
run;
ods listing close;
ods pdf close;

*Using PROC COMPARE to compare my RegionPct data to Dr. Duggins'*;
proc compare base = Results.hw4dugginsgraph2 compare = HW4.HW4PujaniLeadGraph2
             out = work.diffsC
             &CompOpts;
run;

ods listing;
quit;

