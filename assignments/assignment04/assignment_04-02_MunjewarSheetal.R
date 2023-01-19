# Assignment: ASSIGNMENT 4.2
# Name: Munjewar, Sheetal
# Date: 2023-01-08



# Check your current working directory using `getwd()`
getwd()

# List the contents of the working directory with the `dir()` function
dir()

# If the current directory does not contain the `data` directory, set the
# working directory to project root folder (the folder should contain the `data` directory
# Use `setwd()` if needed
# setwd("E:\\Data_Science_DSC510\\DSC520-Statistics\\dsc520")
setwd("E:\\Data_Science_DSC510\\DSC520-Statistics\\dsc520")
score_df <- read.csv("data/scores.csv")
housing_df <- read.csv("data/week-7-housing.csv")

#score_df <- read.csv("data/scores.csv")
#summary(housing_df)
#head(housing_df)
#str(housing_df)


#-- Use the apply function on a variable in your dataset
# The R base manual tells you that it’s called as follows: apply(X, MARGIN, FUN, ...)
#
# where: Reference help
#  
# -> X is an array or a matrix if the dimension of the array is 2;
# -> MARGIN is a variable defining how the function is applied: when MARGIN=1, it applies over rows, whereas with MARGIN=2, it works over columns. Note that when you use the construct MARGIN=c(1,2), it applies to both rows and columns; and
# -> FUN, which is the function that you want to apply to the data. It can be any R function, including a User Defined Function (UDF).

##install.packages("dplyr")
library(dplyr)
library(ggplot2)

#score_df <- read.csv("data/scores.csv")
#head(score_df)
##?apply()

#- Get the distinct values.
# score_df %>% distinct(Section)
#-- List all distinct values
# score_df %>% distinct()

#- list top 5 and 15 rows.
#head(score_df, n=5)
#head(score_df, n=15)
#head(score_df$Section, n=15)
#head(score_df$Count, n=1)

#tail(score_df, n=5)
#tail(score_df, n=15)
#tail(score_df$Section, n=15)
#tail(score_df$Count, n=1)

#-Reference link - https://www.stat.cmu.edu/~ryantibs/statcomp/lectures/apply.html

apply(score_df,MARGIN=2,FUN=min)
apply(score_df,MARGIN=2,FUN=max)
apply(housing_df,MARGIN=2,FUN=min)
apply(housing_df,MARGIN=2,FUN=max)
#apply(housing_df,MARGIN=2,FUN=which.max)

#apply(housing_df,MARGIN=2,FUN=max)
#apply(housing_df,MARGIN=2,FUN=min)
#apply(housing_df,MARGIN=2,FUN=summary)

#-- Find mean for top 10 sale.price column.
test <- list(head(housing_df$Sale.Price,n=10))
str(test)
#lapply(test,FUN=mean)
#-- Function on entire list.
#lapply(housing_df,FUN=mean)
lapply(test,FUN=max)
lapply(test,FUN=summary)

# head(housing_df$Sale.Price,n=100)

#--For reference.
my.df = data.frame(nums=seq(0.1,0.6,by=0.1), chars=letters[1:6],bools=sample(c(TRUE,FALSE), 6, replace=TRUE))
my.df

my.list = list(nums=seq(0.1,0.6,by=0.1), chars=letters[1:12],bools=sample(c(TRUE,FALSE), 6, replace=TRUE))
my.list
str(my.list)


#-- Custom function.


##--------------- Aggregate Function() ------------------##

#-- reference https://www.geeksforgeeks.org/how-to-use-aggregate-function-in-r/

# aggregate sum of marks with subjects
list(score_df$Count)

##- ?aggregate()
#-- Working
aggregate(score_df$Score,list(score_df$Section),FUN=sum)
#aggregate(housing_df$zip5,list(housing_df$Sale.Price),FUN=sum)
#-- Working.
str(housing_df)
aggregate(housing_df$Sale.Price,list(housing_df$zip5),FUN=max)
aggregate(housing_df$Sale.Price,list(housing_df$zip5),FUN=min)
#aggregate(housing_df$Sale.Price,list(housing_df$zip5),FUN=sum)


##--------------- plyr function() ------------------##

##- Use the plyr function on a variable in your dataset – more specifically, 
##- I want to see you split some data, perform a modification to the data, 
##- and then bring it back together

#-- Compute New Variables.
hdf_2006 <- housing_df[housing_df["Sale.Price"] >= 500008,1:3]

dates <- as.POSIXct(housing_df$Sale.Date, format = "%m/%d/%Y")
years <- format(dates, format="%Y")
str(dates)
summary(dates)
class(dates)
str(housing_df)

