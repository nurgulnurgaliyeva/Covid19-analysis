#----------Section-01--Adding Libraries--------#
# Load libraries here
# Load required libraries
library(ggplot2)
library(ppcor)
library(car)
library(RcmdrMisc)
library(corrplot)
library(corrgram)
library(Amelia)
library(rcompanion)
library(psych)


#----------Section-02--Set & Get Work Directory--------#
# setting working directory
# Before processing any work or test in using R Script,
# setting the directory for get the data source and even save graphs and plots.
setwd(dirname(file.choose()))
# Getting the path directory to confirm the working directory.
getwd()

#----------Section-03--Data Set and Data Set--------#
# Reading the data from csv file and putting it into new data-frame.
Covid19.Data <- read.csv("CleanedData.csv", stringsAsFactors = FALSE)
# To inspect top 6 rows of the data and variable head for general view of data-set.
head(Covid19.Data)
# To overview of data-frame having number of objects of number of variables.
str(Covid19.Data)
# Attaching the CSV data 'Covid19.Data' for working in R faster
attach(Covid19.Data)

#----------Section-04--Missing Data--------#
# The data set might have some missing values,
# checking for missing data in the entire data-set.
missing_data <- Covid19.Data
# Displaying the missing data summary so it can give an proper results.
apply(missing_data, MARGIN = 2, FUN = function(x) sum(is.na(x)))
# Mapping up missing values by column
png(file="png/Missingness Map.png",width = 640, height = 480)
missmap(missing_data, col = c("blue", "beige"), legend = TRUE, main = "Missingness Map")
dev.off()
# However, to remove variables or data from work space or environment in R.
rm(missing_data)
# Summary for getting Mean, Std. deviation, Maximum and Minimum to check the central tendency.
# These statistics can be useful for understanding the central tendency and variability of the data distribution in each category within the dataset.
# The summary from the data-set can be parametric or non parametric 
summary(Covid19.Data)


#----------Section-05--Boxplot, Histogram, & Q-Q Plot---------#
# Step 1: Boxplot, histogram and Q-Q Plot for dependent variable

# Boxplot: A boxplot provides a clear visual summary of the distribution of the dependent variable. 
# It shows the median, quartiles, and potential outliers, which helps to understand the central tendency and spread of the data.
png(file="png/TotalDeath_Boxplot.png", width=640, height=480)
boxplot (Covid19.Data$TotalDeath, main="Boxplot of Covid-19 Deaths")


# Histogram: Histogram for dependent variable
# A histogram provides a visual representation of the distribution of the dependent variable. 
# It allows us to observe the shape, central tendency, and spread of the data.
# Histogram 1.1 With frequency.
png(file="png/TotalDeath_Histogram_Frequency.png", width=640, height=480)
hist(TotalDeath, col = "light blue", border = "dark blue", freq = T, ylim = c(0,100),
     xlab = "Per Thousand TotalDeath", main = "Histogram of TotalDeath")
# Add a rug plot
rug (TotalDeath)
dev.off()

# Histogram 1.2 With density.
# Probability density histogram a continuous version of the histogram with densities,
# specifies how the probability density is distributed over the range of values.
png(file="png/TotalDeath_Histogram_Density.png", width=640, height=480)
hist(TotalDeath, col = "light blue", border = "dark blue", freq = F, ylim = c(0,1),
     xlab = "Per Thousand TotalDeath", main = "Histogram of TotalDeath")
# Add a rug plot
rug (TotalDeath)
# Add a density curve
lines (density(sort(TotalDeath)))
# Add a Normal curve
xfit <- seq(from = min(TotalDeath), to = max(TotalDeath), by = 0.1)
yfit = dnorm(xfit, mean(TotalDeath), sd(TotalDeath))
lines(xfit, yfit, lty = "dotted")
# Add a legend
legend("topright", legend = c("Density curve", "Normal curve"),
       lty = c("solid", "dotted"), cex = 2)
dev.off()
# Remove unnecessary objects from environment.
rm(xfit, yfit)

# Histogram 1.3 Histogram with approximation normal.
png(file="TotalDeath_Histogram_Approx_Normal.png", width=640, height=480)
plotNormalHistogram(TotalDeath, xlab = "Per Thousand TotalDeath", main = "Histogram of TotalDeath")
dev.off()

# Q-Q Plot: Q-Q Plot for dependent variable
# Checking the normality of the dependent variable
# Providing insights into the distributional characteristics that can influence subsequent statistical analyses. 
# Deciding to guide decisions on data transformations and the choice of appropriate statistical tests.
png(file="png/TotalDeath_Q_Q_Plot.png", width=640, height=480)
qqnorm(TotalDeath, main = "Q-Q plot of TotalDeath", xlab = "Theoretical Quantiles TotalDeath",
       ylab = "Per Thousand TotalDeath")
