# The housing market in the Netherlands: A Fun(da) Analysis						
### Motivation

The housing shortage in the Netherlands in the last few years has led to a serious housing crisis experienced today. Especially young people are encountering major difficulties in finding the right place for an affordable price. Also during the last political party elections, the housing crisis was a very much debated topic. For this reason, Team 2 realized the significance of creating a dataset that can give both house seekers and house sellers more insights into the housing market in the Netherlands. Mainly, the aim of creating this dataset is to make a house’s selling duration more predictable. For both parties this can lead to a more efficient housing market: house sellers can better predict for what period their house will be on sale, whilst house seekers get insights into the selling rate in a particular city.
The raw data (retrieved from [https://www.funda.nl/koop/INSERTCITYNAME/verkocht/]() through webscraping) contains all of the information that is provided on the house product page for four cities: _Dordrecht, Eindhoven, Leeuwarden, and Maastricht_. To answer this research question, the 'selling price' and 'selling duration' variables are used. The other variables can be used for exploratory research by people interested in the Dutch housing market.

## Details
### Inputs and outputs
* Input: `selling price, city, constructionyear`
* Output: `selling duration`



### Description of the methodology
To create the dataset, information from the relevant Funda page with the sold houses is scraped. This is possible on city-, province-, and for the Netherlands as a whole, and can be achieved by adapting the link below for the wanted city or province: 
[https://www.funda.nl/koop/INSERTCITYNAME/verkocht/](). Every data entity in the dataset represents a house that has been sold in the past year. This repository contains raw data collected on March 22, 2021 for the following cities: Dordrecht, Eindhoven, Leeuwarden, and Maastricht. This is a dataset with a total of 6,631 entities. 

The datasets for the four cities are downloaded from a private Google drive folder, and are merged into one full dataset. This dataset contained numerous unnecessary variables in terms of our research question. These were removed resulting in a dataset with the following variables: address, city, selling price, selling duration and construction year. Variables that contained one or more 'NA' values were taken out as well, resulting in a dataset with 6,633 entities. 

To look into the relationship between selling price and selling duration, a regression analysis is performed. This shows how much the dependent variable (selling duration) changes in response to one unit change of the independent variable (selling price). Additionally, a Shiny app is created with two sliders, to visualize the effect of selling price on selling duration. The second slider represents the 'construction year'. With this, it is possible to select a subset of houses or if kept at maximum width, contain all houses.

### Results
#### Regression Analysis: 
The resulting regression equation is as follows: 

**Selling duration = 6.38 + 0.000129 * Price**

The p-value is very small, which means that there is a significant effect. This effect is very small, yet positive (0.00012867853603877). 

#### Shiny App:
The app can be opened by clicking on the following URL: [https://wouter1997.shinyapps.io/averagesellingduration/](). The Shiny App has two sliders for the variables 'construction year' and 'selling price'. 
Construction year is a variable that was left out of the final regression analysis because it showed an incredibly weak relationship. However, it is included in the Shiny app because it allows for the selection of a subset of houses.  When people use the app and are interested in a particular price, they can choose themselves whether they want to incorporate all listed houses or limit to only recently built houses. *For example: houses built between 2005 and 2022 in Eindhoven, in the range of €247,500  and €327,500 are usually sold within 50 days.*


## Running instructions
### Dependencies
* Make
* R  
* Required R packages can be found in the source code file (lines starting with library)


### Running the code

In your command line/ terminal:

* Navigate to the directory in which this readme file resides, by typing `pwd` (Mac) or `dir` (Windows) in terminal
 * if not, change your working directory by typing "`cd yourpath/`" 

*  In your command line/ terminal, type: "`make`"

* *Generated files:*
 * Dataset housemarket: `gen/data-preparation/output/final_dataset_housemarket.csv`
 * Dataset merged cities: `gen/data-preparation/temp/merged_cities.csv` 
 * Linear regression results: `gen/analysis/Linearregression.csv` 
 * Plots: `src/analysis/RPlots.pdf`


 
### Directory structure 


```.
├── Investigating-funda
│   ├── gen
|		├── analysis  
│   	  	└── input
|			└── output
|		├── data-preparation  
│   	  	└── input
|			└── output
|			└── temp
│   ├── src
|		├── analysis
|		├── data-preparation  	
|		├── app
│   ├── data
```
	
 		
## More resources

The Shiny app can be found here: [https://wouter1997.shinyapps.io/averagesellingduration/.]()

## About

Contributors to the repository are Wouter van Akkeren and Fokje Wymenga. This is a project for the course Data Preparation and Workflow Management, at Tilburg University.
