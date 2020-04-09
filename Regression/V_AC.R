#install.packages("")
library(forecast)


setwd("C:/ARIMA/V_AC")

Data <- read.csv("DATA.csv")
attach(Data)
#detach(Data)


year <- ts(Year, start=c(2000), end=c(2016), frequency=1)
gdp_n <- ts(GDP_N, start=c(2000), end=c(2016), frequency=1)
gdp_r <- ts(GDP_R, start=c(2000), end=c(2016), frequency=1)
transf <- ts(TRANSF, start=c(2000), end=c(2016), frequency=1)
expo <- ts(Expo, start=c(2005), end=c(2016), frequency=1)
tc <- ts(TC, start=c(2000), end=c(2016), frequency=1)
event_dummy <- ts(Dummy, start=c(2000), end=c(2016), frequency=1)
incr <-ts(c(0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1), start=c(2000), end=c(2016), frequency=1) #2010
COS <- ts(COS, start=c(2000), end=c(2016), frequency=1)


ln_trans <- log(transf)
ln_cos <- log(COS)
ln_pib_n <- log(gdp_n)
ln_pib_r <- log(gdp_r)


library(tseries)


#adf.test ; p>0.05 there is a unitary root

#adf.test(cosechaXI)
#par(mfrow=c(1,2))
#acf(cosechaXI)
#pacf(cosechaXI)

adf.test(ln_cos)
acf(ln_cos)
pacf(ln_cos)

adf.test(ln_pib_n)
acf(ln_pib_n)
pacf(ln_pib_n)

Reg <- lm(ln_cos~ln_pib_n)
summary(Reg)
residual <-resid(Reg)
adf.test(residual)


#No cointegration found

#ARIMA estimation

auto.arima(COS, test="adf")
par(mfrow=c(2,2))
acf(COS)
pacf(COS)
arima_cos <- arima(COS, order=c(0,2,0))
arima_cos
#plot(COS)
#lines(fitted(arima_cos), col="red")
plot(resid(arima_cos))
cos_forecast <- forecast(arima_cos, h=20)
cos_forecast
results_cos <- matrix(c(cos_forecast["mean"]), nrow=1, ncol=1, byrow=FALSE)
write.csv(results_cos, file = "ArimaCOS.csv")



auto.arima(ln_cos, test="adf")
par(mfrow=c(2,2))
acf(ln_cos)
pacf(ln_cos)
arima_ln_cos <- arima(ln_cos, order=c(0,2,1))
arima_ln_cos
#plot(cosechaXI)
#lines(fitted(arima_cos), col="red")
plot(resid(arima_ln_cos))
ln_cos_forecast <- forecast(arima_ln_cos, h=21)
ln_cos_forecast
results_ln_cos <- matrix(c(ln_cos_forecast["mean"]), nrow=1, ncol=1, byrow=FALSE)
write.csv(results_ln_cos, file = "ArimaLnCos.csv")


#Include the event as dummy
auto.arima(ln_cos, test="adf", xreg=incr)
par(mfrow=c(2,2))
acf(ln_cos)
pacf(ln_cos)
arima_ln_cos1 <- arima(ln_cos, order=c(0,2,1), xreg=incr)
arima_ln_cos1
plot(ln_cos)
lines(fitted(arima_ln_cos1), col="red")
plot(resid(arima_ln_cos1))
Dummy<-c(1:21)-c(0:20)
ln_cos_forecast1 <- forecast(arima_ln_cos1,h=21, xreg=Dummy)
ln_cos_forecast1
results_ln_cos1 <- matrix(c(ln_cos_forecast1["mean"]), nrow=1, ncol=1, byrow=FALSE)
write.csv(results_ln_cos1, file = "ArimaLnCos1.csv")


