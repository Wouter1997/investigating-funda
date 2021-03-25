download_data <- function(url, filename, filepath) {
  # create directory
  dir.create(filepath)
  # download file
  download.file(url = url, destfile = paste0(filepath, filename))
}


download_data(url = "https://drive.google.com/uc?export=download&id=1Zdzoqz_qnP_O2v_znn7vx_6KjtQgbtbq", filename = "eindhoven.csv", filepath = "../../gen/input/")
download_data(url = "https://drive.google.com/uc?export=download&id=1TZ6vtUXN8UJ5yUa-vjOOxvlu9DjnxEDl", filename = "maastricht.csv", filepath = "../../gen/input/")
download_data(url = "https://drive.google.com/uc?export=download&id=1eI2K8c9jTerxZDFsbH-U0GUCzXUIMuLY", filename= "leeuwarden.csv", filepath = "../../gen/input/")
download_data(url = "https://drive.google.com/uc?export=download&id=14kuB4CMtzX8_DIIBKaJewobL8yM2M3mb", filename= "dordrecht.csv", filepath = "../../gen/input/")

sink('../../gen/input/downloaded.txt')
cat('done!')
sink()
