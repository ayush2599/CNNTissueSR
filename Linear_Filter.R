#Save image predicted temporarily so that it can be accessed
cat("Converting Pictures... \n")
n = 1
dirname = paste("predicted_images_", n, sep = "")
while(any(dirname == list.files())){
  n = n + 1
  dirname = paste("predicted_images_", n, sep = "")
}

dir.create(dirname)
getinto(dirname)
writeImage(pic_predicted, paste(seq(1,dim(pic_predicted)[4],1),
                                ".png",sep = ""))

#Color correcting image linear filter
image_list = list.files()
cat("Providing Color Correcting Linear Filter...\n")
progress = 1
progress_bar = txtProgressBar(min = 0,
                              max = length(image_list), style = 3)
for(pic_path in image_list){
  picture = image_read(path = pic_path)
  picture = image_modulate(picture,
                           brightness = 100 - defogging_factor,
                           saturation = 100 + defogging_factor,
                           hue = 100 - defogging_factor/2)
  #Over-write the original images
  setTxtProgressBar(progress_bar, progress)
  image_write(picture, path = pic_path)
  progress = progress + 1
}

#Image sharpness linear filter
cat("\n")
cat("Providing Image Sharpness Linear Filter...\n")
progress = 1
progress_bar = txtProgressBar(min = 0,
                              max = length(image_list), style = 3)
for(pic_path in image_list){
  picture = load.image(file = pic_path)
  picture = imsharpen(picture, amplitude = 1,
                      type = "diffusion")
  setTxtProgressBar(progress_bar, progress)
  #Over-write the images
  save.image(picture, file = pic_path)
  progress = progress + 1
}
cat("\n")

#Going back to the previous image
setwd(wd)
