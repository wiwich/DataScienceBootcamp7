## HW01 - nycflights13 explorations

library(nycflights13)

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