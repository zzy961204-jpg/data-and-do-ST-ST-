* Table 2
version 17.0
clear all
set more off
use if data_type==1 using "github_data.dta", clear
xtset firm_id week_id

xtreg Wretwd DID L_lnMV PastRet4 L_Turnover Beta52 i.week_id, fe vce(cluster firm_id)
xtreg Vol26 DID L_lnMV PastRet4 L_Turnover Beta52 i.week_id, fe vce(cluster firm_id)
xtreg DownVol26 DID L_lnMV PastRet4 L_Turnover Beta52 i.week_id, fe vce(cluster firm_id)
xtreg NCSKEW26 DID L_lnMV PastRet4 L_Turnover Beta52 L_Vol26 i.week_id, fe vce(cluster firm_id)

* Table 3
version 17.0
clear all
set more off
use if data_type==1 using "github_data.dta", clear
xtset firm_id week_id

* Panel A
reghdfe Wretwd DID L_lnMV PastRet4 L_Turnover Beta52, absorb(firm_id week_id) vce(cluster firm_id week_id)
reghdfe Vol26 DID L_lnMV PastRet4 L_Turnover Beta52, absorb(firm_id week_id) vce(cluster firm_id week_id)
reghdfe DownVol26 DID L_lnMV PastRet4 L_Turnover Beta52, absorb(firm_id week_id) vce(cluster firm_id week_id)
reghdfe NCSKEW26 DID L_lnMV PastRet4 L_Turnover Beta52 L_Vol26, absorb(firm_id week_id) vce(cluster firm_id week_id)

* Panel B
xtreg Wretwd DID L_lnMV PastRet4 L_Turnover Beta52 i.week_id if no_transition==1, fe vce(cluster firm_id)
xtreg Vol26 DID L_lnMV PastRet4 L_Turnover Beta52 i.week_id if no_transition==1, fe vce(cluster firm_id)
xtreg DownVol26 DID L_lnMV PastRet4 L_Turnover Beta52 i.week_id if no_transition==1, fe vce(cluster firm_id)
xtreg NCSKEW26 DID L_lnMV PastRet4 L_Turnover Beta52 L_Vol26 i.week_id if no_transition==1, fe vce(cluster firm_id)

* Panel C
xtreg Wretwd DID L_lnMV PastRet4 L_Turnover Beta52 i.week_id if narrow_window==1, fe vce(cluster firm_id)
xtreg Vol26 DID L_lnMV PastRet4 L_Turnover Beta52 i.week_id if narrow_window==1, fe vce(cluster firm_id)
xtreg DownVol26 DID L_lnMV PastRet4 L_Turnover Beta52 i.week_id if narrow_window==1, fe vce(cluster firm_id)
xtreg NCSKEW26 DID L_lnMV PastRet4 L_Turnover Beta52 L_Vol26 i.week_id if narrow_window==1, fe vce(cluster firm_id)

* Panel D
xtreg Wretwd DID L_lnMV PastRet4 L_Turnover Beta52 i.week_id if s_return==1, fe vce(cluster firm_id)
xtreg Wretwd DID i.week_id if s_return==1, fe vce(cluster firm_id)
xtreg Vol26 DID L_lnMV PastRet4 L_Turnover Beta52 i.week_id if s_vol==1, fe vce(cluster firm_id)
xtreg Vol26 DID i.week_id if s_vol==1, fe vce(cluster firm_id)
xtreg DownVol26 DID L_lnMV PastRet4 L_Turnover Beta52 i.week_id if s_down==1, fe vce(cluster firm_id)
xtreg DownVol26 DID i.week_id if s_down==1, fe vce(cluster firm_id)
xtreg NCSKEW26 DID L_lnMV PastRet4 L_Turnover Beta52 L_Vol26 i.week_id if s_crash==1, fe vce(cluster firm_id)
xtreg NCSKEW26 DID i.week_id if s_crash==1, fe vce(cluster firm_id)

