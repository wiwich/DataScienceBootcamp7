# Data Transformation

## Package Library for R
- `glue`: interpreted string literals
- `RSQLite`: SQLite interface
- `lubridate`: working with Dates and Times
- `tidyverse`: opinionated collection 
- `googlesheet4`: google sheet
- `gtrendsR`: google trends

## Dataset
- `mtcars` dataset: https://gist.github.com/seankross/a412dfbd88b3db70b74b
- `nycflights13` dataset get from install package `nycflights13`

## String Template

example for `glue()`
```
library(glue)
my_name <- "Heiji"
age <- 27
city <- "BKK"
text <- glue("Hello my name is {my_name} and I'm {age} years old and I live in {city}.")
print(text)
# return "Hello my name is Heiji and I'm 27 years old and I live in BKK."
```
example for `library(lubridate)`
```
library(lubridate)

d <- "2023-06-17" # data type: character
d <- ymd(d) # convert char to date

ymd("2023 JUNE 17") # "2023-06-17"
dmy("17 June 2023") # "2023-06-17"
dmy("26-Oct-2023") # "2023-10-26"
mdy("January 15, 2023") # "2023-01-15"

# manipulate day, month, year
year(d)
month(d)
day(d)
week(d)
```

## tidyverse
**tidyverse - dplyr**
1. select
2. filter
3. arrange
4. mutate (create new column)
5. summarize + group_by (aggregate in SQL)

get `mtcars` dataset from https://gist.github.com/seankross/a412dfbd88b3db70b74b

example for tidyverse
```
library(tidyverse)

## 1. select
# select(<df>, <col1>, <col2>, ...)
select(mtcars, mpg, cyl, disp, hp, am)

# select column and set column_name
select(mtcars, mile_per_gallon = mpg, weight = wt)

# select column_name that start with a
select(mtcars, starts_with("a"))
# select column_name that end with p
select(mtcars, end_with("p"))
# select column_name that contains a
select(mtcars, contains("a"))
```
```
## 2. filter
# filter by condition
filter(mtcars, hp>100 & disp>300 & mpg>15)

# filter by regular expression using 'grep' and 'grepl'
# grep return index
# grepl return bool

# get state that start with 'A'
grep("^A", state.name) # return index e.g. 1 2 3 4
grepl("^A", state.name) # return bool e.g. TRUE TRUE TRUE TRUE FALSE

# change rownames to column 'model'
mtcars <- rownames_to_column(mtcars, var="model")

# get car's model that start with 'M'
filter(mtcars, grepl("^M", model)) # return row that model start with 'M'

# get car's model that end with 'C'
filter(mtcars, grepl("c$", model)) 

# get car's model that contains number (at lease 1 number)
filter(mtcars, grepl("[0-9]+", model))
```
```
## data pipeline
# dpylr the right way %>% (PIPE)
# data %>%
#   pipeline1() %>%
#   pipeline2() %>%
#   pipeline3()
mtcars %>%  # send dataframe 'mtcars' to function
 select(mtcars, mpg, am, hp) %>%
 filter(hp > 100, mpg > 15)

# simple pipeline
mtcars %>% 
	select(mpg, hp, wt) %>% # optional
	filter(mpg >= 15) %>%
	group_by(am) %>%
	summarise(n=n())
```
```
## 3. arrange (sorting)
# sort data
arrange(mtcars,mpg) # default min->max

arrange(mtcars, -mpg) # sort by max to min
#or
arrange(mtcars, desc(mpg)) # sort by max to min

# sort by multiple columns
arrange(mtcars, model, desc(mpg)) # sort by (1) model(A-Z) (2) mpg (max-min)

# sort 1.am (min to max) 2.mpg (max to min)
mtcars %>%
 select(am, mpg) %>%
 arrange(am, desc(mpg))
```
```
## 4. mutate - create new columns (always on the right side)
# single mutate
mtcars %>%
 select(mpg) %>%
 filter(mpg>20) %>%
 mutate(mpg_double = mpg*2)

# multiple mutate
mtcars %>%
 select(mpg) %>%
 filter(mpg>20) %>%
 mutate(model = tolower(model), # replace 'model' column
				mpg_double = mpg*2,
				mpg_add_five = mpg+5,
				mpg_log = log(mpg))

```
```
## 5. summarise + group_by 
# summarise
summarise(mtcars, avg_mpg = mean(mpg)) # return mean of 'mpg'

# multiple summarise
mtcars %>%
 summarise(avg_mpg = mean(mpg),
						sum_mgp = sum(mpg),
						min_mpg = min(mpg),
						max_mpg = max(mpg),
						n = n(),
						std_mpg = sd(mpg),
						var_mpg = var(mpg),
						med_mpg = median(mpg))

# group by
# mutate am, 0=auto, 1=manual 
mtcars <- mtcars %>%
 mutate(am = ifelse(am==0, "Auto","Manual")

# group by + summarise
# group by 'am'
mtcars %>%
 group_by(am) %>%
 summarise(avg_mpg = mean(mpg),
						sum_mgp = sum(mpg),
						min_mpg = min(mpg),
						max_mpg = max(mpg),
						n = n(),
						std_mpg = sd(mpg),
						var_mpg = var(mpg),
						med_mpg = median(mpg))
```

