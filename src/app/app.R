library(shiny)
library(plotly)
library(DT)
options(scipen = 999)

dataset_housemarket <- read.csv("final_dataset_housemarket.csv")
dataset_housemarket$city <- as.factor(dataset_housemarket$city)



ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      h2("Average Selling duration"),
      selectInput(inputId = "city", label = "City:",
                  choices = levels(dataset_housemarket$city),
                  selected = "eindhoven"),
      sliderInput(inputId= "constructionyear", 
                  label= "Constructionyear:",
                  min= min(dataset_housemarket$constructionyear), 
                  max= max(dataset_housemarket$constructionyear), 
                  value = c(min(dataset_housemarket$constructionyear), max(dataset_housemarket$constructionyear)), sep= "", step= 1),
      sliderInput(inputId= "price", label= "Price:",
                  min= min(dataset_housemarket$price), max= 1000000,
                  value = c(min(dataset_housemarket$price), max(dataset_housemarket$price)), sep= ".", step= 10000),
    submitButton(text = "Create my plot!"),
  ),
  mainPanel(
    plotOutput(outputId= "houseplot")
  )
  )
)



server <- function(input, output){
  output$houseplot <- renderPlot(
    dataset_housemarket %>%
      filter(city == input$city,
             constructionyear >= input$constructionyear) %>%
      ggplot(aes(x = price,
                 y = sellingduration)) +
      xlab("Selling Price") + ylab("Selling Duration") +
      geom_point() +
      scale_x_continuous(limits= input$price) +
      theme_minimal()
  )
}
shinyApp(ui = ui, server = server)