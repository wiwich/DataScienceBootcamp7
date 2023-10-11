# Homework
1. 5 questions ask about flights dataset from `nycflights13`
2. create database on PostgreSQL about pizza restaurant

## nycflights13
code in the `flightsExplore.r` file
```
## HW01 - nycflights13 explorations

library(nycflights13)

flights

# monthly trends
flights %>% 
  group_by(year, month) %>%
  summarise(n = n()) # count

# distinct airlines
flight_airlines <- inner_join(flights, airlines)
flight_airlines %>% 
  group_by(carrier, name) %>%
  summarise(n_flight = n()) %>%
  arrange(-n_flight)

# frequency of flight roots
flights %>% 
  group_by(origin, dest) %>%
  summarise(root_n = n(),
            root_percent = n()*100/count(flights),
            avg_distance = mean(distance)) %>%
  arrange(-root_n)


# roots delay
flights %>% 
  group_by(origin, dest) %>%
  summarise(avg_delay = mean(arr_delay)) %>%
  arrange(-avg_delay)

# planes with delay
planes_flights <- inner_join(flights, planes, by="tailnum", suffix=c(".flights",".planes"))
planes_flights %>%
  group_by(tailnum, year.planes, type, manufacturer, engine, seats) %>%
  summarise(avg_delay = mean(arr_delay)) %>%
  arrange(-avg_delay)
```


## pizza restaurant
code in the `pizzaDatabase.r` file
```
## HW02 - pizza restaurant
# connect to SQL server (postgresql)

library(RPostgreSQL)
library(tidyverse)

con <- dbConnect(PostgreSQL(),
                 host = "peanut.db.elephantsql.com", #server
                 port = 5432,
                 user = "fnksjppr", # User & Default database 
                 password = "rb28h0WD4eHVQkVelJ2unQlmSM9SvDaE",
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
```