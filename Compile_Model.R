#Compile the models regarding 3
#Distinguished Color Channels
cat("Compiling models... \n")
#Loss Function
cnn_loss = function(y_true, y_pred){
  #2 Convolution layers
  #Default pedding type: Valid
  true_kernel = y_true %>%
    k_conv2d(strides = c(2,2),
             kernel = k_ones(shape = c(3,3,1,1))
    ) %>%
    k_conv2d(strides = c(2,2),
             kernel = k_ones(shape = c(3,3,1,1))
    )
  pred_kernel = y_pred %>%
    k_conv2d(strides = c(2,2),
             kernel = k_ones(shape = c(3,3,1,1))
    ) %>%
    k_conv2d(strides = c(2,2),
             kernel = k_ones(shape = c(3,3,1,1))
    )
  #Calculate Average Loss
  pixel_count = pic_width * pic_length
  k_sum(k_abs(y_true - y_pred))/k_constant(pixel_count)
}

#Alternative loss function (MSE)
mse = function(y_true, y_pred){
  k_sum((y_true - y_pred)^2)/k_constant(pic_width * pic_length)
}

#Make seperate models for three color channels
model_red = model
model_green = model
model_blue = model

#Compile model
compile(model_red,
        loss = cnn_loss,
        optimizer = "adam"
        #metrics = c("loss") 
        #Disabled graphic process control for better
        #Performance
)

compile(model_green,
        loss = cnn_loss,
        optimizer = "adam"
        #metrics = c("loss")
)

compile(model_blue,
        loss = cnn_loss,
        optimizer = "adam"
        #metrics = c("loss")
)