* Table 4
version 17.0
clear all
set more off
use if data_type==1 using "github_data.dta", clear
xtset firm_id week_id

* ST
xtreg Wretwd DID L_lnMV PastRet4 L_Turnover Beta52 i.week_id if t4_ST==1, fe vce(cluster firm_id)
xtreg Vol26 DID L_lnMV PastRet4 L_Turnover Beta52 i.week_id if t4_ST==1, fe vce(cluster firm_id)
xtreg DownVol26 DID L_lnMV PastRet4 L_Turnover Beta52 i.week_id if t4_ST==1, fe vce(cluster firm_id)
xtreg NCSKEW26 DID L_lnMV PastRet4 L_Turnover Beta52 L_Vol26 i.week_id if t4_ST==1, fe vce(cluster firm_id)
* StarST
xtreg Wretwd DID L_lnMV PastRet4 L_Turnover Beta52 i.week_id if t4_StarST==1, fe vce(cluster firm_id)
xtreg Vol26 DID L_lnMV PastRet4 L_Turnover Beta52 i.week_id if t4_StarST==1, fe vce(cluster firm_id)
xtreg DownVol26 DID L_lnMV PastRet4 L_Turnover Beta52 i.week_id if t4_StarST==1, fe vce(cluster firm_id)
xtreg NCSKEW26 DID L_lnMV PastRet4 L_Turnover Beta52 L_Vol26 i.week_id if t4_StarST==1, fe vce(cluster firm_id)

* Coefficient equality tests
use if inlist(data_type,1,2) using "github_data.dta", clear
reghdfe Wretwd i.equation#c.(DID L_lnMV PastRet4 L_Turnover Beta52), absorb(equation#firm_id equation#week_id) vce(cluster firm_id) keepsingletons tolerance(1e-12) iterate(16000)
test 1.equation#c.DID=2.equation#c.DID
reghdfe Vol26 i.equation#c.(DID L_lnMV PastRet4 L_Turnover Beta52), absorb(equation#firm_id equation#week_id) vce(cluster firm_id) keepsingletons tolerance(1e-12) iterate(16000)
test 1.equation#c.DID=2.equation#c.DID
reghdfe DownVol26 i.equation#c.(DID L_lnMV PastRet4 L_Turnover Beta52), absorb(equation#firm_id equation#week_id) vce(cluster firm_id) keepsingletons tolerance(1e-12) iterate(16000)
test 1.equation#c.DID=2.equation#c.DID
reghdfe NCSKEW26 i.equation#c.(DID L_lnMV PastRet4 L_Turnover Beta52 L_Vol26), absorb(equation#firm_id equation#week_id) vce(cluster firm_id) keepsingletons tolerance(1e-12) iterate(16000)
test 1.equation#c.DID=2.equation#c.DID

* Table 5
version 17.0
clear all
set more off
use if data_type==1 using "github_data.dta", clear
xtset firm_id week_id


* w_nn13_wr_c02
xtreg Wretwd DID L_lnMV PastRet4 L_Turnover Beta52 i.week_id if w_nn13_wr_c02>0 & !missing(w_nn13_wr_c02) [aw=w_nn13_wr_c02], fe vce(cluster firm_id)
xtreg Vol26 DID L_lnMV PastRet4 L_Turnover Beta52 i.week_id if w_nn13_wr_c02>0 & !missing(w_nn13_wr_c02) [aw=w_nn13_wr_c02], fe vce(cluster firm_id)
xtreg DownVol26 DID L_lnMV PastRet4 L_Turnover Beta52 i.week_id if w_nn13_wr_c02>0 & !missing(w_nn13_wr_c02) [aw=w_nn13_wr_c02], fe vce(cluster firm_id)
xtreg NCSKEW26 DID L_lnMV PastRet4 L_Turnover Beta52 L_Vol26 i.week_id if w_nn13_wr_c02>0 & !missing(w_nn13_wr_c02) [aw=w_nn13_wr_c02], fe vce(cluster firm_id)

