## HW02 - pizza restaurant
# connect to SQL server (postgresql)

library(RPostgreSQL)
library(tidyverse)

con <- dbConnect(PostgreSQL(),
                 host = "peanut.db.elephantsql.com", #server
                 port = 5432,
                 user = "fnksjppr", # User & Default database 
                 password = "<password>", # TO EDIT!
                 dbname = "fnksjppr", # User & Default database
                 )

# List Table in database
dbListTables(con)
# if no database, return 'character(0)'

# HW2 - Pizza restuarant

pizza_menu <- data.frame(
  id = 1: 5,
  name = c("hawaiian", "seafood", "pepperoni", "pasta", "coke"),
  price = c(12, 15, 11.5, 7.5, 3)
)

customers <- data.frame(
  id = 1:4,
  name = c("Luke", "Jenny", "Jake", "Ben"),
  city = c("London", "Melbourne", "Bangkok", "Tokyo")
)
orders <- data.frame(
 id = 1:7 ,
 customer_id = c(1, 3, 3, 4, 4, 2, 4),
 menu_id = c(1, 1, 5, 2, 4, 1, 3)
)
db

# write table to postgress
dbWriteTable(con, "pizza_menu",pizza_menu)
dbWriteTable(con, "customers", customers)
dbWriteTable(con, "orders", orders)

# get query
order_trx <- "SELECT 
                    ord.id,
                    cus.name, 
                    cus.city,
                    menu.name,
                    menu.price
                  FROM orders ord
                  JOIN customers cus
                  ON ord.customer_id = cus.id
                  JOIN pizza_menu menu
                  ON ord.menu_id = menu.id
                  ORDER BY ord.id;
"
dbGetQuery(con, order_trx)

# close connection
dbDisconnect(con)
