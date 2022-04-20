
# 04_More dplyr - mutate_at and custom functions -----------------------------

# Load Packages -----------------------------------------------------------

library(tidyverse)

# Load survey data ------

df_1 <- read_csv ("https://raw.githubusercontent.com/grousell/MISAR/master/Data/survey_data_1.csv")
df_2 <- read_csv ("https://raw.githubusercontent.com/grousell/MISAR/master/Data/survey_data_2.csv")

# Merge two data sets together --------------------------------------------

df <- df_1 %>%
  left_join (df_2, by = c ("RespondentID"))

remove (df_1, df_2)

# Custom Functions --------------------------------------------------------
# Example 1

my_new_function <- function(x){
  x <- x + 5
  return (x)
}

my_new_function(15)
my_new_function(6)

# Example 2
my_new_function <- function(x, y){
  z <- x + y
  return (z)
}

my_new_function(3, 6)
my_new_function(15, 20)


# Function to recode factors ----------------------------------------------

my_recode_factors <- function(x){
  x <- parse_factor(x, levels = c("1 - Not at All",
                                  "2",
                                  "3",
                                  "4",
                                  "5 - Significantly")
                    )
  return (x)

}

str (df$session_useful)
str (my_recode_factors(df$session_useful))

# mutate_at ---------------------------------------------------------------

str(df$session_applicable)
str(df$session_changed)

df_new <- df |>
  mutate (across (7:10,
                  .fns = list (fct = ~my_recode_factors(.)
                               )
                  )
          )


str(df_new$session_useful)
str(df_new$session_useful_fct)
levels (df_new$session_useful_fct)


