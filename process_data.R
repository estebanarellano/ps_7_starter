library(tidyverse)

JS <- read.csv("mt_2_results.csv")

upshot <- read_rds("upshot.rds")

race <- upshot %>%
  filter(senate == FALSE, gov == FALSE, wave == 3) %>%
  group_by(state_district) %>%
  count(file_race) %>%
  mutate(n = n / sum(n) * 100) %>%
  spread(file_race, n)

JS <- JS %>%
  mutate(state_district = paste(tolower(state), district, sep = ""))

final <- race %>%
  left_join(JS, by = "state_district")
