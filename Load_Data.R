#Load data and Data Pre-processing
cat("Loading training data... \n")
#Load Image with high Resolution
getinto("High")
filelist = c(list.files(pattern = "png"),
             list.files(pattern = "jpg"))
high = imageData(readImage(filelist))

getback()

#Load Image with low Resolution
# getinto("Low")
# filelist = c(list.files(pattern = "png"),
#              list.files(pattern = "jpg"))
# low = imageData(readImage(filelist))
getinto("Large")
filelist = c(list.files(pattern = "png"),
             list.files(pattern = "jpg"))
low = imageData(readImage(filelist))

# #Check if the images are square images
# if(dim(high)[1] != dim(high)[2]){
#   stop("Square pictures required...")
# }
# if(dim(low)[1] != dim(low)[2]){
#   stop("Square pictures required...")
# }

pic_width = dim(high)[1]
pic_length = dim(high)[2]

#Determine training set and test set
test_size = length(filelist) - train_size
train_high = high[,,,1:train_size]
train_low = low[,,,1:train_size]

test_high = high[,,,(train_size+1):length(filelist)]
test_low = low[,,,(train_size+1):length(filelist)]

#Transpose the image data matrices
train_high = aperm(train_high, c(4,1,2,3))
train_low = aperm(train_low, c(4,1,2,3))
test_high = aperm(test_high, c(4,1,2,3))
test_low = aperm(test_low, c(4,1,2,3))

#Train Data
train_high_red = array(train_high[,,,1],c(train_size,pic_width,pic_length,1))
train_high_green = array(train_high[,,,2],c(train_size,pic_width,pic_length,1))
train_high_blue = array(train_high[,,,3],c(train_size,pic_width,pic_length,1))

train_low_red = array(train_low[,,,1],c(train_size,pic_width,pic_length,1))
train_low_green = array(train_low[,,,2],c(train_size,pic_width,pic_length,1))
train_low_blue = array(train_low[,,,3],c(train_size,pic_width,pic_length,1))

#Test Data
test_high_red = array(test_high[,,,1],c(test_size,pic_width,pic_length,1))
test_high_green = array(test_high[,,,2],c(test_size,pic_width,pic_length,1))
test_high_blue = array(test_high[,,,3],c(test_size,pic_width,pic_length,1))

test_low_red = array(test_low[,,,1],c(test_size,pic_width,pic_length,1))
test_low_green = array(test_low[,,,2],c(test_size,pic_width,pic_length,1))
test_low_blue = array(test_low[,,,3],c(test_size,pic_width,pic_length,1))

#Go back to the previous Work Directory
setwd(wd)