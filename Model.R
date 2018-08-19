#Hour Glass Model with several Hidden layers

cat("Allocating models... \n")

note("
     Hour Glass Model is the model that takes advantage
     of the fast-converging nature of the bottle-neck
     Convolutional Neuron Network and the feature
     contraction design. This network will maximize the
     information preserved from the original picture.
     At the same time, it can be trained fast, with very
     few epochs before converging.
     ")

note("
     This value can be either 5 or 1.
     5 is the maximum number of layers that will
     experimentally work while 1 is the fast 
     training model that can be trained even 
     by CPU.
     ")

#hidden_layer_count = 1 #Can be 5 or 1

model = keras_model_sequential()
if(hidden_layer_count == 5){
  model %>%
    #First Hidden Layer
    layer_conv_2d(filters = 128,
                  kernel_size = 1,
                  padding = "same",
                  activation = "relu",
                  input_shape = c(pic_width,pic_length,1)) %>%
    layer_batch_normalization() %>%
    layer_conv_2d(filters = 64,
                  kernel_size = 3,
                  padding = "same",
                  activation = "relu") %>%
    layer_batch_normalization() %>%
    layer_conv_2d(filters = 32,
                  kernel_size = 3,
                  padding = "same",
                  activation = "relu") %>%
    layer_batch_normalization() %>%
    layer_conv_2d(filters = 16,
                  kernel_size = 3,
                  padding = "same",
                  activation = "tanh") %>%
    layer_batch_normalization() %>%
    layer_conv_2d(filters = 1,
                  kernel_size = 1,
                  padding = "same",
                  activation = "tanh") %>%
    #Second Hidden Layer
    layer_conv_2d(filters = 128,
                  kernel_size = 1,
                  padding = "same",
                  activation = "relu",
                  input_shape = c(pic_width,pic_length,1)) %>%
    layer_batch_normalization() %>%
    layer_conv_2d(filters = 64,
                  kernel_size = 3,
                  padding = "same",
                  activation = "relu") %>%
    layer_batch_normalization() %>%
    layer_conv_2d(filters = 32,
                  kernel_size = 3,
                  padding = "same",
                  activation = "relu") %>%
    layer_batch_normalization() %>%
    layer_conv_2d(filters = 16,
                  kernel_size = 3,
                  padding = "same",
                  activation = "tanh") %>%
    layer_batch_normalization() %>%
    layer_conv_2d(filters = 1,
                  kernel_size = 1,
                  padding = "same",
                  activation = "tanh") %>%
    #Third Hidden Layer
    layer_conv_2d(filters = 128,
                  kernel_size = 1,
                  padding = "same",
                  activation = "relu",
                  input_shape = c(pic_width,pic_length,1)) %>%
    layer_batch_normalization() %>%
    layer_conv_2d(filters = 64,
                  kernel_size = 3,
                  padding = "same",
                  activation = "relu") %>%
    layer_batch_normalization() %>%
    layer_conv_2d(filters = 32,
                  kernel_size = 3,
                  padding = "same",
                  activation = "relu") %>%
    layer_batch_normalization() %>%
    layer_conv_2d(filters = 16,
                  kernel_size = 3,
                  padding = "same",
                  activation = "tanh") %>%
    layer_batch_normalization() %>%
    layer_conv_2d(filters = 1,
                  kernel_size = 1,
                  padding = "same",
                  activation = "tanh") %>%
    #Fourth Hidden Layer
    layer_conv_2d(filters = 128,
                  kernel_size = 1,
                  padding = "same",
                  activation = "relu",
                  input_shape = c(pic_width,pic_length,1)) %>%
    layer_batch_normalization() %>%
    layer_conv_2d(filters = 64,
                  kernel_size = 3,
                  padding = "same",
                  activation = "relu") %>%
    layer_batch_normalization() %>%
    layer_conv_2d(filters = 32,
                  kernel_size = 3,
                  padding = "same",
                  activation = "relu") %>%
    layer_batch_normalization() %>%
    layer_conv_2d(filters = 16,
                  kernel_size = 3,
                  padding = "same",
                  activation = "tanh") %>%
    layer_batch_normalization() %>%
    layer_conv_2d(filters = 1,
                  kernel_size = 1,
                  padding = "same",
                  activation = "tanh") %>%
    #Fifth Hidden Layer
    layer_conv_2d(filters = 128,
                  kernel_size = 1,
                  padding = "same",
                  activation = "tanh") %>%
    layer_batch_normalization() %>%
    layer_conv_2d(filters = 64,
                  kernel_size = 3,
                  padding = "same",
                  activation = "tanh") %>%
    layer_batch_normalization() %>%
    layer_conv_2d(filters = 32,
                  kernel_size = 3,
                  padding = "same",
                  activation = "tanh") %>%
    layer_batch_normalization() %>%
    layer_conv_2d(filters = 16,
                  kernel_size = 3,
                  padding = "same",
                  activation = "tanh") %>%
    layer_batch_normalization() %>%
    layer_conv_2d(filters = 1,
                  kernel_size = 1,
                  padding = "same",
                  activation = "tanh")
}else if(hidden_layer_count == 1){
  model %>%
    #First Hidden Layer
    layer_conv_2d(filters = 128,
                  kernel_size = 1,
                  padding = "same",
                  activation = "relu",
                  input_shape = c(pic_width,pic_length,1)) %>%
    layer_batch_normalization() %>%
    layer_conv_2d(filters = 64,
                  kernel_size = 3,
                  padding = "same",
                  activation = "relu") %>%
    layer_batch_normalization() %>%
    layer_conv_2d(filters = 32,
                  kernel_size = 3,
                  padding = "same",
                  activation = "relu") %>%
    layer_batch_normalization() %>%
    layer_conv_2d(filters = 16,
                  kernel_size = 3,
                  padding = "same",
                  activation = "tanh") %>%
    layer_batch_normalization() %>%
    layer_conv_2d(filters = 1,
                  kernel_size = 1,
                  padding = "same",
                  activation = "tanh")
}
