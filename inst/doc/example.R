## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, eval = F, echo = T------------------------------------------------
#  library(soundClass)

## ----keras, eval = F, echo = T------------------------------------------------
#  keras::install_keras() # only needed before first use of soundClass

## ----folder, eval = F, echo = T-----------------------------------------------
#  setwd("/path_to_extracted_folder/")

## ----custom model, eval = F, echo = T-----------------------------------------
#  model_path <- system.file("model_architectures", "model_vgg_sequential.R", package="soundClass")
#  file.copy(model_path, ".") # Copy custom blank model to the folder 'data_example'

## ----train_calls, eval = F, echo = T------------------------------------------
#  # To use the app instead of scripting:
#  # app_model()
#  
#  train_calls <- spectro_calls(
#    files_path = "./training_recordings/",
#    db_path = "./db_bat_calls.sqlite3",
#    spec_size = 20,
#    window_length = 0.5,
#    frequency_resolution = 1,
#    overlap =  0.5,
#    dynamic_range = 100,
#    freq_range = c(10, 80),
#    tx = "auto",
#    seed = 1002)
#  
#  # save the object to disk
#  save(train_calls, file = "train_calls.RDATA")

## ----model_load, eval = F, echo = T-------------------------------------------
#  input_shape <- c(metadata$parameters$img_rows, metadata$parameters$img_cols, 1)
#  num_classes <- metadata$parameters$num_classes
#  model_path <- system.file("model_architectures", "model_vgg_sequential.R", package="soundClass")
#  source(model_path, local = TRUE)

## ----model_compile, eval = F, echo = T----------------------------------------
#   model %>%
#    keras::compile(
#     optimizer = keras::optimizer_sgd(
#                  learning_rate = 0.01,
#                  momentum = 0.9,
#                  nesterov = TRUE),
#     loss = 'categorical_crossentropy',
#     metrics = 'accuracy'
#    )

## ----model_fit, eval = F, echo = T--------------------------------------------
#   model %>% keras::fit(train_calls$data_x,
#          train_calls$data_y,
#          batch_size = 128,
#          epochs = 20,
#          callbacks = list(
#           keras::callback_early_stopping(patience = 4, monitor = 'val_accuracy'),
#           keras::callback_model_checkpoint("./fitted_model.hdf5",
#                        monitor = "val_accuracy", save_best_only = T),
#           keras::callback_csv_logger("./fitted_model_log.csv")),
#          shuffle = TRUE,
#          validation_split = 0.3,
#          verbose = 1)

## ----train_metadata, eval = F, echo = T---------------------------------------
#  metadata <- train_metadata(train_calls)
#  
#  # save the object to disk
#  save(metadata, file = "./fitted_model_metadata.RDATA")

## ----model_deploy, eval = F, echo = T-----------------------------------------
#  auto_id(model_path = "./fitted_model.hdf5",
#          metadata = "./fitted_model_metadata.RDATA", # or "./fitted_model_metadata.RDATA" (the path to the previously saved metadata file)
#          file_path = "./validation_recordings/",
#          out_file = "id_results",
#          out_dir = "./validation_recordings/output/",
#          save_png = TRUE,
#          win_size = 40,
#          remove_noise = TRUE,
#          plot2console = FALSE,
#          recursive = FALSE,
#          tx = "auto")

