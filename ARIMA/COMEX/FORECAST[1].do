destring tcr, replace dpcomma
destring bci, replace dpcomma
destring itc, replace dpcomma

tsset year

regress comex gdp_ch gdp_w /*Aprobado*/
regress comex gdp_ch gdp_w gdpcap_w /*Quiz�s*/
regress comex gdp_ch gdp_w gdpcap_w tcr bci itc lsci wmf/*Rechazado*/
regress comex gdp_ch gdp_w tcr /*Quiz�s*/
regress comex gdp_ch gdp_w bci /*Rechazado*/
regress comex gdp_ch gdp_w itc /*Rechazado*/
regress comex gdp_ch gdp_w lsci /*Quiz�s*/
regress comex gdp_ch gdp_w wmf /*Quiz�s*/

regress comex gdp_ch gdp_w lpi /*Quiz�s*/

corr gdp_ch gdp_w


varsoc comex gdp_ch
vecrank comex gdp_ch, trend(constant) lags(4) max
vec comex gdp_ch, trend(constant) lags(4)
predict ce1 if e(sample), ce equ(#1)
tsline ce1 if e(sample)
vecstable, graph
fcast compute ppp_, step(16)
fcast graph ppp_comex ppp_gdp_ch, observed 
outsheet using mydata.csv,c

