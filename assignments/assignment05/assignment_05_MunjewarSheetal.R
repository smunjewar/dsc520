# Assignment: ASSIGNMENT 5.0
# Name: Munjewar, Sheetal
# Date: 2023-01-15

# Sample data set to play around.
# https://www.jaredlander.com/datasets/

# Efficient way to install and load the packages.  
# Reference - https://statsandr.com/blog/an-efficient-way-to-install-and-load-r-packages/
# Free dataset : https://blog.journeyofanalytics.com/50-free-datasets-for-data-science-projects/


# Check your current working directory using `getwd()`
getwd()

# List the contents of the working directory with the `dir()` function
dir()

# If the current directory does not contain the `data` directory, set the
# working directory to project root folder (the folder should contain the `data` directory
# Use `setwd()` if needed
# setwd("E:\\Data_Science_DSC510\\DSC520-Statistics\\dsc520")
setwd("E:\\Data_Science_DSC510\\DSC520-Statistics\\dsc520")
housing_df <- read.csv("data/week-7-housing.csv")
head(housing_df)
# Package names
# packages <- c("ggplot2","dplyr","tidyr","magrittr","tidyverse","purrr")
packages <- c("ggplot2","dplyr","magrittr","tidyverse","purrr")

# Install packages not yet installed
installed_packages <- packages %in% rownames(installed.packages())
if (any(installed_packages == FALSE)) {
  install.packages(packages[!installed_packages])
}

# Packages loading
invisible(lapply(packages, library, character.only = TRUE))

# Column 1 to 3 with sales price > 500000
hdf_2006 <- housing_df[housing_df["Sale.Price"] >= 500008,1:3]
head(hdf_2006)

#------------------------------------------------------------------------------
# Assignment-01 : 
# Using the dplyr package, use the 6 different operations to analyze/transform 
# the data - GroupBy, Summarize, Mutate, Filter, Select, and Arrange – Remember 
# this isn’t just modifying data, you are learning about your data also – 
# so play around and start to understand your dataset in more detail.
#------------------------------------------------------------------------------

# Select examples 
str(housing_df)
housing_df %>% select(1,3) %>% tail()
housing_df %>% select(Sale.Date,Sale.Price,sale_warning) %>% tail()
housing_df %>% select(c(Sale.Date,Sale.Price)) %>% head() 
# Columns starts and end with 'S' or 's' -Not case sensitive.
housing_df %>% select(starts_with('s')) %>% head() 
housing_df %>% select(ends_with('s')) %>% head() 
housing_df %>% select(contains('sale')) %>% head() 
housing_df %>% select(matches('s.+l')) %>% head() 
housing_df %>% select(-1,-2) %>% head() 

# filter examples 

housing_df %>% filter(bath_full_count==2) %>% head()
housing_df %>% filter(year_built == 2003) %>% head()
housing_df %>% filter(year_built == 2003 & bath_full_count == 2 ) %>% head()
housing_df %>% filter(zip5 == 98052 & bath_full_count == 2 & Sale.Price > 500000 ) %>% head()
housing_df %>% filter((zip5 == 98052 | zip5 == 98053) & bath_full_count == 2 & Sale.Price > 500000 ) %>% head(.,n=50)
county = "REDMOND"
#housing_df %>% filter_(~ctyname == county)

# housing_df%>% head(,n=50)

# Get distinct values from zip5 column.
distinct(housing_df,zip5)
distinct(housing_df,bedrooms)
distinct(housing_df,ctyname)
distinct(housing_df,current_zoning)
distinct(housing_df,housing_df$sale_reason)  #-- How to check for group_by with count. 
distinct(housing_df,ctyname,.keep_all = TRUE)
# List top 50 blank values in column ctyname
housing_df %>% filter(ctyname=="") %>% head(.,n=50)
# find NULL/NA values in a entire DF 
is.na(housing_df) %>% head()

summary(housing_df)
str(housing_df)


housing_df %>% 
  filter(zip5 == 98074 | zip5 == 98059 ) %>% 
  mutate(year = format(as.Date(Sale.Date, format="%m/%d/%Y"),"%Y")) %>%
  mutate(month = format(as.Date(Sale.Date, format="%m/%d/%Y"),"%m")) %>%
  group_by(year,month) %>% 
  summarize(average_sale_price=max(Sale.Price),sdev_sale_price=sd(Sale.Price)) %>%
  arrange(year)

