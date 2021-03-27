#Makefile
#By Wouter van Akkeren

#All: ../../gen/data-preparation/output/final_dataset_housemarket.csv
priority: ../../gen/data-preparation/output/final_dataset_housemarket.csv


#step1: download, store and print txt file with downloaded cities
../../gen/data-preparation/input/downloaded.txt: download.R
	Rscript download.R

#step2: add city column and merge cities in one datafile
../../gen/data-preparation/temp/merged_cities.csv: addcityname_and_merge.R ../../gen/data-preparation/input/downloaded.txt
	Rscript addcityname_and_merge.R

#step 3: cleaning
../../gen/data-preparation/output/final_dataset_housemarket.csv ../../gen/analysis/input/final_dataset_housemarket.csv: cleaning.R ../../gen/data-preparation/temp/merged_cities.csv
	Rscript cleaning.R	

