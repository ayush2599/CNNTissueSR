# CNNTissueSR
Super Resolution of Tissue Microscopic Images

Project presentation is attached as ```Convolutional Neuron Network Based Microscopic Image Super-Resolution.pptx```

To run/test this algorithm, please download the repository and unzip all the zip files to the same directory. Make sure the file names are unchanged. Then, line-by-line/source the ```Main.R``` file from this repository. For the first time this program is running on some computers, few packages may be installed automatically. In this process, R may reboot several times by itself. If Nvidia GPU can be ultilized for tensor calculation, please change ```Setup.R``` file first block

```
if(!require("keras")){
  install.packages("keras")
  library(keras)
  try(install_keras(),
      silent = TRUE)
}
```

to

```
if(!require("keras")){
  install.packages("keras")
  library(keras)
  try(install_keras(tensorflow = "GPU"),
      silent = TRUE)
}
```


The convolutional neuron network model this algorithm is using is called ```"Hour Glass Model"```

The lost function this network is ultilizing is called ```"Convoluted Feature Map Loss"```


In ```Main.R``` :
```
  hidden_layer_count = 5        #Can be 5 or 1
  generation = 100              #Epoch
  batchsize = 10                #Dependent on the RAM size; the larger the faster
  validation = 0.2              #Portion of the data to validate (Validation Rate)
  train_size = 200              #Need to be equal or smaller than the data set size
  defogging_factor = 0          #Zeros returns original picture
  use_plotly = FALSE            #Training history virtualization using plotly
  use_ggplot = FALSE            #Training history virtualization using ggplot
  save_model = TRUE             #Whether model will be saved
```

In the code above few parameters of this algorrithm are defined including hidden layer count, epoch, batch size, training size and linear filter intensity. Please feel free to change the parameters while using.

In this algorithm, linear filter is completely optional. Whether the presence of linear filter will increase the quality of the images is still worth debating.

Data virtualization, in this case, is using either/both plotly and ggplot2. For plotly, a pre-registered account deticated for this project is used in the code. Please do not use this account for personal use. Were there any suggestions given to the utilization of the plotly account, please contact the author.


Author Email: wag001@ucsd.edu   
Open to questions and suggestions!

This project is completed in University of Tokyo, Department of Chemistry. Million thanks to fellow scholars for the tremendous help.
