#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Predict Car weight from fuel consumption"),
  h4("using R mtcars package. (GGraner, 23.November.2016)"),
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       h3("Slider Input"),  
       sliderInput("sliderCars",
                   "What is the fuel consumption (litres per 100 km) of the car?",
                   min=6,max=23,value=12),

       checkboxInput("showModel1", "Show/Hide Model 1", value=TRUE),
       checkboxInput("showModel2", "Show/Hide Model 2", value=TRUE)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
  
       plotOutput("Plot1"),
       h3("Model 1 predicted weight (in kilogram):"),
       textOutput("pred1"),
       h3("Model 2 predicted weight (in kilogram):"),
       textOutput("pred2")
      
    )
  )
))



