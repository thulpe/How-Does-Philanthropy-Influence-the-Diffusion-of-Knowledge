# How-Does-Philanthropy-Influence-the-Diffusion-of-Knowledge
*This readme is a description of how to replicate results in:

 "How Does Philanthropy Influence the Diffusion of Knowledge?
Impacts from donations on scientific publications and innovations"

*Updated:	2024-12-03

*** Replication instructions for patenting (results tables 2 and 3)

*Patenting step 1: Open the STATA do file "1. Patents.do" located in the "\do"-directory

*Step 2: Change the working directory under the heading "//* Set path for base directory in use" to the current location of the directory
  
*Step 3: Execute the do-file.

*Step 4: Results are saved in two files: "Pat_Table_2" and "Pat_Table_3", replicating table 2 and 3 respectively. The files are located in the "\output"-directory, in both .txt and .doc format.

* Note - see variable labels for full variable descriptions

*** Replication instructions for academic publications (results table 1)

*Academic publications step 1: Open the STATA do file "2. Academic Publications.do" located in the "\do"-directory

*Step 2: Change the working directory under the heading "//* Set directory - UPDATE BEFORE USE" to the current location of the directory

*Step 3: Execute the do-file.

*Step 4: Results are saved in one file: "Pubs_Table_1",  replicating table 1. The file is located in the "\output"-directory, in both .txt and .doc format.

* Note - see variable labels for full variable descriptions

Description of dataset
Summary: This dataset is in STATA-format and consists of two parts: 
1: Patenting activity and research funding (“Dataset_patents.dta”):
Dataset type: Panel 
Time coverage: 2001-2015
Geographical coverage (country): Sweden
Unit of analysis: Functional labor market region (“FA-region”) and subject area. 
Outcome variable: The (logged) number of valid patent applications to the Swedish patent office (PRV), divided into four broad categories: Engineering, Medical & Biological, Information Technology and Other. 
Explanatory variables consist of two total funding variables (depending on the model used), one including corporate R&D and one excluding corporate R&D from the total, describing the (logged) total funding allocated to a particular FA-region and category each year. 
In addition, explanatory variables include two separate sets of research funding shares expressed as a percentage of total funding: One for the total funding variable which includes corporate R&D and one for the total funding variable which excludes corporate R&D. 
These funding shares are divided into five main categories, depending on the funding source: 
-	Base government research funding to higher education institution (HEI) research
-	Other government funding to HEI research
-	Corporate funding to HEI research
-	Non-profit funding to HEI research
-	Corporate research and development (R&D) funding (imputed using the number of researchers employed in each region and category).  
Finally, the dataset contains one explanatory variable that captures the geographical proximity of every functional labor market region to patenting activity in other functional labor market regions. 
Data sources: Statistics Sweden (funding variables), PATSTAT (outcome variable and patenting activity proximity control)
2: Academic publications and research funding (“Dataset_publications”):
Dataset type: Panel 
Time coverage: 2001-2015 (explanatory variables); 2005-2015 (outcome variable)
Geographical coverage (country): Sweden
Unit of analysis: Higher education institution (HEI) and subject area. 
Outcome variable: The number of academic publications registered in Web-of-Science, measured as an annual, forward-looking, four-year rolling average of the number of publications produced by authors at Swedish universities. If a publication is co-authored, it is shared evenly between each university with which the authors are affiliated.
The explanatory variables consist of one total funding variable describing the total amount of funding allocated to a particular HEI and category each year.
In addition, explanatory variables include research funding shares expressed as a percentage of total funding. 
These funding shares are divided into four main categories, depending on the funding source: 
-	Base government research funding to higher education institution (HEI) research
-	Other government funding to HEI research
-	Corporate funding to HEI research
-	Non-profit funding to HEI research
Finally, the dataset contains one explanatory variable that captures the geographical proximity of every HEI to academic publication activity in other HEI:s. 
Data sources: Statistics Sweden (funding variables), PATSTAT (outcome variable and academic publication activity proximity control)