## UNION Dataframe
```
# union dataframe by row
df1 <- mtcars %>%
	filter(hp > 300)

df2 <- mtcars %>%
	filter(hp <= 80)

# df1 stack with df2
bind_rows(df1, df2)
# or
full_df <- df1 %>%
	bind_rows(df2)
```
```
# union by multiple rows
df1 <- mtcars %>%
	filter(hp > 300)

df2 <- mtcars %>%
	filter(hp <= 80)

df3 <- mtcars %>%
	filter(am == "Auto")

df4 <- mtcars %>% 
	filter(mpg >= 20)

# stack a lot of dataframe together
list_df <- list(df1, df2, df3, df4)
full_df <- bind_rows(list_df)
```
`bind_cols` is different from `join`.
- `bind_cols` is comcate dataframes.
- `join` is combine dataframe by specific column that have the same values. 
```
# combind multiple columns
df1 <- data.frame(id=1:3, 
									name=c("A","B","C")
# return 
# id  name
#  1   A
#  2   B
#  3   C
df2 <- data.frame(country=c("US","UK","TH"))
bind_cols(df1,df2)
# return 
# country
#  US
#  UK
#  TH

# bind_cols()
bind_cols(df1, df2)
# return
# id  name  country
#  1   A     US
#  2   B     UK
#  3   C     TH
```
```
# join multiple inner
df1 <- data.frame(id=1:3, 
									name=c("A","B","C")
df2 <- data.frame(id=c(3,2,1),
									country=c("US","UK","TH"))
df3 <- data.frame(id= 1:4,
									classes = c("data", "data", "ux", "business"))
df1 %>%
	inner_join(df2)) %>%
	inner_join(df3))
# if don't specific column, default join common name ('id')
```

## Missing values
example: delete NULL values
```
# delete NULL value
df1 %>%
	full_join(df2, by="id") %>%
	drop_na()
```
example replace NA with value
```
df <- data.frame(id= 1:5,
									classes = c("data", NA, "ux", "business",NA))
df$classes <- replace_na(df3$classes, "data engineer")
# or
df %>%
	mutate(clean_class = replace_na(classes, "woohoo!"))
```
example: replace NA with mean
```
df_ <- data.frame(id= 1:5,
									classes = c("data", NA, "ux", "business",NA),
									score = c(2.5, 2.8, 2.9, 3, NA))

df5 %>%
	mutate(classes=replace_na(classes, "data engineering",
	# mean imputation
	score = replace_na(score, mean(score, na.rm=T))) # na.rm means remove missing value before find mean cuz cannot find mean with NA value
```

## Case: New York City Flights 2013
import library
```
library(nycflights13)
View(flights)
```
review dataframe structure
```
glimpse(flights)
```
make questions
- find flights each month
- find distinct carrier
- find carrier most flight in Feb 2013
```
# find flights each month
flights %>%
	group_by(month) %>%
	summarise(n=n())
# or
flights %>%
	count(month)

# find distinct carrier
flights %>% 
	distinct(carrier)

# find carrier most flight in Feb 2013
flights %>% 
	filter(month == 2) %>%
	count(carrier) %>%
	arrange(-n) %>% # sort by max to min
	head(5)
```

## Google Sheet 
import library
```
library(googlesheet4)
```
authenticate
```
gs4_deauth()
```
read google sheet from first sheet
```
url <- "<url link>"
df <- read_sheet(url, sheet=1)
```

## Additional
example: read csv file
```
# read_csv("<link.csv>") from internet
df <- read_csv("https://gist.githubusercontent.com/seankross/a412dfbd88b3db70b74b/raw/5f23f993cd87c283ce766e7ac6b329ee7cc2e1d1/mtcars.csv")
View(df)
```

example: random sample (sampling)
```
df %>% 
	select(model) %>%
	sample_n(3)
```

## PostgreSQL

**elephantSQL**: https://www.elephantsql.com/

**Connect R to SQL server (postgresql)**
- import package: `RPostgreSQL` for postgreSQL (`RMysql` for mySQL, `bigQueryR` for bigQuery)

```
## connect to SQL server (postgresql)
library(RPostgreSQL)

# dbConnect(PostgreSQL(), server, username, password, host, port, dbname)
con <- dbConnect(PostgreSQL(), 
									host = "arjuna.db.elephantsql.com",
									port = 5432, # default fix port for PostgreSQL
									# default port mySQL 3306 (search Google)
									user = "jznjhnsz", # User & Default database
									password = "<password>",
									dbname = "jznjhnsz") # User & Default database

# list table in server
dbListTables(con)

# create database
pets <- data.frame(
	id = 1:3,
	name = c("Donkey", "Unicorn", "Dragon")
)

# write table
dbWriteTable(con, "myPets", pets)

# query data
dbGetQuery(con, "select * from myPets")

# remove table
dbRemoveTable(con, "myPets")

## close connection (always)
dbDisconnect(con)
```