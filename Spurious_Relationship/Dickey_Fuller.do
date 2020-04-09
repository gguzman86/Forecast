destring var1, replace dpcomma
destring log_var2, replace dpcomma
destring log_var1, replace dpcomma


regress var1 var2
regress log_var1 log_var2
predict Resid, residual
dfuller Resid
line residual year, title(Residuals vs year)



