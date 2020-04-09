
library(forecast)
setwd("C:/ARIMA")
datos <-read.csv("C:/ARIMA/ARIMAProject.csv")
dato <-na.omit(datos)

v1 <- ts(dato$VARIABLE, start=c(1990), end=c(2015), frequency=1) #Assign the corresponding years
par(mfrow=c(2,2))
plot.ts(v1)
auto.arima(v1, test="adf",trace=TRUE) #The thest "adf" relates to Adjusted Dickey Fuller
acf(v1) #Plot correlogram (autocorrelations)
pacf(v1) #Plot partial correlogram
v1arima <- arima(v1, order=c(0,0,0))  #Assign the result values of AutoArima 
v1arima
v1forecast <- forecast.Arima(v1arima, h=20)
plot.forecast(v1forecast) #80% and 95% prediction intervals
dev.copy(jpeg,filename="v1.jpg");
dev.off ();

v2 <- ts(dato$VARIABLE, start=c(1990), end=c(2015), frequency=1) #Assign the corresponding years
par(mfrow=c(2,2))
plot.ts(v2)
auto.arima(v2, trace=TRUE) #No test "adf"
acf(v2) #Plot correlogram (autocorrelations)
pacf(v2) #Plot partial correlogram
v2arima <- arima(v2, order=c(0,0,0), include.mean = FALSE)  #Assign the result values of AutoArima 
v2arima
v2forecast <- forecast.Arima(v2arima, h=20)
plot.forecast(v2forecast) #80% and 95% prediction intervals
dev.copy(jpeg,filename="v2.jpg");
dev.off ();

v3 <- ts(datos$log_VARIABLE, start=c(1990), end=c(2015), frequency=1) #Assign the corresponding years
par(mfrow=c(2,2))
plot.ts(v3)
auto.arima(v3, test="adf", trace=TRUE) # Log values and the test "adf"
acf(v3) #Plot correlogram (autocorrelations)
pacf(v3) #Plot partial correlogram
v3arima <- arima(v3, order=c(0,0,1))  #Put the values of AutoArima (Note to self: Automatize)
v3arima
v3forecast <- forecast.Arima(v3arima, h=20)
plot.forecast(v3forecast) #80% and 95% prediction intervals
dev.copy(jpeg,filename="v3.jpg");
dev.off ();

results <- matrix(c(v1forecast["mean"]), nrow=38, ncol=1, byrow=FALSE)
write.csv(results, file = "ArimaProject.csv")