qqline(TotalDeath,col = c("red"))
dev.off()

#----------Section 06----------#
# Step 2: Kolmogorov-Smirnov Tests of normality
# conducting a one-sample Kolmogorov-Smirnov (K-S) test 
# for normality on the variable TotalDeath within the dataset Covid19.Data
ks.test(Covid19.Data$TotalDeath, "pnorm", mean=mean(Covid19.Data$TotalDeath), sd=sd(Covid19.Data$TotalDeath))


#-----Section-07-Boxplot & Histogram of Independent Variables-----
# Step 3: boxplot for few selected independent variable
# The group of variable dataset having different scale and some of the variables
# looks like they have normal distribution of data with outliers and skewness.
# boxplot for few selected independent variable
# The group of variable dataset having different scale and some of the variables
# looks like they have normal distribution of data with outliers and skewness.
# The group of boxplot in the same scale shows that, we can perform more test
# using dependent variable as covid deaths to independent variables. So, there
# might be a significant difference in dataset where it is possible that some
# variables have high correlations and proves the reason of more or less death
# effects. After performing test we can prove the hypothesis testing on each variables.

# Boxplot for Health variable
png(file="png/BoxplotOfHealthVariable.png", width=640, height=480)
boxplot(GoodHealth, BadHealth, FairHealth, 
        names=c("GoodHealth", "BadHealth", "FairHealth"),
        xlab="Variables", ylab="Count", las = 1, cex.axis = 0.5)
dev.off()

# Boxplot for	Passport Held variable
png(file="png/BoxplotOfPassportHeldVariable.png", width=640, height=480)
boxplot(NoPassport, UKPassport, 
        names=c("NoPassport", "UKPassport"),
        xlab="Variables", ylab="Count", las = 1, cex.axis = 0.5)
dev.off()


#-----Section-08-Parametric Statistical Tests-----
# Step 4: Pearson Correlation Coefficients between Dependent and Independent Variables
# Calculate and list all correlation coefficients between the dependent variable TotalDeath
# and the independent variables (Age, Employment, Health, LengthOfResidence, TravelMethodToWork, PassportHeld, , Population).
# The resulting correlation value will range between -1 and 1.
# A value of 1 indicates a perfect positive correlation.
# A value of -1 indicates a perfect negative correlation.
# A value of 0 indicates no correlation.
# Pearson correlation is appropriate for linear relationships between variables.
# It measures the strength and direction of a linear relationship.
correlation_matrix <- cor(Covid19.Data[,3:24],method = "pearson")
# print(correlation_matrix)
png(file="png/CorrelationMatrix.png", width=1080, height=640)
corrgram(correlation_matrix, order = FALSE, cor.method = "pearson", lower.panel = panel.cor,
         upper.panel = panel.pie, text.panel = panel.txt, main = "Correlation Matrix",
         cex.labels = 1, mar = c(1,1,1,1))
dev.off()
rm(correlation_matrix)

# Selecting Strong Correlation Variables
correlation_matrix_strong <- Covid19.Data[,c(4,9,10,11,13,15,23)]
png(file="png/StrongCorrelationVariablesMatrix.png", width=640, height=480)
cor_m_d <- cor(correlation_matrix_strong, method = "pearson")
corrplot(cor_m_d, type = "upper", tl.col = "black", tl.srt = 45,
         main = "Strong Correlation Variables Matrix", mar = c(1,1,1,1))
# print(cor_m_d)
dev.off()
rm(cor_m_d)



# Step 5: Kaiser-Meyer-Olkin (KMO) test with Strong Correlation Variables
# KMO Test
kmo_result <- KMO(cor(correlation_matrix_strong, method = "pearson"))
print(kmo_result)
rm(kmo_result)


#-----Section-9-Regression Modeling-----
# Step 6: Regression Modelling
# We use the lm() function to fit a linear regression model.
# The formula specifies the relationship between the dependent variable (TotalDeath)
# and independent variables (Age, Employment, Health).
reg_model <- lm(TotalDeath ~ ChildAge + Part_Time_Job + Full_Time_Job + Self_Employment + Retired + FairHealth + UKPassport,
                data = Covid19.Data)

# Display the summary of the regression model
summary(reg_model)
rm(reg_model)


# detach the data frame from environment
detach(Covid19.Data)
# remove all variables from the environment
rm(list=ls())
# remove all plots or graphs
dev.off()

