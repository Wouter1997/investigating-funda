dataset_housemarket <- read.csv("../../gen/analysis/input/final_dataset_housemarket.csv")

options(scipen=999)
#scatterplot
scatter.smooth(x=dataset_housemarket$price, y=dataset_housemarket$sellingduration, main= "price ~  sellingduration")

#plot eindhoven
eindhoven <- dataset_housemarket[dataset_housemarket$city == "eindhoven", ]
scatter.smooth(eindhoven$price, y= eindhoven$sellingduration, main= "price ~  sellingduration Eindhoven ")

#check for outliers
par(mfrow=c(1, 2))  # divide graph area in 2 columns
boxplot(dataset_housemarket$price, main="price", sub=paste("Outlier rows: ", boxplot.stats(dataset_housemarket$price)$out))  # box plot for 'price'
boxplot(dataset_housemarket$sellingduration, main="duration", sub=paste("Outlier rows: ", boxplot.stats(dataset_housemarket$sellingduration)$out))  # box plot for 'duration'

#correlation
cor(dataset_housemarket$sellingduration, dataset_housemarket$price ) #weak positive correlation for sellingduration & price 
cor(dataset_housemarket$sellingduration, dataset_housemarket$constructionyear) #very weak positive correlation (exclude from lm)
#linear model

linearMod <- lm(sellingduration ~ price, data=dataset_housemarket)
print(linearMod)

#check significance
modelSummary <- summary(linearMod)  # capture model summary as an object
modelCoeffs <- modelSummary$coefficients  # model coefficients
beta.estimate <- modelCoeffs["price", "Estimate"]  # get beta estimate for price
std.error <- modelCoeffs["price", "Std. Error"]  # get std.error for price
t_value <- beta.estimate/std.error  # calc t statistic
p_value <- 2*pt(-abs(t_value), df=nrow(dataset_housemarket)-ncol(dataset_housemarket))  # calc p Value
f_statistic <- linearMod$fstatistic[1]  # fstatistic
f <- summary(linearMod)$fstatistic  # parameters for model p-value calc
model_p <- pf(f[1], f[2], f[3], lower=FALSE)

#create df
concepts <- c("p value", "std.error", "intercept", "beta_price")
values <- c(p_value, std.error, linearMod$coefficients[1], linearMod$coefficients[2])
df <- data.frame(concepts, values)


write.csv(df, '../../gen/analysis/output/Linearregression.csv')

