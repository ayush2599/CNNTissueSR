if(save_model){
  cat("Saving models... \n")
  #Save Model
  getinto(dirname)
  save_model_weights_hdf5(object = model_red,
                          filepath = paste(dirname, "_red.hdf5",
                                           sep = ""))
  save_model_weights_hdf5(object = model_green,
                          filepath = paste(dirname, "_green.hdf5",
                                           sep = ""))
  save_model_weights_hdf5(object = model_blue,
                          filepath = paste(dirname, "_blue.hdf5",
                                           sep = ""))
}else{
  cat("Model not saved... \n")
}

#Going back to the original directory
setwd(wd)