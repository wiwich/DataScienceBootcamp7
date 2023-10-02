# R Programming

## Programming Concepts
1. variable
2. data type
3. data structures
4. control flow
5. function

### Variable
```
# create variable
var1 <- "Hello"

# display variable
print(var1)
```

### Data Type
- numeric
- character (string, text)
- logical (boolean)
- date

example: check data type
```
# check data type
var1 <- "Hello"
class(var1) # return character

is.numeric(var1) # check numeric, return FALSE
is.character(var1) # check character, return TRUE
is.logical(TRUE) # check logical, return TRUE
```

example: create date varaible
```
# create date variable
d <- as.Date("2023-09-27")
```

example: convert data type
```
# convert character to numeric
x <- "100"
x <- as.numeric(x)

# convert numeric to character
x <- 567
x <- as.character(x)

# convert bool to numeric
x <- TRUE
x <- as.numeric(x) # return 1
```

### Data Structures
1. Vector
2. Matrix
3. List
4. Dataframe

example: vector
```
# create vector
num_vec <- 1:10 # create vector 1 to 10
seq_vec <- seq(1,10,2) # create sequence vector from 1 to 10 by 2
rep_vec <- rep("Hi",3) # create replicate "Hi" 3 times
animal_vec <- c("dog", "cat", "koala")

# append vector
append("penguin", animal_vec)

# get element from vector
animal_vec[3] # return "koala", index vector start with 1

# update value in vector
animal_vec[2] <- "rabbit"

# check not available value
is.na(animal_vec)
```

example: matrix
```
# create matrix from 1 to 10, 2 rows, and 5 columns
x <- matrix(1:10, 5, 2)

# aggregate matrix
m1 <- matrix(1:10, ncol=5, byrow=TRUE) 
# return
#  1  2  3  4  5 
#  6  7  8  9  10

m1 * 2
# return
#  2  4  6  8 10
# 12 14 16 18 20

#---------

(m1<-matrix(c(2,4,5,1, ncol=2))
# return  
#  2  5
#  4  1
(m2<-matrix(c(1,2,5,5), ncol=2))
# return  
#  1  5
#  2  5
m1 + m2 # element white computation
# return  
#  3 10
#  6  6
m1 * m2
# return  
#  2 25
#  8  5
m1 %*% m2 ## matrix multiplication .dot(product)
# return  
#  12  35
#   6  25
```

example: dataframe
- `str(df)` get structure detail of 'df' dataframe
- `head(df)` get preview first 6 rows
- `tail(df)` get preview last 2 rows
- `View(df)` preview dataframe
- `summary(df)` get statistic summary of dataframe 
- `write.csv(df,<filename.csv>)` export csv file
```
# create variable
# create variable
id <- 1:5
friends <- c("jack", "kevin", "mary", "anna", "belle")
age <- c(34, 32, 28, 25, 29)
movie_lover <- c(T, F, F, T, T)

# create dataframe
df <- data.frame(id, friends, age, movie_lover)

# export csv file
write.csv(df, "friends.csv", row.names=False) # exclude row index

# get column 'id' from dataframe 'df' 
df$id # or
df[["id"]]

# create new column 'city' in dataframe 'df'
df$city <- c(rep("bangkok",3),rep("london",2))

# delete column 'city'
df$city <- NULL

# change element in 'friends' column to upper letter
df$friends <- toupper(df$friends)
# change element to lower letter
df$friends <- tolower(df$friends)

# aggregate 'age' column
df$age <- df$age + 1
```

example: list
```
# create list
my_friend <- list(
    customer01 <- list(
	name = "tony",
	age = 34,
	city = "BKK"
)
customer02 <- list(
	name = "mary",
	age = 28,
	city = "LON",
	email = 'mary@google.com"
)
customer03 <- list(
	name = "kevin",
	age = 26,
	city = "JAP"
	address = "Mount Fuji."
)
# create list of all customer (NO-SQL / JSON)
all_customers <- list(
	customer01, customer02, customer03
)
# or
all_customer <- list(
	tony = customer01, 
	mary = customer02,
	kevin = customer03
)
```

### Control Flow (if, for, while)
example: if
```
my_grade = 88
if (score >= 80) {
    print("Passed")
} else {
    print("Failed")
}

# return "Passed"
```

example: for loop
```
fruit <- c("apple", "mango", "orange", "durian", "grape")

for (f in fruits) {
	print(toupper(f)) 
}

# return "APPLE" "MANGO" "ORANGE" "DURIAN" "GRAPE"
```

example: while loop
```
count <- 0
while(count<10) {
	print("hello world")
	count <- count+1 # counter
}
```

### Function
```
## argument function
# user defined function
add_two_nums <- function(val1, val2) {
	return (a+b)
}
add_two_nums(5,10) # return 15
# or
add_two_nums <- function(val1, val2) {
	a+b
}
add_two_nums(7,10) # return 17
# or
add_two_nums <- function(a,b) a+b
add_two_nums(5,5) # return 10

## void function
greeting <- function() print("hi!")
greeting() # return "hi!"

## input function
greeting_name <- function() {
	name <- readline("What is your name? ")
	print(paste("Hello!",name)) # concat text
}
greeting_name()
# return What's your name? 
# answer: wi
# return "Hello! wi"

double_value <- function(){
	value <- readline("Give me a value: ")
	value*2 
}
double_value()
# return Give me a value: 
# answer: 50
# return 100

## multiple argument function
check_weather <- function(temp=35, day="Monday"){
	text <- paste("Today: ", day, "; temperature: ",temp)
	return(text)
}
check_weather()
# return "Today: Monday ; temperature 35"
check_weather(38, "Tuesday")
# return "Today: Tuesday ; temperature 38"
check_weather(day="Sunday", temp=37) # swap argment
# return "Today: Sunday; temperature 37"
```