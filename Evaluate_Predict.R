#Predict test_input pictures according to the model

cat("Making predictions based on the model trained... \n")

red_predicted = predict(model_red,test_low_red)[,,,1]
green_predicted = predict(model_green,test_low_green)[,,,1]
blue_predicted = predict(model_blue,test_low_blue)[,,,1]

pic_predicted = Image(data = aperm(array(c(red_predicted,
                                           green_predicted,
                                           blue_predicted),
                               dim = c(test_size,pic_width,pic_length,3)),
                               c(2,3,4,1)),
            colormode = "Color")

#Go back to the previous workspace
setwd(wd)



