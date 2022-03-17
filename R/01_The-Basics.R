
# MISA - How To Learn R ---------------------------------------------------

# https://www.r-bloggers.com/how-to-learn-r-2/

# 01_The Basics ------------------------------------------------------------------

# R as a Calculator
1 + 1
1 + 2^2
1 + (2*3)

# Store Objects - use this to call later on in script
x <- 4
y <- 6
z <- x + y

# Functions - if doing same tasks over and over make it a function

fun1 <- function(x) {
  x * 10
}

fun2 <- function(x) {
  ifelse (x < 3, "Low", "High")
}

fun1(x)
fun2 (y)

# Vectors and Data Types

vec1 <- c ("a", "b", "c", "d", "e") # String/Character
vec2 <- c (1,2,3,4,5) # Numeric

# Apply functions to vectors as well
vec2
fun1(vec2)

vec2
fun2(vec2)

# New function
fun3 <- function(x){
  ifelse (x =="a", "A",
          ifelse (x == "b", "A", "B")
  )
}

vec1
fun3 (vec1)

# Factors - numeric assignment to nominal variable

gender <- c ("Male", "Male", "Female", "Male", "Female")
str(gender)

gender <- factor (gender) # Now "Male" and "Female" are represented by numbers
str(gender)
levels (gender)

as.numeric(gender)

# Change the order of the factors
gender <- factor (gender,
                  levels = c("Male", "Female"))
levels (gender)
as.numeric(gender)

# Packages ----------------------------------------------------------------
# http://www.tidyverse.org

library(tidyverse)
# Bundle of many functions that make data wrangling much easier than Base R
# E.g. read.csv (base) and read_csv (tidyverse) both read a .csv file.
# read.csv converts characters to text by default, read_csv keeps as characters
# read_csv is faster than read.csv.
# tidyverse has chaining to allow multiple tasks in logical sequence and easy readability
# This of %>% as "then"

# Speed Test:

# install.packages("tictoc")
library(tictoc)

# Base
tic()
parking <- read.csv ("https://raw.githubusercontent.com/grousell/MISAR/master/Data/parking_data_all.csv",
                 stringsAsFactors = FALSE) %>%
  head(5000) # Selects first 5000 rows
toc()

# Tidyverse
tic()
parking <- read_csv ("https://raw.githubusercontent.com/grousell/MISAR/master/Data/parking_data_all.csv") %>% #then
  head(5000) # Selects first 5000 rows
toc()

# Base R vs Tidyverse

new_parking_base <- parking[which(parking$location1 == "OPP" & parking$infraction_code == 406),
                       c("tag_number_masked","date_of_infraction", "infraction_description","location2" )]


new_parking_tidy <- parking %>%
  dplyr::filter (location1 == "OPP" & infraction_code == 406) %>%
  select (tag_number_masked, date_of_infraction, infraction_description, location2)


# Import Data -------------------------------------------------------------

# SPSS
library(foreign) # Foreign package will read in SPSS and .dbf files
df2 <- read.spss("file.sav")

# .dbf files, from GIS

df3 <- read.dbf ("file.dbf",
                 as.is = TRUE) # Keeps as character vs. factors


# Survey Data -------------------------------------------------------------
# May have extraneous columns, or names may be too long.
survey <- read_csv("https://raw.githubusercontent.com/grousell/MISAR/master/Data/survey_data_1.csv")
glimpse(survey)

# Don't really need columns like CollectorID, IP Address
# Columns names are quite long - can shorten them

survey <- read_csv("https://raw.githubusercontent.com/grousell/MISAR/master/Data/survey_data_1.csv")%>%
  # Select only columns what we need, and rename the columns
  select (-StartDate, -EndDate) %>%
  rename (goal = "What is your goal for attending this session?")

# Examine dataframe
glimpse(survey)

survey %>%
  select (RespondentID, school, consider_self) %>%
  glimpse()

# Quick analyses
table (survey$useful)
prop.table (table (survey$useful))

