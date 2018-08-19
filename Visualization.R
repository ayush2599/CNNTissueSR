#Show predicted images in one plot
getinto(dirname)
images = readImage(files = image_list)
cat("Showing all predicted images...\n")
windows()
plot(images, all = TRUE)

#Training history virtualization using plotly
if(use_plotly){
  #Virtualizing training history using plotly
  note("
       Plotly account is registered by a google account.
       Account: thisisforplotly@gmail.com
       Password: thisisforplotly001
       When API key expires or needs to beupdated, please visit:
       https://plot.ly/r/getting-started/#initialization-for-online-plotting
       ")
  Sys.setenv("plotly_username"="plotly_sensei")
  Sys.setenv("plotly_api_key"="1mPE1sKQkjk2qROX1q0S")
  
  #plot Training history for red model
  training_history_red = plot_ly(x = seq(1,length(history_red$metrics$val_loss),1),
                                 y = history_red$metrics$val_loss,
                                 type = "scatter",
                                 mode = "markers") %>%
    layout(xaxis = list(title = "Epoch"),
           yaxis = list(title = "Loss"),
           title = "Training History for Red Model")
  try(
    api_create(training_history_red, filename = "training_history_red"),
    silent = TRUE
  )
  
  #plot Training history for green model
  training_history_green = plot_ly(x = seq(1,length(history_green$metrics$val_loss),1),
                                   y = history_green$metrics$val_loss,
                                   type = "scatter",
                                   mode = "markers") %>%
    layout(xaxis = list(title = "Epoch"),
           yaxis = list(title = "Loss"),
           title = "Training History for Green Model")
  
  try(
    api_create(training_history_green, filename = "training_history_green"),
    silent = TRUE
  )
  
  #plot Training history for blue model
  training_history_blue = plot_ly(x = seq(1,length(history_blue$metrics$val_loss),1),
                                  y = history_blue$metrics$val_loss,
                                  type = "scatter",
                                  mode = "markers") %>%
    layout(xaxis = list(title = "Epoch"),
           yaxis = list(title = "Loss"),
           title = "Training History for Blue Model")
  try(
    api_create(training_history_blue, filename = "training_history_blue"),
    silent = TRUE
  )
}

#Training history virtualization using ggplot
if(use_ggplot){
  #plot Training history for red model
  windows()
  history_data = data.frame(seq(1,length(history_red$metrics$val_loss),1),
                            history_red$metrics$val_loss)
  ggplot(data = history_data, aes(seq(1,length(history_red$metrics$val_loss),1),
                                  history_red$metrics$val_loss)) +
    geom_bin2d() + 
    ggtitle("Training history red") +
    xlab("Epoch") +
    ylab("Loss")
  
  #plot Training history for green model
  windows()
  history_data = data.frame(seq(1,length(history_green$metrics$val_loss),1),
                            history_green$metrics$val_loss)
  ggplot(data = history_data, aes(seq(1,length(history_green$metrics$val_loss),1),
                                  history_green$metrics$val_loss)) +
    geom_bin2d() +
    ggtitle("Training history green") +
    xlab("Epoch") +
    ylab("Loss")
  
  #plot Training history for blue model
  windows()
  history_data = data.frame(seq(1,length(history_blue$metrics$val_loss),1),
                            history_blue$metrics$val_loss)
  ggplot(data = history_data, aes(seq(1,length(history_blue$metrics$val_loss),1),
                                  history_blue$metrics$val_loss)) +
    geom_bin2d() + 
    ggtitle("Training history blue") +
    xlab("Epoch") +
    ylab("Loss")
}

note("
       Please note that even though the models are trained 
       seperately, there are consistancies along with the
       training and the loss of the third model will be
       as expected smaller than that of the first model. Also
       the loss of the third model, as it starts to get really
       low, may starts to throttle.
       ")

if(!any(use_plotly, use_ggplot)){
  cat("Training history not shown... \n")
}

#Going back to the original directory
setwd(wd)