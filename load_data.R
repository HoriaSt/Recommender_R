#we use part of the code from the past assignment, with some changes
#now that we know which recommenders we will use and what data we need

#reading the data
customers <- read.csv ("olist_customers_dataset.csv")
items <- read.csv ("olist_order_items_dataset.csv")
orders <- read.csv ("olist_orders_dataset_short.csv",sep=';')
products <- read.csv ("olist_products_dataset_short.csv",sep=';')
category <- read.csv ("product_category_name_translation.csv")


#the first column from the category table should be the same with the second column of products
a <- names (category) 
b <- names (products)
if (a[1] != b[2]){
  a[1] = b[2]
} 
names(category) <- a #we modify the column names 


#we only select the columns we need
items_clean <- items %>% select("order_id", "product_id", "price" )
customers_clean <- customers %>% select("customer_id", "customer_unique_id")


#merging all the datasets for the a final datatset
data_complete <- merge (orders, items_clean, by="order_id")
data_complete_1 <- merge (data_complete, customers_clean, by="customer_id")
data_complete_2 <- merge (data_complete_1, products, by="product_id")
data_complete_final <- merge (data_complete_2, category, by="product_category_name")


#we format the data for the rating matrix
data_clean <- data_complete_final %>% select("customer_unique_id", 
                                             "product_id", "price",
                                             "order_purchase_timestamp", 
                                             "product_category_name_english" )
data_clean <- data_clean %>% distinct()


#we build the binary rating matrix
rating <- dcast(data_clean, customer_unique_id ~ product_category_name_english)
rating <- as.matrix(rating[,-1])
rating_mat <- as(rating,"binaryRatingMatrix")


#we train the recommender, in this case an hybrid one, comprising
#the popular, the random and the item-based collaborative filtering (IBCF) ones
#each having the same weight
rec_mod <- HybridRecommender(
  Recommender(rating_mat, method = "POPULAR"),
  Recommender(rating_mat, method = "RANDOM"),
  Recommender(rating_mat, method = "IBCF"),
  weights = c (0.33,0.33,0.33)
)