* w_nn15_wr_c02
xtreg Wretwd DID L_lnMV PastRet4 L_Turnover Beta52 i.week_id if w_nn15_wr_c02>0 & !missing(w_nn15_wr_c02) [aw=w_nn15_wr_c02], fe vce(cluster firm_id)
xtreg Vol26 DID L_lnMV PastRet4 L_Turnover Beta52 i.week_id if w_nn15_wr_c02>0 & !missing(w_nn15_wr_c02) [aw=w_nn15_wr_c02], fe vce(cluster firm_id)
xtreg DownVol26 DID L_lnMV PastRet4 L_Turnover Beta52 i.week_id if w_nn15_wr_c02>0 & !missing(w_nn15_wr_c02) [aw=w_nn15_wr_c02], fe vce(cluster firm_id)
xtreg NCSKEW26 DID L_lnMV PastRet4 L_Turnover Beta52 L_Vol26 i.week_id if w_nn15_wr_c02>0 & !missing(w_nn15_wr_c02) [aw=w_nn15_wr_c02], fe vce(cluster firm_id)

* w_radius_c02
xtreg Wretwd DID L_lnMV PastRet4 L_Turnover Beta52 i.week_id if w_radius_c02>0 & !missing(w_radius_c02) [aw=w_radius_c02], fe vce(cluster firm_id)
xtreg Vol26 DID L_lnMV PastRet4 L_Turnover Beta52 i.week_id if w_radius_c02>0 & !missing(w_radius_c02) [aw=w_radius_c02], fe vce(cluster firm_id)
xtreg DownVol26 DID L_lnMV PastRet4 L_Turnover Beta52 i.week_id if w_radius_c02>0 & !missing(w_radius_c02) [aw=w_radius_c02], fe vce(cluster firm_id)
xtreg NCSKEW26 DID L_lnMV PastRet4 L_Turnover Beta52 L_Vol26 i.week_id if w_radius_c02>0 & !missing(w_radius_c02) [aw=w_radius_c02], fe vce(cluster firm_id)

* w_kernel_h02
xtreg Wretwd DID L_lnMV PastRet4 L_Turnover Beta52 i.week_id if w_kernel_h02>0 & !missing(w_kernel_h02) [aw=w_kernel_h02], fe vce(cluster firm_id)
xtreg Vol26 DID L_lnMV PastRet4 L_Turnover Beta52 i.week_id if w_kernel_h02>0 & !missing(w_kernel_h02) [aw=w_kernel_h02], fe vce(cluster firm_id)
xtreg DownVol26 DID L_lnMV PastRet4 L_Turnover Beta52 i.week_id if w_kernel_h02>0 & !missing(w_kernel_h02) [aw=w_kernel_h02], fe vce(cluster firm_id)
xtreg NCSKEW26 DID L_lnMV PastRet4 L_Turnover Beta52 L_Vol26 i.week_id if w_kernel_h02>0 & !missing(w_kernel_h02) [aw=w_kernel_h02], fe vce(cluster firm_id)

* Table 6
version 17.0
clear all
set more off
use if data_type==3 using "github_data.dta", clear
xtset firm_id period_id


* Panel A
xtreg BlockVol DID L_lnMV PastRet4 L_Turnover Beta52 i.period_id if s_vol==1, fe vce(cluster firm_id)
xtreg BlockVol DID i.period_id if s_vol==1, fe vce(cluster firm_id)
xtreg BlockDown DID L_lnMV PastRet4 L_Turnover Beta52 i.period_id if s_down==1, fe vce(cluster firm_id)
xtreg BlockDown DID i.period_id if s_down==1, fe vce(cluster firm_id)
xtreg BlockCrash DID L_lnMV PastRet4 L_Turnover Beta52 L_Vol26 i.period_id if s_crash==1, fe vce(cluster firm_id)
xtreg BlockCrash DID i.period_id if s_crash==1, fe vce(cluster firm_id)