# Number of iteration count per value.
housing_df %>% count(sale_reason)

# Report for all transactions with sales_reason 1 for all bedrooms, to understand market demand over the years 
# will summarize min/max/mean/sd on yearly basic.

housing_df %>% 
  filter( sale_reason == 1 ) %>% 
  mutate(year = format(as.Date(Sale.Date, format="%m/%d/%Y"),"%Y")) %>%
  group_by(year,bedrooms) %>% 
  summarize(average_sale_price=mean(Sale.Price),sdev_sale_price=sd(Sale.Price),max_sale_price=max(Sale.Price),min_sale_price=min(Sale.Price)) %>%
  arrange(year,bedrooms) %>%  print(n=100)

# Report for all transactions with sales_reason 18 and 2 BHK, to understand 2BKH market trend
# will summarize min/max/mean/sd on yearly basic.

housing_df %>% 
  filter( sale_reason == 18 & bedrooms == 2 ) %>% 
  mutate(year = format(as.Date(Sale.Date, format="%m/%d/%Y"),"%Y")) %>%
  group_by(year,bedrooms) %>% 
  summarize(average_sale_price=mean(Sale.Price),sdev_sale_price=sd(Sale.Price),max_sale_price=max(Sale.Price),min_sale_price=min(Sale.Price)) %>%
  arrange(year,bedrooms) %>%  print(n=100)

# -------------------------------------------------------------
# Assignment 02 - Using the purrr package – perform 2 functions on your dataset.  
# -------------------------------------------------------------
# you could use zip_n, keep, discard, compact, etc.
# Reference link - https://www.r-bloggers.com/2020/05/one-stop-tutorial-on-purrr-package-in-r/
# Reference link - https://hookedondata.org/posts/2019-01-09_going-off-the-map-exploring-purrrs-other-functions/

# The easiest way - install the tidyverse
# install.packages("tidyverse")
# Install just purrr
# install.packages("purrr"

# map() – Use if you want to apply a function to each element of the list or a vector.
# map2() – Use if you’re going to apply a function to a pair of elements from two different lists or vectors.
# pmap() – Use if you need to apply a function to a group of elements from a list of lists.

# Converting sq feet to sq meter.
sq_meter <- function(x){
  return(x/10.764)
}
# Create a vector of number
sq_meter_vector1 <- housing_df %>% select(square_feet_total_living) %>% head()
head(sq_meter_vector1)
# Using map() function to generate squares
map(sq_meter_vector1, sq_meter)                   #-- Shortan the result.
#str(housing_df)

# without function example.
v1 <- housing_df %>% select(square_feet_total_living) %>% head()
v2 <- housing_df %>% select(zip5) %>% head()
head(v1)
head(v2)
map2(v1, v2, ~ .x + .y)

# keep() – A handy function, as the same suggests, using this function, 
# we can observe only those elements in the list which pass a logic
ls2 <- list(23, 12, 14, 7, 2, 0, 24, 98)
keep(ls2, function(x) x > 5)

sales_v1 <- housing_df %>% select(Sale.Price) %>% head() 
#sales_v1
sales_v1 %>% keep(function(x) mean(x) > 400000)

# discard() – The function drops those values which fail to pass the logical tests. 
# Say we want to drop NA values then you can use is.na()to discard observations which are represented NA in the list.

ls3 <- list(23, NA, 14, 7, NA, NA, 24, 98)
discard(ls3, is.na)

# compact() – A simple, straightforward function that drops all the NULL values present in the list. 
# Please do not confuse NA values with that of NULL values. These are two different types in R.

ls4 <- list(23, NULL, NA, 34)
compact(ls4)

# -------------------------------------------------------------
# Assignment - Use the tibble,cbind and rbind function on your dataset
# Joins reference - https://www.datasciencemadesimple.com/join-in-r-merge-in-r/
# Join assignments left_join,right_join,inner_join,full_join,semi_join,anti_join() 
# -------------------------------------------------------------
hvector_01 <- housing_df %>% select(Sale.Date,Sale.Price,square_feet_total_living,zip5)
hvector_02 <- housing_df %>% select(Sale.Date,bedrooms,year_built,year_renovated,current_zoning,sq_ft_lot) 
head(hvector_01)
str(hvector_02)
# cbind()
hvector_col <- cbind(hvector_01,hvector_02)
str(hvector_col)
head(hvector_col)
# tibble()
hvector_01 <- tibble(housing_df %>% select(Sale.Date,Sale.Price,square_feet_total_living,zip5))
hvector_02 <- tibble(housing_df %>% select(Sale.Date,bedrooms,year_built,year_renovated,current_zoning,sq_ft_lot))
hvector_col <- cbind(hvector_01,hvector_02)
str(hvector_col)
head(hvector_col)

