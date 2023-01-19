# Assignment: ASSIGNMENT 3.1
# Name: Munjewar, Sheetal
# Date: 2022-12-11

## Check your current working directory using `getwd()`
getwd()

## List the contents of the working directory with the `dir()` function
dir()

## If the current directory does not contain the `data` directory, set the
## working directory to project root folder (the folder should contain the `data` directory
## Use `setwd()` if needed
setwd("E:\\Data_Science_DSC510\\DSC520-Statistics\\dsc520")

## Load American Community Survey Exercise survey excel `data/acs-14-1yr-s0201.csv` to `acs_df` using `read.csv`
## Get summary for data frame 'acs_df'suing summary()`
acs_df <- read.csv("data/acs-14-1yr-s0201.csv")
summary(acs_df)

##Run the following functions and provide the results: str(); nrow(); ncol()
## Examine the structure of `acs_df` using `str()`
str(acs_df)
nrow(acs_df)
ncol(acs_df)

##  Create a Histogram of the HSDegree variable using the ggplot2 package.
##    1.  Set a bin size for the Histogram that you think best visuals the data (the bin size will determine 
##        how many bars display and how wide they are)
##    2.  Include a Title and appropriate X/Y axis labels on your Histogram Plot.

library(ggplot2)

ggplot(acs_df, aes(HSDegree)) + geom_histogram(bins = 50)
ggplot(acs_df, aes(HSDegree)) + geom_histogram(bins = 50) + ggtitle("ACS HSDegree Score Report") + xlab("HSDegree") + ylab("HeadCounts")  


## Answer the following questions based on the Histogram produced:
##   Based on what you see in this histogram, is the data distribution unimodal?
#    Answer- Plot is unimodal
##   Is it approximately symmetrical?
#    Answer- Plot is asymmetrical
##   Is it approximately bell-shaped?
#    Answer- Plot is relatively bell shaped
##   Is it approximately normal?
#    Answer- Plot is not relatively normal
##   If not normal, is the distribution skewed? If so, in which direction?
#    Answer- Plot is skewed left ( left skew or Negative skew )
##   Include a normal curve to the Histogram that you plotted.
#    Reference link : 
##      https://statisticsglobe.com/normal-density-curve-on-top-of-histogram-ggplot2-r
##      http://www.sthda.com/english/wiki/ggplot2-histogram-plot-quick-start-guide-r-software-and-data-visualization

     ggplot(acs_df, aes(HSDegree)) + geom_histogram(bins=30,binwidth=.5, aes(y=..density..), position="identity", alpha=0.5) + geom_density(alpha=0.6)

## Explain whether a normal distribution can accurately be used as a model for this data.
#   Answer -  Normal distribution properties expect symmetrical data distribution and majority of the data points
#             within the std. deviation, and data skewness must be zero. Plot drawn is relative to normal distribution 
#             but not be accurate.
   
     
#     Create a Probability Plot of the HSDegree variable.
     ggplot(acs_df, aes(sample = HSDegree)) +  stat_qq() + stat_qq_line() +  theme(legend.position="top")

     # reference - https://www.geeksforgeeks.org/normal-probability-plot/
     # reference - https://towardsdatascience.com/q-q-plots-explained-5aa8495426c0
#     Answer the following questions based on the Probability Plot:
#       1. Based on what you see in this probability plot, is the distribution approximately normal? Explain how you know.
#       Answer - Points plotted on the graph are not perfectly lies on a straight line to indicate distribution is not Normal.

#       2. If not normal, is the distribution skewed? If so, in which direction? Explain how you know.
#       Answer - Noticed more deviation at the Bottom end of the QQ plot from straight line, indicate longer tail towards left,
#                Left Skewed or Negatively Skewed.
     
#     Now that you have looked at this data visually for normality, 
#     you will now quantify normality with numbers using the stat.desc() function. 
#     Include a screen capture of the results produced.
      # Reference : https://stats.oarc.ucla.edu/r/faq/how-can-i-get-a-table-of-basic-descriptive-statistics-for-my-variables/
      library(pastecs)
      options(scipen=100)
      options(digits=2)
      
      #-kurtosis
      stat.desc(acs_df)
      stat.desc(acs_df$HSDegree, norm = TRUE) 
      
      #-- Finding z-scores
      zscore <- ( acs_df$HSDegree - mean(acs_df$HSDegree)) / sd(acs_df$HSDegree)
      zscore
      
      #stat.desc(acs_df, basic=F)
      #stat.desc(acs_df, desc=F)
      #data(acs_df)     
      #-kurtosis
      #stat.desc(acs_df$HSDegree, norm = TRUE)
      #or 
      #stat.desc(acs_df[,7], norm = TRUE)
 
      
           
#     In several sentences provide an explanation of the result produced for 
#     skew, kurtosis, and z-scores. In addition, explain how a change in the sample size may change your explanation?


#      Results and Explaination : 
#      
#      Plotted graph for the 2014 American Community Survey dataset is negatively skewed, 
#      Mode exceeds Mean and Median. visual observation shows the plot tailed at the left; 
#      even the probability QQ plot indicates more deviation at the bottom of the graph 
#      from a straight line. Another indicator using stat.desc() clearly show skewness negative value.
#      
#      Kurtesis measures the degree of peak ness of a frequency distribution, plot 
#      derived on HSDegree can be categorized as MesoKurtic and stat.desc() positive 
#      value indicates high peaks.
#      
#      z-score is the number of standard deviations a given data point lies above 
#      or below the mean, to get the z-score, mean and std deviation need to know 
#      for a given data point. z-score values derived using the below formula for 
#     HSDegree data point shows positive and negative values. Results of zero 
#      show the point and the mean equal,a result of the positive value indicates 
#      the deviation above the mean, and negative values indicate below the mean.
#      
#      zscore <- ( acs_df$HSDegree - mean(acs_df$HSDegree)) / sd(acs_df$HSDegree)
#      
#      Adding,subtracting, multiplying and dividing contant may not impact sample 
#      data, however addting new data points, will impact the balancing point i.e mean. 
#      In fact, adding a data point to the set, or taking one away, can effect 
#      the mean, median, and mode.
#      
#      example If we add a data point thatb