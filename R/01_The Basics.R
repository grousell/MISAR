
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
fun1(vec2)
fun2(vec2)

# New function
fun3 <- function(x){
  ifelse (x =="a", "A",
          ifelse (x == "b", "A", "B")
  )
}
fun3 (vec1)

# Factors - numeric assignment to nominal variable

gender <- c ("Male", "Male", "Female", "Male", "Female")
gender <- factor (gender) # Now "Male" and "Female" are represented by numbers
as.numeric(gender)

# Change the order of the factors
gender <- factor (gender,
                  levels = c("Male", "Female"))
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
# Tidyverse
tic()
df1 <- read_csv ("https://raw.githubusercontent.com/grousell/MISAR/master/Data/parking_data_all.csv") %>% #then
  head(5000) # Selects first 5000 rows
toc()

# Base
tic()
df1 <- read.csv ("https://raw.githubusercontent.com/grousell/MISAR/master/Data/parking_data_all.csv",
                 stringsAsFactors = FALSE) %>%
  head(5000) # Selects first 5000 rows
toc()

# Import Data -------------------------------------------------------------

# csv files
parking <- read_csv ("https://raw.githubusercontent.com/grousell/MISAR/master/Data/parking_data_all.csv") %>%
  head(5000) # Selects first 5000 rows

# SPSS
library(foreign) # Foreign package will read in SPSS and .dbf files
df2 <- read.spss("file.sav")

# .dbf files, from GIS

df3 <- read.dbf ("file.dbf",
                 as.is = TRUE) # Keeps as character vs. factors

# Explore Data -----------------------------------------------------------

str(df1)
glimpse(df1)
table (df$infraction_description)

# Survey Data -------------------------------------------------------------
# May have extraneous columns, or names may be too long.
survey <- read_csv("https://raw.githubusercontent.com/grousell/MISAR/master/Data/survey_data.csv")
glimpse(survey)

# Don't really need columns like CollectorID, IP Address
# Columns names are quite long - can shorten them

survey <- read_csv("https://raw.githubusercontent.com/grousell/MISAR/master/Data/survey_data.csv")  %>%
  # Select only columns what we need, and rename the columns
  select (goal = "My goal for attending this session: - Open-Ended Response",
          expert = "On this topic, I consider myself:",
          useful = "In regards to this session, the content presented: - Is USEFUL to me",
          applicable = "In regards to this session, the content presented: - Is APPLICABLE to my job",
          changed = "In regards to this session, the content presented: - Has CHANGED my thinking",
          reinforced = "In regards to this session, the content presented: - Has REINFORCED my thinking"
          )

# Examine dataframe
glimpse(survey)

# Quick analyses
table (survey$useful)
prop.table (table (survey$useful))

