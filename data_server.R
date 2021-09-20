#we format the user input according to our olist data
recomdata <- reactive({
  selected_categories <- category %>%
            filter(product_category_name_english %in% input$category_selection) %>%
            arrange(product_category_name_english) %>% select(product_category_name_english)
  
  #we select the rating gave by the user and add it in the above created list
  for(i in 1:nrow(selected_categories)){
    selected_categories$ratingvec[i] <- input[[as.character(selected_categories$product_category_name_english[i])]]
  }
  
  #we create a vector rating_vec which includes the ratings for all the categories
  #the values are NAs for the ones not mentioned by the user
  category <- category %>% arrange(product_category_name_english)
  rating_vec <- category %>% left_join(., selected_categories, by = "product_category_name_english") %>%
    pull(ratingvec)
    
  #we transform the vector in a matrix
  rating_vec <- as.matrix(t(rating_vec))
  
  #we replace the NAs with 0
  for (i in 1:length(rating_vec))
  {
    if (is.na(rating_vec[i]))
    {
      rating_vec[i] <- 0
    }
  }
  
  #we create the binary matrix
  rating_vec <- as(rating_vec, "binaryRatingMatrix")
  
  #we use our recommender to predict the top 5 categories to recomend
  top_5_prediction <- predict(rec_mod, rating_vec, n = 5)
  top_5_list <- as(top_5_prediction, "list")
  #we format them as a list
  top_5_df <- data.frame(top_5_list)
  colnames(top_5_df) <- "Recommended categories"
  
  #we replace their IDs with the name of the categories
  for (i in 1:length(top_5_df)) {
    top_5_df[i] <- category$product_category_name_english[as.integer(top_5_list[[i]])]
  }
  
  #we return the final result
  return (top_5_df)

})

observeEvent(input$run, {
  recomdata <- recomdata()
  
  #an error is added for when we have less then 2 categories selected by the user
  if(length(input$category_selection) < 2){
    sendSweetAlert(
      session = session,
      title = "Please select more product categories.",
      text = "Please select more product categories.",
      type = "info")
  }
  
  else {
    output$recomm <- renderTable(recomdata)
  }
  
})