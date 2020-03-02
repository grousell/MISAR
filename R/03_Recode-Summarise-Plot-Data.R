
# 02_Recoding and Summarise Data ---------------------------------------------
# Load Packages -----------------------------------------------------------
library(tidyverse)

# Load survey data ------

df_1 <- read_csv ("https://raw.githubusercontent.com/grousell/MISAR/master/Data/survey_data_1.csv")
df_2 <- read_csv ("https://raw.githubusercontent.com/grousell/MISAR/master/Data/survey_data_2.csv")

# Merge two data sets together --------------------------------------------

df <- df_1 %>%
  left_join (df_2, by = c ("RespondentID"))

remove (df_1, df_2)

# Recoding data   -------------------------------------------------------

df <- df %>%
  mutate (session_valuable_R = recode (session_valuable,
                                       "Strongly Agree" = "1",
                                       "Agree" = "1",
                                       "Neither Agree or Disagree" = "0",
                                       "Disagree" = "0",
                                       "Strongly Disagree" = "0")
          )

# Check that recoding worked

table (df$session_valuable, df$session_valuable_R)

# Summary Tables ----------------------------------------------------------

# By Variable
session_valuable_summary <- df %>%
  group_by (session_valuable) %>%
  count () %>%
  ungroup() %>%
  na.omit(agree) %>%
  mutate (perc = n / sum(n)
          )

session_valuable_summary

# By School and Variable
session_valuable_school_summary <- df %>%
  group_by (school, session_valuable) %>%
  count () %>%
  ungroup() %>%
  na.omit(agree) %>%
  group_by(school) %>%
  mutate (perc = n / sum(n)
  )

session_valuable_school_summary


# Plot Summaries ----------------------------------------------------------

session_valuable_summary %>%
  ggplot (aes (x = session_valuable, y = perc)) +
  geom_col()

# Need to change order of x-axis

session_valuable_summary <- session_valuable_summary %>%
  mutate (session_valuable = parse_factor(session_valuable, levels = c ("Strongly Disagree",
                                                                        "Disagree",
                                                                        "Neither Agree or Disagree",
                                                                        "Agree",
                                                                        "Strongly Agree")
  )
  )

session_valuable_summary %>%
  ggplot (aes (x = session_valuable, y = perc)) +
  geom_col()

# Spruce it up a bit

session_valuable_summary %>%
  ggplot (aes (x = session_valuable, y = perc)) +
  geom_col(fill = "blue") +
  scale_y_continuous(labels = scales::percent_format(accuracy = 1),
                     limits = c(0,1)) +
  geom_text (aes (label = scales::percent(perc, accuracy = 2)),
             vjust = -1,
             size = 5) +
  labs (title = "I found this session valuable",
        x = "Level of Agreement",
        y = "Percentage")

# Flip axis ---------------------------------------------------------------
session_valuable_summary %>%
  ggplot (aes (x = session_valuable, y = perc)) +
  geom_col(fill = "blue") +
  coord_flip() +# add this
  scale_y_continuous(labels = scales::percent_format(accuracy = 1),
                     limits = c(0,1)) +
  geom_text (aes (label = scales::percent(perc, accuracy = 2)),
             hjust = -1, #Change to hjust
             size = 5) +
  labs (title = "I found this session valuable",
        x = "Level of Agreement",
        y = "Percentage")

# Order by outcome
session_valuable_summary %>%
  ggplot (aes (x = reorder(session_valuable, perc), y = perc)) + # Add reorder by perc here
  geom_col(fill = "blue") +
  coord_flip() +# add this
  scale_y_continuous(labels = scales::percent_format(accuracy = 1),
                     limits = c(0,1)) +
  geom_text (aes (label = scales::percent(perc, accuracy = 2)),
             hjust = -1, #Change to hjust
             size = 5) +
  labs (title = "I found this session valuable",
        x = "Level of Agreement",
        y = "Percentage")

# Multiple Plots ----------------------------------------------------------

session_valuable_school_summary  <- session_valuable_school_summary %>%
  mutate (session_valuable = parse_factor(session_valuable, levels = c ("Strongly Disagree",
                                                                        "Disagree",
                                                                        "Neither Agree or Disagree",
                                                                        "Agree",
                                                                        "Strongly Agree")
  )
  )

session_valuable_school_summary %>%
  ggplot (aes (x = session_valuable, y = perc, fill = school)) +
  geom_col () +
  scale_y_continuous(labels = scales::percent_format(accuracy = 1),
                     limits = c(0,1)) +
  geom_text (aes (label = scales::percent(perc, accuracy = 2)),
             vjust = -1,
             size = 5) +
  facet_wrap(~school) +
  labs (title = "I found this session valuable",
        x = "Level of Agreement",
        y = "Percentage") +
  theme(legend.position = "none")











