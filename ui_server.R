#here, we just changed the variable names and the limits for the sliders
#the slider can only take 2 values: 0 or 1
output$category_selection01 <- renderUI({
  
  if(length(input$category_selection) > 0){
    
    fluidRow(
      column(
        shinyBS::popify(
          el =  sliderInput (inputId = input$category_selection[1],
                           label = input$category_selection[1],
                           max = 1,
                           min = 0,
                           step = 1,
                           value = 0),
          title = "",
          placement = "right"
        ),
        width = 10
      )
    )
    
  }
})

output$category_selection02 <- renderUI({
  
  if(length(input$category_selection) > 1){
    
    fluidRow(
      column(
        shinyBS::popify(
          el = sliderInput(inputId = input$category_selection[2],
                           label = input$category_selection[2],
                           max = 1,
                           min = 0,
                           step = 1,
                           value = 0),
          title = "",
          placement = "right"
        ),
        width = 10
      )
    )
    
  }
})

output$category_selection03 <- renderUI({
  
  if(length(input$category_selection) > 2){
    
    fluidRow(
      column(
        shinyBS::popify(
          el = sliderInput(inputId = input$category_selection[3],
                           label = input$category_selection[3],
                           max = 1,
                           min = 0,
                           step = 1,
                           value = 0),
          title = "",
          placement = "right"
        ),
        width = 10
      )
    )
    
  }
})

output$category_selection04 <- renderUI({
  
  if(length(input$category_selection) > 3){
    
    fluidRow(
      column(
        shinyBS::popify(
          el = sliderInput(inputId = input$category_selection[4],
                           label = input$category_selection[4],
                           max = 1,
                           min = 0,
                           step = 1,
                           value = 0),
          title = "",
          placement = "right"
        ),
        width = 10
      )
    )
    
  }
})

output$category_selection05 <- renderUI({
  
  if(length(input$category_selection) > 4){
    
    fluidRow(
      column(
        shinyBS::popify(
          el = sliderInput(inputId = input$category_selection[5],
                           label = input$category_selection[5],
                           max = 1,
                           min = 0,
                           step = 1,
                           value = 0),
          title = "",
          placement = "right"
        ),
        width = 10
      )
    )
    
  }
})