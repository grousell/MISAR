
# MISA - How To Learn R ---------------------------------------------------

# https://www.r-bloggers.com/how-to-learn-r-2/

# Basics ------------------------------------------------------------------

# Calculator
1 + 1
1 + 2^2
1 + (2*3)

# Store Objects
x <- 4
y <- 6
z <- x + y

# Functions

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

library(tidyverse) # Bundle of many functions

# Import Data -------------------------------------------------------------

# csv files
df1 <- read_csv ("https://raw.githubusercontent.com/grousell/Misc/master/Data/parking_data_all.csv") %>%
  head(5000)

# SPSS
library(foreign) # Foreign package will read in SPSS and .dbf files 
df2 <- read.spss("file.sav")

# .dbf files, from GIS

df3 <- read.dbf ("file.dbf",
                 as.is = TRUE) # Keeps as character vs. factors

#  Explore Data -----------------------------------------------------------

str(df1) 
glimpse(df1)
table (df$infraction_description)

# Survey Data -------------------------------------------------------------

df <- read_csv("~/Dropbox/Misc/Data/survey_data.csv") %>%
  select (goal = "My goal for attending this session: - Open-Ended Response",
          expert = "On this topic, I consider myself:",
          useful = "In regards to this session, the content presented: - Is USEFUL to me",
          applicable = "In regards to this session, the content presented: - Is APPLICABLE to my job",
          changed = "In regards to this session, the content presented: - Has CHANGED my thinking", 
          reinforced = "In regards to this session, the content presented: - Has REINFORCED my thinking"
          )