* Panel B
xtreg BlockVol DID_initial DID_later L_lnMV PastRet4 L_Turnover Beta52 i.period_id if s_vol==1, fe vce(cluster firm_id)
lincom DID_later-DID_initial
xtreg BlockVol DID_initial DID_later i.period_id if s_vol==1, fe vce(cluster firm_id)
lincom DID_later-DID_initial
xtreg BlockDown DID_initial DID_later L_lnMV PastRet4 L_Turnover Beta52 i.period_id if s_down==1, fe vce(cluster firm_id)
lincom DID_later-DID_initial
xtreg BlockDown DID_initial DID_later i.period_id if s_down==1, fe vce(cluster firm_id)
lincom DID_later-DID_initial
xtreg BlockCrash DID_initial DID_later L_lnMV PastRet4 L_Turnover Beta52 L_Vol26 i.period_id if s_crash==1, fe vce(cluster firm_id)
lincom DID_later-DID_initial
xtreg BlockCrash DID_initial DID_later i.period_id if s_crash==1, fe vce(cluster firm_id)
lincom DID_later-DID_initial

* Panel C
xtreg BlockVol DID L_lnMV PastRet4 L_Turnover Beta52 i.period_id if s_vol==1 & no_transition==1, fe vce(cluster firm_id)
xtreg BlockVol DID i.period_id if s_vol==1 & no_transition==1, fe vce(cluster firm_id)
xtreg BlockDown DID L_lnMV PastRet4 L_Turnover Beta52 i.period_id if s_down==1 & no_transition==1, fe vce(cluster firm_id)
xtreg BlockDown DID i.period_id if s_down==1 & no_transition==1, fe vce(cluster firm_id)
xtreg BlockCrash DID L_lnMV PastRet4 L_Turnover Beta52 L_Vol26 i.period_id if s_crash==1 & no_transition==1, fe vce(cluster firm_id)
xtreg BlockCrash DID i.period_id if s_crash==1 & no_transition==1, fe vce(cluster firm_id)

* Panel D
reghdfe BlockVol DID L_lnMV PastRet4 L_Turnover Beta52 if s_vol_2way==1, absorb(firm_id period_id) vce(cluster firm_id period_id)
reghdfe BlockVol DID if s_vol_2way==1, absorb(firm_id period_id) vce(cluster firm_id period_id)
reghdfe BlockDown DID L_lnMV PastRet4 L_Turnover Beta52 if s_down_2way==1, absorb(firm_id period_id) vce(cluster firm_id period_id)
reghdfe BlockDown DID if s_down_2way==1, absorb(firm_id period_id) vce(cluster firm_id period_id)
reghdfe BlockCrash DID L_lnMV PastRet4 L_Turnover Beta52 L_Vol26 if s_crash_2way==1, absorb(firm_id period_id) vce(cluster firm_id period_id)
reghdfe BlockCrash DID if s_crash_2way==1, absorb(firm_id period_id) vce(cluster firm_id period_id)

* Downside coverage
xtreg BlockDown DID_initial DID_later i.period_id if s_down_coverage==1, fe vce(cluster firm_id)

* Table 7
version 17.0
clear all
set more off
use if data_type==4 using "github_data.dta", clear
xtset firm_id week_id

xtreg Wretwd Treat T_E T_M T_L1 T_L2 i.week_id, fe vce(cluster firm_id)
test T_E=T_L1
test T_E=T_L2
test T_L1=T_L2
test (T_L1=0) (T_L2=0)
xtreg AR Treat T_E T_M T_L1 T_L2 i.week_id, fe vce(cluster firm_id)
test T_E=T_L1
test T_E=T_L2
test T_L1=T_L2
test (T_L1=0) (T_L2=0)
xtreg AR Treat T_E T_M T_L1 T_L2 L_lnMV PastRet4 L_Turnover Beta52 i.week_id, fe vce(cluster firm_id)
test T_E=T_L1
test T_E=T_L2
test T_L1=T_L2
test (T_L1=0) (T_L2=0)