# for rbind rows and cols must be same.
# hvector_row <- rbind(hvector_01,hvector_02)
# str(hvector_row)
# head(hvector_row)

# Joins 
hvector_01 <- housing_df %>% select(Sale.Date,Sale.Price,square_feet_total_living,zip5) %>% filter(zip5==98074)
hvector_02 <- housing_df %>% select(Sale.Date,bedrooms,year_built,year_renovated,current_zoning,sq_ft_lot) 

# Get unique values from column.
unique(hvector_col$zip5)

# Join assignments left_join,right_join,inner_join,full_join,semi_join,anti_join() 
# https://www.datasciencemadesimple.com/join-in-r-merge-in-r/

left_join(hvector_01,hvector_02, by=c("Sale.Date" = "Sale.Date")) %>% nrow 
right_join(hvector_01,hvector_02, by=c("Sale.Date" = "Sale.Date")) %>% nrow 
inner_join(hvector_01,hvector_02, by=c("Sale.Date" = "Sale.Date")) %>% nrow 
anti_join(hvector_01,hvector_02, by=c("Sale.Date" = "Sale.Date")) %>% nrow 
semi_join(hvector_01,hvector_02, by=c("Sale.Date" = "Sale.Date")) %>% nrow 

left_join(hvector_01,hvector_02, by=c("Sale.Date" = "Sale.Date")) %>% 
  distinct(zip5) %>% 
  head()
right_join(hvector_01,hvector_02, by=c("Sale.Date" = "Sale.Date")) %>% 
  distinct(zip5,current_zoning,year_built) %>% 
  head()
inner_join(hvector_01,hvector_02, by=c("Sale.Date" = "Sale.Date")) %>% 
  distinct(zip5) %>% 
  head()
anti_join(hvector_01,hvector_02, by=c("Sale.Date" = "Sale.Date")) %>% 
  distinct(zip5) %>% 
  head()
semi_join(hvector_01,hvector_02, by=c("Sale.Date" = "Sale.Date")) %>% 
  distinct(zip5,square_feet_total_living,Sale.Price) %>% 
  head()

# -------------------------------------------------------------
# Assignment - Split a string, then concatenate the results back together
# -------------------------------------------------------------

paste("Hello","Funny R ","World !!!")
# housing_df %>% paste(housing_df$addr_full, sep = " ") %>% head()
paste(housing_df$addr_full, sep = " ") %>% head(.,n=20)

# sprintf
lang <- "R"
course <- "DSC-520" 
sprintf(" %s : Statistics for Data Science, using %s studio !! ",course,lang)

# str_split
Address <- str_split(housing_df$addr_full, pattern = " ") %>% head() 
str(Address)

# str_sub
unique(housing_df$year_renovated)
# housing_df %>% select(Sale.Date,Sale.Price,year_built,year_renovated,addr_full) %>% 
str_sub(string = housing_df$year_renovated, start=1, end=4) %>% head(.,n=100)
test_df <- housing_df %>% select(Sale.Date,Sale.Price,year_built,year_renovated,addr_full)
test_df[str_sub(string=housing_df$year_renovated, start=1, end=5) == 2006, c("Sale.Date","Sale.Price","year_built","year_renovated","addr_full")]
test_2006 <- test_df[str_sub(string=housing_df$year_renovated, start=1, end=5) == 2006, c("Sale.Date","Sale.Price","year_built","year_renovated","addr_full")]
str(test_2006)

# str_detect
# Get distinct count for each value in the column.
housing_df %>% count(year_renovated)
test_df <- housing_df %>% select(Sale.Date,Sale.Price,year_built,year_renovated,addr_full)
test_df[str_detect(string=housing_df$year_renovated, pattern = "2007"), c("Sale.Date","Sale.Price","year_built","year_renovated","addr_full")]

# str_replace
test_df <- housing_df %>% select(Sale.Date,Sale.Price,year_built,year_renovated,addr_full)
str_replace(housing_df$addr_full,"NE","Nebraska") %>% head()


