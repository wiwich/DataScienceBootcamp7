pizzaOrder <- function(){
  print("What flavor do you like (hawaiian/seafood/pepperoni): ")
  flavor <- readLines("stdin", n=1)
  print("Which size would you like (S/M/L): ")
  
  size <- readLines("stdin", n=1)
  print("Would you like Extra Crust? (Y/N): ")
  
  ex_crust <- readLines("stdin", n=1)
  if(ex_crust == "Y" | ex_crust == "y") crust <- "Extra crust"
  else if (ex_crust == "N" | ex_crust == "n") crust <- "Classic Crust"
  else "Classic Crust"
  
  pizza <- paste(toupper(flavor),"pizza, size",size,"-",crust)
  return(pizza)
}
pastaOrder <- function(){
  print("What flavor do you like (cabonara/spicy): ")
  flavor <- readLines("stdin", n=1)
  pasta <- paste(toupper(flavor),"pasta")
  return(pasta)
}
drinksOrder <- function(){
  print("Any drinks (Coke/Lemonade/Water): ")
  return(toupper(readLines("stdin", n=1)))
}

chatbot <- function(){
  ord_count = 1
  print("Welcome to Pizza ABC!")
  order <- ""
  while(order != "quit"){
    print("What would you like to order today (pizza/pasta/drinks): ")
    order <- readLines("stdin", n=1)
    if(order == "pizza"){
      order <- pizzaOrder()
    } else if(order == "pasta"){
      order <- pastaOrder()
    } else if(order == "drinks"){
      order <- drinksOrder()
    } else{
      print("Not Available! please try again.")
    }
    if(ord_count == 1){
      ord_list <- order
    } else{
      ord_list <- append(ord_list, order)
    }
      
    print("--- Your Orders ---")
    print(matrix(ord_list, length(ord_list)))
    print(paste("Total: ",ord_count))
    print("------------")
    
    print("Anything else? (Y/N)")
    next_ord <- readLines("stdin",n=1)
    if(next_ord=="N" | next_ord=="n") break
    ord_count = ord_count + 1
  }
  print("Thank you!")  
    
}
chatbot()