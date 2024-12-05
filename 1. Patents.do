* This is a subprogram
* 
* Updated:	2024-12-03

version 15
clear matrix
capture log close
set more off
clear

//* Set path for base directory in use (MUST BE CHANGED BEFORE USE)
cd "C:\Users\User\Dropbox\KTH\Research\Philantropy 2022\STATA PNAS\4. Final versions\STATA PNAS Compact"

//* Initialize log
log using "log-filer/1. Log patents.log", replace

//* Reads dataset for patent analysis
use "dta-filer/Dataset_patents.dta", clear

//* Generate dummy indicating no funding present in observation
gen Nofund=.
replace Nofund=1 if Totfund==0

drop if Nofund==1 /*Removes observations that completely lack funding (either R&D or university funding)*/

//* Defines local dummy variable categories
local category "Category_2 Category_3 Category_4"	// Bas: Computer science
local year "Year_2 Year_3 Year_4 Year_5 Year_6 Year_7 Year_8 Year_9 Year_10 Year_11 Year_12 Year_13 Year_14 Year_15" // Bas: 2001
local faregion "FAreg_*"

//* Sets as yearly panel
xtset Panelid Year, yearly

//* Winsorize financing and patents, pctile 1 and 99

winsor2 ln_Patent, replace cuts(1 99)
winsor2 OthGov_share, replace cuts(1 99)
winsor2 Corp_share, replace cuts(1 99)
winsor2 Noprof_share, replace cuts(1 99)
winsor2 FoU_share, replace cuts(1 99)
winsor2 ln_Totfund, replace cuts(1 99)
winsor2 ln_Pat_x, replace cuts(1 99)

winsor2 OthGov_share_x, replace cuts(1 99)
winsor2 Corp_share_x, replace cuts(1 99)
winsor2 Noprof_share_x, replace cuts(1 99)
winsor2 ln_FoU, replace cuts(1 99)
winsor2 ln_Totfund_x, replace cuts(1 99)

//* Removes observations that lack any active Higher Educational Institution
drop if Ram==0 & OthGov==0 & Corp==0 & Noprof==0

***************************************************
* Regressions - Main model (R&D spending as control) negative binomial distribution
***************************************************
 
* Two year lag excluding accessibility measure
sort Panelid Year
nbreg F2.ln_Patent  Corp_share_x Noprof_share_x ln_Totfund_x OthGov_share_x ln_FoU `category' `year', robust nolog iterate(100)
outreg2 using output/Pat_Table_2.doc, replace ctitle (Local patents, 2y lag) keep (OthGov_share_x Corp_share_x Noprof_share_x ln_FoU ln_Totfund_x `category' `year' )

* Four year lag excluding accessibility measure
nbreg F4.ln_Patent  OthGov_share_x Corp_share_x  ln_Totfund_x Noprof_share_x ln_FoU `category' `year', robust nolog iterate(100)
outreg2 using output/Pat_Table_2.doc, append ctitle (Local patents, 4y lag) keep (OthGov_share_x Corp_share_x Noprof_share_x ln_FoU ln_Totfund_x `category' `year')

* Two year lag including accessibility measure
nbreg F2.ln_Patent OthGov_share_x Corp_share_x Noprof_share_x ln_Totfund_x ln_FoU F2.ln_Pat_x `category' `year', robust nolog iterate(100)
outreg2 using output/Pat_Table_2.doc, append ctitle (Patent spillover, 2y lag) keep (OthGov_share_x Corp_share_x Noprof_share_x ln_FoU ln_Totfund_x F2.ln_Pat_x `category' `year')

* Four year lag including accessibility measure
nbreg F4.ln_Patent OthGov_share_x Corp_share_x  ln_Totfund_x Noprof_share_x ln_FoU F4.ln_Pat_x `category' `year', robust nolog iterate(100)
outreg2 using output/Pat_Table_2.doc, append ctitle (Patent spillover, 4y lag) keep (OthGov_share_x Corp_share_x Noprof_share_x ln_FoU ln_Totfund_x F4.ln_Pat_x `category' `year')

***************************************************
* Regressions - Secondary model (R&D integrated) negative binomial distribution
***************************************************

//* Reads dataset for patent analysis
use "dta-filer/Dataset_patents.dta", clear

//* Re-make Nofund variable
gen Nofund=.
replace Nofund=1 if Totfund==0

//* Defines local dummy variable categories
local category "Category_2 Category_3 Category_4"	// Bas: Computer science
local year "Year_2 Year_3 Year_4 Year_5 Year_6 Year_7 Year_8 Year_9 Year_10 Year_11 Year_12 Year_13 Year_14 Year_15" // Bas: 2001
local faregion "FAreg_*"

xtset Panelid Year, yearly

***************************************************
* Winsorize financing and patents, pctile 1 and 99
***************************************************
winsor2 ln_Patent, replace cuts(1 99)
winsor2 OthGov_share, replace cuts(1 99)
winsor2 Corp_share, replace cuts(1 99)
winsor2 Noprof_share, replace cuts(1 99)
winsor2 FoU_share, replace cuts(1 99)
winsor2 ln_Totfund, replace cuts(1 99)
winsor2 ln_Pat_x, replace cuts(1 99)

//* Removes observations that lack any active Higher Educational Institution
drop if Ram==0 & OthGov==0 & Corp==0 & Noprof==0

* Two year lag excluding accessibility measure
sort Panelid Year
nbreg F2.ln_Patent OthGov_share Corp_share Noprof_share ln_Totfund FoU_share `category' `year' if Nofund!=1, robust nolog iterate(100)
outreg2 using output/Pat_Table_3.doc, replace ctitle (Local patents, 2y lag) dec(6) keep (OthGov_share Corp_share Noprof_share FoU_share ln_Totfund `category' `year' FAreg_1-FAreg_71)

* Four year lag excluding accessibility measure
nbreg F4.ln_Patent  Corp_share OthGov_share Noprof_share ln_Totfund FoU_share `category' `year' if Nofund!=1, robust nolog iterate(100)
outreg2 using output/Pat_Table_3.doc, append ctitle (Local patents, 4y lag) dec(6) keep (OthGov_share Corp_share Noprof_share FoU_share ln_Totfund `category' `year' FAreg_1-FAreg_71)

* Two year lag including accessibility measure
nbreg F2.ln_Patent OthGov_share Corp_share Noprof_share ln_Totfund FoU_share F2.ln_Pat_x `category' `year' if Nofund!=1, robust nolog iterate(100)
outreg2 using output/Pat_Table_3.doc, append ctitle (Patent spillover, 2y lag) dec(6) keep (OthGov_share Corp_share Noprof_share FoU_share ln_Totfund F2.ln_Pat_x  `category' `year' FAreg_1-FAreg_71)

* Four year lag including accessibility measure
nbreg F4.ln_Patent OthGov_share Corp_share Noprof_share ln_Totfund FoU_share F4.ln_Pat_x `category' `year' if Nofund!=1, robust nolog iterate(100)
outreg2 using output/Pat_Table_3.doc, append ctitle (Patent spillover, 4y lag) dec(6) keep (OthGov_share Corp_share Noprof_share FoU_share ln_Totfund F4.ln_Pat_x `category' `year' FAreg_1-FAreg_71)

