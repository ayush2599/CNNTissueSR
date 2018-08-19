#Fit the model for 3 different color channels

cat("Training models... \n")

history_red <- model_red %>% fit(
  train_low_red, train_high_red,
  epochs = generation, batch_size = batchsize,
  validation_split = validation
)

history_green <- model_green %>% fit(
  train_low_green, train_high_green,
  epochs = generation, batch_size = batchsize,
  validation_split = validation
)

history_blue <- model_blue %>% fit(
  train_low_blue, train_high_blue,
  epochs = generation, batch_size = batchsize,
  validation_split = validation
)
