# Assignment: ASSIGNMENT 4.1
# Name: Munjewar, Sheetal
# Date: 2023-01-08

## Load the ggplot2 package
library(ggplot2)
theme_set(theme_minimal())

## Set the working directory to the root of your DSC 520 directory
##setwd("/home/jdoe/Workspaces/dsc520")
setwd("E:\\Data_Science_DSC510\\DSC520-Statistics\\dsc520")

## Load the `data/r4ds/heights.csv` to
score_df <- read.csv("data/scores.csv")
head(score_df)
summary(score_df)
##-- factor(heights_df$sex)
##--To check the structure
str(score_df)

##-- Create one variable to hold a subset of your data set that contains 
##-- only the Regular Section and one variable for the Sports Section.

Sports_df <- score_df[ which( score_df$Section == "Sports"), ]
head(Sports_df)

Regular_df <- score_df[ which(score_df$Section == "Regular"),]
head(Regular_df)

##  Use the Plot function to plot each Sections scores and the number of students achieving that score. 
##  Use additional Plot Arguments to label the graph and give each axis an appropriate label. 
##  Once you have produced your Plots answer the following questions:

head(Sports_df)
str(Sports_df)
ggplot(data=Sports_df, aes(x=Score, y=Count)) + geom_line()
ggplot(data=Regular_df, aes(x=Score, y=Count)) + geom_line()

ggplot(data=Sports_df, aes(x=Score, y=Count)) + geom_point()
ggplot(data=Regular_df, aes(x=Score, y=Count)) + geom_point()

##-- Usin geom_line()
ggplot(data=Sports_df, aes(x=Score, group=1)) +
  geom_line(aes(y = Count, colour="Sport", size=12)) +
  geom_line(data=Regular_df, aes(y = Count, colour="Regular",size=12)) +
  scale_colour_manual("",
                    breaks = c("Sport", "Regular"),
                    values = c("darkblue", "darkred")) +
  xlab("Section") + ylab("Student Count")

##-- Usin geom_point()
ggplot(data=Sports_df, aes(x=Score, group=1)) +
  geom_point(aes(y = Count, colour="Sport", size=12)) +
  geom_point(data=Regular_df, aes(y = Count, colour="Regular",size=12)) +
  scale_colour_manual("",
                      breaks = c("Sport", "Regular"),
                      values = c("darkblue", "darkred")) +
  xlab("Section") + ylab("Student Count")


# Assignment :

#Use the appropriate R functions to answer the following questions:
#  What are the observational units in this study?
#  Answer - Students with scores and sections ( regular and Sports.)

#  Identify the variables mentioned in the narrative paragraph and determine which are categorical and quantitative?
#  Answer - Section ( Regular and Sport are categorical ), however student score and counts are quantitative.

#  Create one variable to hold a subset of your data set that contains only the Regular Section and one variable for the Sports Section.
#  Answer - Sports_df and Regular_df, Two separate variables are created to hold subset of data.

#Use the Plot function to plot each Sections scores and the number of students achieving that score. 
#Use additional Plot Arguments to label the graph and give each axis an appropriate label. 
#Once you have produced your Plots answer the following questions:

# Comparing and contrasting the point distributions between the two section, looking at both tendency and consistency: 
# Can you say that one section tended to score more points than the other? Justify and explain your answer.
# Answer -> Based on plotted graph, regular section student highlighted in "Red" consistently doing better than
#           than Sport Section.

# Did every student in one section score more points than every student in the other section? If not, 
# explain what a statistical tendency means in this context.
# Answer -> Not every student from sport section score less score compared to regular section, however from statistical 
#           prospective, regular section  students score are higher overall.

# What could be one additional variable that was not mentioned in the narrative that could be influencing the point 
# distributions between the two sections?
# Answer -> mean score and student counts.
  
  


  
  