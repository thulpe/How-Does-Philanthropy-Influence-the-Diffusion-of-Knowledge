* This is a subprogram
* 
* Updated:	2024-12-03

//* Set STATA version
version 15
clear matrix
capture log close
set more off
clear

//* Set directory - UPDATE BEFORE USE 
cd "C:\Users\User\Dropbox\KTH\Research\Philantropy 2022\STATA PNAS\4. Final versions\STATA PNAS Compact"

//* Initialize log
log using "log-filer/2. Log publications.log", replace

//* Load dataset
use "dta-filer\Dataset_publications", clear

//* Set as panel
xtset ID Year, yearly

//* Winsorize financing and patents, pctile 1 and 99 and save dataset
winsor2 W_Pubs, replace cuts(1 99)
winsor2 Pub_x, replace cuts(1 99)
winsor2 tot_ln, replace cuts(1 99)
winsor2 OthGov_share, replace cuts(1 99)
winsor2 Corp_share, replace cuts(1 99)
winsor2 Noprof_share, replace cuts(1 99)

//* Define dummy variables
local category "Subcat_1 Subcat_2 Subcat_4"	// Base: IT (Subcat 1: BIOMED, Subcat 2: ENG, Subcat 3: IT, Subcat 4: OTH)
local year " Year_3 Year_4 Year_5 Year_6 Year_7 Year_8 Year_9 Year_10 Year_11 Year_12 Year_13 Year_14 Year_15 Year_16" // Base: 2015

//* Regression 

*** NO SPILLOVER

* Two-year lag
nbreg F2.W_Pubs tot_ln OthGov_share Corp_share Noprof_share Ln_HumCap `year' `category' if Nofund!=1, nolog iterate (100)
outreg2 using "output\Pubs_Table_1.doc", replace ctitle (2 year lag) dec(6) keep (tot_ln OthGov_share Corp_share Noprof_share Ln_HumCap `category' `year')

* Four-year lag
nbreg F4.W_Pubs tot_ln OthGov_share Corp_share Noprof_share Ln_HumCap `category' `year' if Nofund!=1, nolog iterate (100)
outreg2 using "output\Pubs_Table_1.doc", append ctitle (4 year lag) dec(6) keep (tot_ln OthGov_share Corp_share Noprof_share Ln_HumCap `category' `year')

*** SPILLOVER

* Two-year lag
nbreg F2.W_Pubs  tot_ln OthGov_share Corp_share Noprof_share Ln_HumCap F2.Pub_x `year' `category' if Nofund!=1, nolog iterate (100)
outreg2 using "output\Pubs_Table_1.doc", append ctitle (2 year lag, SO) dec(6) keep (tot_ln OthGov_share Corp_share Noprof_share Ln_HumCap F2.Pub_x `category' `year')

* Four-year lag
nbreg F4.W_Pubs tot_ln OthGov_share Corp_share Noprof_share Ln_HumCap F4.Pub_x `year' `category' if Nofund!=1, nolog iterate (100)
outreg2 using "output\Pubs_Table_1.doc", append ctitle (4 year lag, SO) dec(6) keep (tot_ln OthGov_share Corp_share Noprof_share Ln_HumCap F4.Pub_x `category' `year')
