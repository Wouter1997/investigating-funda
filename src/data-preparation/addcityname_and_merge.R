library(tibble)
library(tidyverse)
library(data.table)


files = list.files(pattern='[.]csv', path ="../../gen/data-preparation/input/",
                full.names=T)

all_cities = lapply(files, function(fn) {
  
  data <- read_csv(fn)
  stad<- rev(strsplit(fn,'/')[[1]])[1]
  stad <- gsub('[.]csv','',stad)
  
  data$stad <- stad
  
  return(data.table(data))
})
          
merged = rbindlist(all_cities,fill=T)

dir.create('../../gen/data-preparation/temp/')
fwrite(merged, '../../gen/data-preparation/temp/merged_cities.csv')