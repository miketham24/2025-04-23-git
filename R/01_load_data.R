# load_and_clean_data.R
load_and_clean_data <- function() {
  library(tidyverse)
  library(palmerpenguins)

  data <- penguins

  # Initial cleaning: Remove missing values
  data <- data %>% drop_na()

  return(data)
}
