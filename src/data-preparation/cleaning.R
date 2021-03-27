#Cleaning data
library(tidyverse)
library(tidyr)
library(dplyr)
library(tibble)
library(data.table)
merged_cities <- read_csv('../../gen/data-preparation/temp/merged_cities.csv')

#remove everything but city, price, offered since, selling date and construction year
merged_cities <- merged_cities %>% select(Adres, `Aangeboden sinds`, Verkoopdatum, `Laatste vraagprijs`, stad, Bouwjaar) 
#remove na's
merged_cities_clean <- merged_cities %>% drop_na()

#remove unwanted characters to be able to convert price in numeric
merged_cities_clean$`Laatste vraagprijs` <- str_replace_all(merged_cities_clean$`Laatste vraagprijs`, c('kosten koper' = "",
                                                            'vrij op naam' = "", '\nHypotheekadvies'= "", 
                                                            'Prijs op aanvraag'=""))

#convert blank spaces introduced by cleaning to NA (in order to remove them) and drop them
merged_cities_clean <- merged_cities_clean %>% mutate_all(na_if,"")
merged_cities_clean <- merged_cities_clean %>% drop_na()

#create new NUMERIC variable for price
merged_cities_clean$`Laatste vraagprijs_num` <- as.numeric(gsub('[€.]', '', merged_cities_clean$`Laatste vraagprijs`))

#convert Bouwjaar into NUMERIC variable
merged_cities_clean$Bouwjaar <-  str_replace(merged_cities_clean$Bouwjaar, "Voor 1906", "1906")
merged_cities_clean$Bouwjaar <- as.numeric(merged_cities_clean$Bouwjaar)
merged_cities_clean <- merged_cities_clean %>% mutate_all(na_if,"")

#convert month names to numerics sinds and selling date
merged_cities_clean$`Aangeboden sinds_date_2` <-  str_replace_all(merged_cities_clean$`Aangeboden sinds`, c("januari"= "01", "februari"= "02", "maart"= "03", "april"= "04", "mei"= "05", "juni"= "06",
                                                                                                      "juli"="07", "augustus"= "08", "september"= "09", "oktober"= "10", "november"= "11", 
                                                                                                      "december"= "12", " "= "-"))
merged_cities_clean$`Verkoopdatum_2` <-  str_replace_all(merged_cities_clean$`Verkoopdatum`, c("januari"= "01", "februari"= "02", "maart"= "03", "april"= "04", "mei"= "05", "juni"= "06",
                                                                                                        "juli"="07", "augustus"= "08", "september"= "09", "oktober"= "10", "november"= "11", 
                                                                                                        "december"= "12", " "= "-"))
#convert dates with as.Date
merged_cities_clean$`Aangeboden sinds_date_2` <- as.Date(merged_cities_clean$`Aangeboden sinds_date_2`, format = "%d-%m-%Y")
merged_cities_clean$`Verkoopdatum_2` <- as.Date(merged_cities_clean$`Verkoopdatum_2` , format = "%d-%m-%Y")

#create new column with time between days
merged_cities_clean$sellingduration <- difftime(merged_cities_clean$`Verkoopdatum_2`, merged_cities_clean$`Aangeboden sinds_date_2`, units = c("days"))

#remove unnecessary columns
merged_cities_clean <- merged_cities_clean %>% select(Adres, stad,  `Laatste vraagprijs_num`, `sellingduration`, Bouwjaar) 

#rename columns
library(dplyr)
names(merged_cities_clean)[3] <- "Selling Price (in euros)"


#some minor changes
merged_cities_clean$price<- merged_cities_clean$`Selling Price (in euros)`
merged_cities_clean$city<- as.factor(merged_cities_clean$stad)
merged_cities_clean$constructionyear <- merged_cities_clean$Bouwjaar
merged_cities_clean <- merged_cities_clean[-c(2, 3,5)]
merged_cities_clean <- merged_cities_clean %>% select(Adres, city,  price, `sellingduration`, constructionyear) 
final_dataset_housemarket <- merged_cities_clean %>% drop_na()

#write csv with cleaned data
fwrite(final_dataset_housemarket, '../../gen/analysis/input/final_dataset_housemarket.csv')
fwrite(final_dataset_housemarket, '../../gen/data-preparation/output/final_dataset_housemarket.csv')
