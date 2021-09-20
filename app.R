library(shiny)
library(shinyWidgets)
library(shinyBS)
library(DT)
library(tidyverse)
library(dplyr)
library(reshape2)
library(recommenderlab)

source("load_data.R", local = TRUE)$value

ui <- fluidPage(
  sidebarPanel(
    h2("Introduction"),
    h5("This shiny app is an example for a category recommender based on 
       the datasets from Olist, the largest department store in Brazilian marketplaces."),
    #We briefly introduced the app.
    uiOutput("tab"),
    h5("To use this recommender, select up to 5 categories from the dropdown 
      menue and rate them 0 or 1, where 0 = you did not buy the product and
      1 = you did buy the product. When you press the run button a
      category recommendation based on your rating will be displayed."),
    #In this part we explained how our app works. 
    #We decided to work with categories in the selection as well as for the resulting recommendation.
    br(),
    h2("Select and rate categories"),
    pickerInput(inputId = "category_selection",
                label = "",
                choices = category$product_category_name_english,#We use the categories for the selection process.
                selected = category$product_category_name_english[1:2],
                options = pickerOptions(
                  actionsBox = FALSE,
                  maxOptions = 5 #We change the maximum of outputs to 5.
                ), 
                multiple = TRUE),
    h4(" "),
    uiOutput("category_selection01"),
    uiOutput("category_selection02"),
    uiOutput("category_selection03"),
    uiOutput("category_selection04"),
    uiOutput("category_selection05"),
    #Since we limited the amount of outputs to 5, there can only be up to 5 categories selected.
    actionButton("run", "Run")
  ),
 mainPanel(
   tableOutput("recomm")
  )
 )

server <- function(input, output, session) {
  
  source("ui_server.R", local = TRUE)$value
  source("data_server.R", local = TRUE)$value
  
  url <- a("here", href="https://www.kaggle.com/olistbr/brazilian-ecommerce")
  output$tab <- renderUI({
    tagList("You can find the datasets ", url, ".")
    #In this part we inserted the link to the datasets from Olist on Kaggle.
  })
}

shinyApp(ui = ui, server = server)
