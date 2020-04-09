destring var_pernoc, replace dpcomma
destring log_pib_r, replace dpcomma
destring log_pernoc, replace dpcomma


regress pernoc pib_r
regress log_pernoc log_pib_r
predict Resid, residual
dfuller Resid
line residual year, title(Residuals vs. year)



