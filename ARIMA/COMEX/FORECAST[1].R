library(forecast)

attach(FORECAST)

exp <- ts(Exp, start=c(1995), end=c(2014), frequency=1)
imp <- ts(Imp, start=c(1995), end=c(2014), frequency=1)
emb <- ts(Emb, start=c(1995), end=c(2014), frequency=1)
des <- ts(Des, start=c(1995), end=c(2014), frequency=1)
tra <- ts(Tra, start=c(1995), end=c(2014), frequency=1)
total <- ts(TOTAL, start=c(1995), end=c(2014), frequency=1)
comex <- ts(COMEX, start=c(1995), end=c(2014), frequency=1)
gdp_ch <- ts(GDP_CH, start=c(1996), end=c(2014), frequency=1)
gdp_w <- ts(GDP_W, start=c(1995), end=c(2014), frequency=1)
gdp.cap_ch <- ts(GDP.Cap_CH, start=c(1995), end=c(2014), frequency=1)
gdp.cap_w <- ts(GDP.Cap_W, start=c(1995), end=c(2014), frequency=1)
tcr <- ts(TCR, start=c(1995), end=c(2014), frequency=1)
bci <- ts(BCI, start=c(2003), end=c(2014), frequency=1)
itc <- ts(ITC, start=c(1995), end=c(2014), frequency=1)
lsci <- ts(LSCI, start=c(2004), end=c(2014), frequency=1)
wmf <- ts(WMF, start=c(1995), end=c(2014), frequency=1)




par(mfrow=c(2,2))
plot.ts(comex)
auto.arima(comex, test="adf", trace=TRUE)
acf(comex) #Plot correlogram (autocorrelations)
pacf(comex) #Plot partial correlogram
comexarima <- arima(comex, order=c(0,2,1))
comexarima
comexforecast <- forecast.Arima(comexarima, h=16)
comexforecast
plot.forecast(comexforecast) #80% and 95% prediction intervals
dev.copy(jpeg,filename="arimacomex.jpg");
dev.off ();

resultados <- matrix(c(comexforecast["mean"]), nrow=1, ncol=1, byrow=FALSE)
write.csv(resultados, file = "ArimaComex.csv")






