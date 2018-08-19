#Clear workspace
rm(list = ls())

#Define parameters
hidden_layer_count = 5 #Can be 5 or 1
generation = 100 #Epoch
batchsize = 10 #Dependent on the RAM size; the larger the faster
validation = 0.2 #Portion of the data to validate (Validation Rate)
train_size = 200 #Need to be equal or smaller than the data set size
defogging_factor = 0 #Zeros returns original picture
use_plotly = FALSE #Training history virtualization using plotly
use_ggplot = FALSE #Training history virtualization using ggplot
save_model = TRUE #Whether model will be saved

#Clean Up
{
#Unload all the packages attached to the environment
try(lapply(paste('package:',
                 names(sessionInfo()$otherPkgs),
                 sep=""),
           detach,
           character.only = TRUE,
           unload = TRUE),
    silent = TRUE)

#Garbage collection
gc(verbose = TRUE, full = TRUE)

#Clear graphic workspace
try(graphics.off(), silent = TRUE)

get_directory = function(){
  args <- commandArgs(trailingOnly = FALSE)
  file <- "--file="
  rstudio <- "RStudio"
  
  match <- grep(rstudio, args)
  if(length(match) > 0){
    return(dirname(rstudioapi::getSourceEditorContext()$path))
  }else{
    match <- grep(file, args)
    if (length(match) > 0) {
      return(dirname(normalizePath(sub(file, "", args[match]))))
    }else{
      return(dirname(normalizePath(sys.frames()[[1]]$ofile)))
    }
  }
}
}

#Change the Working directory to the current folder
setwd(get_directory())
wd = get_directory()

#Set up the environment
try({
  source("Setup.R")
  source("File_Operation.R")
  },
  silent = TRUE
)

#Load the Data
source("Load_Data.R")

note("
     Here finishes the data processing and cleaning.
     Model building and fitting will start from here.
     ")

#Define Model
source("Model.R")

#Compile model
#Loss function may be optimized
source("Compile_Model.R")

#Fit the model
source("Fit_Model.R")

#Evaluate the model
source("Evaluate_Predict.R")

#Linear filter
source("Linear_Filter.R")

#Visualize training history
source("Visualization.R")

#Save Model
source("Save_Model.R")