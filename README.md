### Introduction

In this project, while being part of a team I created a recommender system for an e-commerce website. I used a hybrid recommender system that encompasses three methods: Popular, Random and Item Based Collaborative Filtering. As a final deliverable, the code creates a Shiny dashboard that helps the user explore the results.

Data was sourced from kaggle.com and represents anonimized user data from the Brazilian e-commerce website Olist.
https://www.kaggle.com/olistbr/brazilian-ecommerce

### Explanation of files
- app.R = it builds the shiny app
- data_server.R = it builds the recommandations based on the input from the user
- load_data.R = reads the data files, cleans them and creats the recommender
- ui_server.R = creates the user interface of the Shiny dashboard

### For the Shiny app
#### Required Inputs: 
- System Inputs: Data sets from Olist
- User input: selection of up to 5 product categories in english, rating of each selected category 
(0=user did not buy the product, 1=user did buy the product), run button

#### Output:
- Table of 5 product categories in english that are recommended by using the hybrid recommender.

