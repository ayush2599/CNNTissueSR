library(EBImage)
library(raster)
library(fields)

smooth_image = FALSE #Using Bicubic Enhancement
show_image = FALSE #True if showing every single image is needed
save_image = TRUE #Generate/Overwrite "Large" folder with pictures

#File Operation Function
getinto = function(filename){
  if(!dir.exists(filename)){
    print("The file is not found...")
    stop("Wrong directory...")
  }else{
    setwd(paste(getwd(),"/",filename,sep = ""))
    # print("The new directory is:")
    # getwd()
  }
}
getback = function(){
  wd = strsplit(getwd(),"/")
  wd = wd[[1]]
  if(length(wd)>1){
    newwd = wd[1:length(wd)-1]
    temwd = ""
    for(i in 1:length(newwd)){
      temwd = paste(temwd,newwd[i],sep = "/")
    }
    temwd = substring(temwd,2,nchar(temwd))
    setwd(temwd)
  }else{
    print("The current directory is already the mother directory...")
    warning("Unable to get back to previous directory...")
  }
  # print("The current directory is:")
  # getwd()
}

#Define the working directory
get_directory <- function(){
  args <- commandArgs(trailingOnly = FALSE)
  file <- "--file="
  rstudio <- "RStudio"
  
  match <- grep(rstudio, args)
  if (length(match) > 0) {
    return(dirname(rstudioapi::getSourceEditorContext()$path))
  } else {
    match <- grep(file, args)
    if (length(match) > 0) {
      return(dirname(normalizePath(sub(file, "", args[match]))))
    } else {
      return(dirname(normalizePath(sys.frames()[[1]]$ofile)))
    }
  }
}

setwd(get_directory())
getinto("Low")
wd = getwd()

# wd = "D:/Deep learning super-resolution/Tissue_SR/Low"
# setwd(wd)

note = function(notes){
  cat("")
}

note("
     The file directory must store pictures of low resolution.
     This Algorithm will enhance the pictures in the bicubic
     Fashion.
     ")

enlarge_pic = function(picture){
  dimension = dim(picture)
  tempmat = matrix(-1, nrow = dimension[1] * 2,
                   ncol = dimension[2] * 2)
  for(i in 1:dimension[1]){
    for(j in 1:dimension[2]){
      tempmat[(2*i-1):(2*i), (2*j-1):(2*j)] = picture[i,j]
    }
  }
  image = tempmat
  return(image)
}

#Bicubic Smooth
smooth_pic = function(x, wght = NULL,
                      dx = 1, dy = 1,
                      kernel.function = double.exp, 
                      theta = 1, grid = NULL,
                      tol = 1e-08, xwidth = NULL,
                      ywidth = NULL, 
                      weights = NULL, ...){
  if(is.list(x)){
    Y = x$z
    grid = list(x = x$x, y = x$y)
  }
  else{
    Y = x
  }
  if(!is.matrix(Y)){
    stop("Requires a matrix")
  }
  m = nrow(Y)
  n = ncol(Y)
  if(!is.null(wght)){
    dx = wght$dx
    dy = wght$dy
    xwidth = wght$xwidth
    ywidth = wght$ywidth
  }
  if(is.null(grid)){
    grid = list(x = (1:m) * dx, y = (1:n) * dy)
  }
  else{
    dx = grid$x[2] - grid$x[1]
    dy = grid$y[2] - grid$y[1]
  }
  if(is.null(xwidth)){
    xwidth = dx * m
  }
  if(is.null(ywidth)){
    ywidth = dy * n
  }
  if(is.null(wght)){
    wght = setup.image.smooth(nrow = m, ncol = n, xwidth = xwidth, 
                               ywidth = ywidth, dx = dx, dy = dy,
                              kernel.function = kernel.function, 
                               theta = theta, ...)
  }
  M = nrow(wght$W)
  N = ncol(wght$W)
  temp = matrix(0, nrow = M, ncol = N)
  temp2 = matrix(0, nrow = M, ncol = N)
  if(!is.null(weights)){
    temp[1:m, 1:n] = Y * weights
    temp[is.na(temp)] = 0
    temp2[1:m, 1:n] = ifelse(!is.na(Y), weights, 0)
  }
  else{
    temp[1:m, 1:n] = Y
    temp[is.na(temp)] = 0
    temp2[1:m, 1:n] = ifelse(!is.na(Y), 1, 0)
  }
  temp = Re(fft(fft(temp) * wght$W, inverse = TRUE))[1:m, 1:n]
  temp2 = Re(fft(fft(temp2) * wght$W, inverse = TRUE))[1:m, 1:n]
  temp = ifelse((temp2 > tol), (temp/temp2), NA)
  list(x = grid$x, y = grid$y, z = temp)
}
setup.image.smooth = function (nrow = 64, ncol = 64,
                               dx = 1, dy = 1, kernel.function = double.exp, 
                               theta = 1, xwidth = nrow * dx,
                               ywidth = ncol * dx, lambda = NULL, ...){
  M2 = round((nrow + xwidth/dx)/2)
  N2 = round((ncol + ywidth/dy)/2)
  M = 2 * M2
  N = 2 * N2
  xi = seq(-(M2 - 1), M2, 1) * dx
  xi = xi/theta
  yi = seq(-(N2 - 1), (N2), 1) * dy
  yi = yi/theta
  dd = ((matrix(xi, M, N)^2 + matrix(yi, M, N, byrow = TRUE)^2))
  out = matrix(kernel.function(dd, ...), nrow = M, ncol = N)
  out2 = matrix(0, M, N)
  out2[M2, N2] = 1
  W = fft(out)/fft(out2)
  if(!is.null(lambda)){
    W = W/(lambda/fft(out2) + W)
  }
  list(W = W/(M * N), dx = dx, dy = dy, xwidth = xwidth, ywidth = ywidth, 
       M = M, N = N, m = nrow, n = ncol, lambda = lambda, grid = list(x = xi, 
                                                                      y = yi))
}

#Loading pictures
filelist = c(list.files(pattern = "png"),
             list.files(pattern = "jpg"))
for(picture_path in filelist){
  #Showing Progress
  cat(paste(
    "Processing Picture", gsub(picture_path,
                               pattern = ".png",
                               replacement = ""), "\n"
  ))
  picture = readImage(picture_path)
  image_dim = dim(imageData(picture))[1]
  #Distinguish RGB Channels
  red = imageData(picture)[,,1]
  green = imageData(picture)[,,2]
  blue = imageData(picture)[,,3]
  if(smooth_image){
    #Smooth pictures for Bicubic interpolation
    red = smooth_pic(enlarge_pic(red))$z
    green = smooth_pic(enlarge_pic(green))$z
    blue = smooth_pic(enlarge_pic(blue))$z
  }else{
    #Simply enlarge the size of the pictures
    red = enlarge_pic(red)
    green = enlarge_pic(green)
    blue = enlarge_pic(blue)
  }
  #Combine different channels
  image_dim = round(image_dim * 2, 0)
  imageData(picture) = array(c(red, green, blue),
                             dim = c(image_dim,image_dim,3))
  #Show image while processing
  if(show_image){
    windows()
    plot(picture)
    Sys.sleep(1)
    graphics.off()
  }
  #Save image
  if(save_image){
    getback()
    if(!file.exists("Large")){
      dir.create("Large")
    }
    getinto("Large")
    filename = paste("large_",
                     picture_path,
                     sep = "")
    writeImage(picture, files = filename)
    setwd(wd)
    cat(paste(filename, "saved", "\n"))
  }
}