head(years)
dates <- NULL
years <- NULL

#-- dplyr with filter.
housing_df %>% select(Sale.Price,Sale.Date) %>% filter(Sale.Price > 4000000)

#housing_df <- read.csv("data/week-7-housing.csv")
#str(housing_df)

#-- Derive new column using 
#housing_df <- read.csv("data/week-7-housing.csv")

#-- working dplyrwith with filter and functions.
housing_df %>% 
  filter(Sale.Price > 1000000) %>% 
  group_by(Sale.Date) %>% 
  summarize(average_revenue=mean(Sale.Price),sdev_revenue=sd(Sale.Price))

#housing_df <- read.csv("data/week-7-housing.csv")

##- Derive new column "Year" and add it to the existing data frame using pltr()
##-- Split Column, Operate on it to create and add new column called Year. 

#housing_df %>% 
#  mutate(year=format(as.Date(Sale.Date, format="%m/%d/%Y"),"%Y"))

#head(housing_df)

#-- Finding average sale price and its deviations for a given years with transaction 
#-- price limit more than a million.

housing_df %>% 
  filter(Sale.Price > 1000000) %>% 
  mutate(year=format(as.Date(Sale.Date, format="%m/%d/%Y"),"%Y")) %>% 
  group_by(year) %>% 
  summarize(average_sale_price=mean(Sale.Price),sdev_sale_price=sd(Sale.Price)) %>%
  arrange(desc(year))

#housing_df %>% 
#  mutate(Sale.month=format(as.Date(Sale.Date, format="%m/%d/%Y"),"%m"))

housing_df %>% 
  filter(Sale.Price > 1000000) %>% 
  mutate(monthyear = format(as.Date(Sale.Date, format="%m/%d/%Y"),"%m/%Y")) %>%
  group_by(monthyear) %>% 
  summarize(average_sale_price=mean(Sale.Price),sdev_sale_price=sd(Sale.Price)) %>%
  arrange(monthyear)


# housing_df$year <- NULL

#-----------------------------------#
#-- Variable declarations 
#-----------------------------------#
# split sales date column, derive month on it and attach back to the frame.

housing_df$year <- format(as.Date(housing_df$Sale.Date, format="%m/%d/%Y"),"%Y")
tail(housing_df)

# More examples.
housing_df$year <- format(mean(housing_df$Sale.Price))
housing_df$Zip <- housing_df$zip5 == "98052"
head(housing_df$Zip)

housing_df$million_above <- housing_df$Sale.Price >= 1000000
head(housing_df$million_above)

## ------------------------------------------------##
##-- Data distribution and outliers
## ------------------------------------------------##

#-- Data is Right skewed.
ggplot(housing_df, aes(housing_df$Sale.Price)) + geom_histogram(bins = 50)

#-- Outliers 
Mean_df <- housing_df %>% 
  filter(Sale.Price > 1000000) %>% 
  mutate(year = format(as.Date(Sale.Date, format="%m/%d/%Y"),"%Y")) %>%
  group_by(year) %>% 
  summarize(average_sale_price=mean(Sale.Price),sdev_sale_price=sd(Sale.Price)) %>%
  arrange(year)

head(Mean_df)
str(Mean_df)
#length(Mean_df$monthyear)

ggplot(Mean_df, aes(x = Mean_df$year, y = Mean_df$average_sale_price, label=Mean_df$year)) + 
  geom_point(size = 2.1, color="Blue") + 
  geom_line() + 
  ggtitle("Mean Sales Transaction Per Year") + 
  xlab("Year") +
  ylab("Sales Mean Prices") + 
##  geom_text() + 
  geom_errorbar(aes(ymin=Mean_df$average_sale_price - Mean_df$sdev_sale_price),
                    ymax=Mean_df$average_sale_price + Mean_df$sdev_sale_price,
                width=0.5 )



#-- Assignment Answers.

#-- Use the apply function on a variable in your dataset.
#-- Answer - Apply functions demonstrated in worksheet above.
#-- Use the aggregate function on a variable in your dataset.
#-- Answer - Aggregate,min,max and more defined in worksheet above
#-- Use the plyr function on a variable in your dataset – more specifically, I want to see you split some data, perform a modification to the data, and then bring it back together - Completed.
#-- Answer - Split sales.date column, create new year column from date column and add it into the dataframe using mutate in above work sheet.
#-- Check distributions of the data 
#-- Answer - Data is right skewed on  sales price.
#-- Identify if there are any outliers 
#-- Answer - Few outliers identified in plott graph for mean sales price with std. deviation.
#-- Create at least 2 new variables.
#-- Answer - Multiple variables are created in above worksheet.



