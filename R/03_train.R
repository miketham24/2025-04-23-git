# train_model.R
train_model <- function(data) {
  library(tidymodels)

  # Split data
  set.seed(123)
  data_split <- initial_split(data, strata = species)
  train_data <- training(data_split)
  test_data <- testing(data_split)

  # Define model
  penguin_model <- nearest_neighbor(mode = "classification", neighbors = 5) %>%
    set_engine("kknn")

  # Create workflow
  penguin_workflow <- workflow() %>%
    add_model(penguin_model) %>%
    add_formula(species ~ .)

  # Fit model
  penguin_fit <- penguin_workflow %>%
    fit(data = train_data)

  return(list(penguin_fit = penguin_fit, test_data = test_data))
}
