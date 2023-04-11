*Programmed by: Naman Pujani*
Programmed on: 2022-09-26*
Course and Section Number: ST 445 (001)
Intent: Create a report that matches HW2 Duggins Basic Sales Report.pdf and the HW2 
Duggins Basic Sales Report.rtf using the Basic Sales data set.*

*clears log and listing windows;
DM "log;clear";
DM "output;clear";

*Setting up my librefs, filerefs, and my working directory*;
x "cd L:\st445\data";
libname InputDS ".";
filename Raw ".";
x "cd S:\HW2";
libname HW2 ".";

ods listing close;
*Sending the output created to an rtf and pdf respectively and adding the styles*;
ods rtf file = "HW 2 Pujani Basic Sales Metadata.rtf" style = sapphire;
ods pdf file = "HW 2 Pujani Basic Sales Report.pdf" style = journal;
ods trace on;

*Using a data step to read in the raw data and applying the labels and formats*;
data HW2.BasicSalesNorth;
  length Cust $ 45 EmpID $ 4 Region $ 5;
  infile raw("BasicSalesNorth.dat") firstobs = 11 dlm ='09'x;
  input Cust $ EmpID $ Region $ Hours Date Rate TotalDue;
  attrib EmpID label = "Employee ID"
         Cust label = "Customer" 
         Date label = "Bill Date" format = yymmdd10.
         Region label = "Customer Region"
         Hours label = "Hours Billed" format = 5.2
         Rate label = "Bill Rate" format = DOLLAR4.
         TotalDue label = "Amount Due" format = DOLLAR9.2
       ;


run;
*Deleting the default proc title and excluding the dates and excluding outputs from
the pdf*;
ods noproctitle;
options nodate;
ods pdf exclude all;

*Only printing the first Contents table and adding titles*;
ods rtf select Position;
title 'Variable-Level Metadata (Descriptor) Information';
title2 height = 10pt 'for records from North Region';
*Using PROC CONTENTS to print the metadata for the North dataset*;
proc contents data = HW2.BasicSalesNorth varnum;
run;
title;

*Using another data step to read in raw data and adding labels and formats*;
data HW2.BasicSalesSouth;
  infile raw("BasicSalesSouth.prn") firstobs = 12;
  input Cust $ 1-45 EmpID $ 46-49 Region $ 50-54 Hours 55-59 Date 60-64
  Rate 65-67 TotalDue 68-73;
  attrib Cust label = "Customer" 
         EmpID label = "Employee ID"
         Region label = "Customer Region" 
         Hours label = "Hours Billed" format = 5.2
         Date label = "Bill Date" format = mmddyy10.
         Rate label = "Bill Rate" format = DOLLAR4.
         TotalDue label = "Amount Due" format = DOLLAR9.2
       ;
run;
*Excluding the PROC title, date, and the next output from the PDF*;
ods noproctitle;
options nodate;
ods pdf exclude all;

*Only selecting the first table of Contents and adding titles*;
ods rtf select Position;
title 'Variable-Level Metadata (Descriptor) Information';
title2 height = 10pt 'for records from South Region';
*Using PROC Contents to print the metadata for the South dataset*;
proc contents data = HW2.BasicSalesSouth varnum;
run;
title;

*Using another data step to read in the last raw dataset and adding labels and
formats*;
data HW2.BasicSalesEastWest;
  infile raw("BasicSalesEastWest.txt") firstobs = 12 dlm = '2C'x;
  length EmpID $ 4 Cust $ 45 Region $ 5;
  input Cust $ 1-45 EmpID $ 46-49 Region $ 50-53 Hours Date Rate TotalDue; 
  attrib EmpID label = "Employee ID"
         Cust label = "Customer"
         Date label = "Bill Date" format = Date9.
         Region label = "Customer Region" 
         Hours label = "Hours Billed" format = 5.2
         Rate label = "Bill Rate" format = DOLLAR4.
         TotalDue label = "Amount Due" format = DOLLAR9.2

;
run;
*Excluding the default PROC title, the date, and the following output from the PDF.
Adding an fmtsearch to search for formats in the InputDS library*;
ods noproctitle;
options nodate;
options fmtsearch = (InputDS);
ods pdf exclude all;

*Selecting the first table in PROC Contents and adding titles*;
ods rtf select Position;
title 'Variable-Level Metadata (Descriptor) Information';
title2 height = 10pt 'for records from East and West Regions';
*Using PROC CONTENTS to print out the metadata in the rtf for the EastWest dataset*;
proc contents data = HW2.BasicSalesEastWest varnum;
run;
title;

*Using PROC FORMAT to select the BasicAmtDue format and printing it in the rtf*;
proc format library = InputDS.formats fmtlib;
  select BasicAmtDue;
run;

*Excluding default PROC title and sending the rest of the output to the PDF*;
ods noproctitle;
ods rtf exclude all;
ods pdf exclude none;

*Creating a five number summary using PROC MEANS*;
title 'Five Number Summaries of Hours and Amounts Due';
title2 height = 10pt 'Grouped By Employee, Customer, and Region';
footnote j=l height = 8pt 'Data Source: East and West regions only';
proc means data = HW2.BasicSalesEastWest min p25 p50 p75 max maxdec = 2 nolabels;
  class EmpID Cust Region;
  var Hours TotalDue;
  label EmpID = "Employee ID" Cust = "Customer" Region = "Customer Region";

run;
title;
footnote;

*Creating a one-way and a two-way table for the North dataset by Customer
and Customer by Quarter*;
title 'Breakdown of Records by Customer and Customer by Quarter';
footnote j=l height = 10pt 'Data Source: North region only';
proc freq data = HW2.BasicSalesNorth;
  tables Cust;  
  tables Cust*Date/ norow nocol; 
  format Date qtrr.;
run;
footnote;
*Sorting the data to be in ascending TotalDue order for the PROC PRINT step*;
proc sort data = HW2.BasicSalesSouth
  out = HW2SortedSouth;
  by Cust descending Date;

run;

*Using a PROC PRINT step to print out the records with an amount due of at least a 
$1000 or from Frank's Franks with a bill rate of $75 or $150*;
title 'Listing of Selecting Billing Records';
footnote j=l height = 10pt 'Data Source: South Region only';
footnote2 j=l height = 10pt "Included: Records with an amount due of at least $1000  
or from Frank's Franks with a bill rate of $75 or $150";
proc print data = HW2.BasicSalesSouth label;
  var Date EmpID Hours Rate TotalDue;
  id Cust;

  sum Hours TotalDue;
  where (TotalDue >= 1000) or (Cust = "Frank's Franks" and (Rate = 75 or Rate = 150));
run;
title;
footnote;
ods rtf close;
ods pdf close;

quit;