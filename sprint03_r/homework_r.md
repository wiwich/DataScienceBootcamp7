# Homework

1. Create Pizza Shop Chatbot
2. Create Rock Paper Scissors game, and show results

## Pizza Chatbot
code in file `pizzaChatbot.R`
```
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
```

## Rock Paper Scissors Game
Code in file `rockPaperScissorsGame.R`
```
convertResult <- function(inp){
  if(inp == 0) return("Rock")
  else if(inp == 1) return("Paper")
  else return("Scissors")
}
checkResult <- function(player, bot_player){
  if(player == bot_player) return("Tie!")
  else if(player - bot_player == 1 | player - bot_player == -2) return("You Win!") 
  else return("Bot Win!")
}
playgame <- function(){
  # 0 - Rock
  # 1 - paper
  # 2 - scissors
  print("Welcome to Rock Paper Scissors Game!!")
  print("What is your name?")
  player_name <- readLines("stdin",n=1)
  print(paste("Nice to meet you ", player_name))
  play_more = "Y"
  player_score = 0
  bot_score = 0
  round = 0
  while(play_more!="N" & play_more!="n"){
    round = round+1
    print("Please choose Number (0-Rock / 1-Paper / 2-Scissors)")
    player <- strtoi(readLines("stdin", n=1))
    bot_player <- sample(0:2, 1)

    if(checkResult(player, bot_player)=="You Win!"){
      player_score = player_score + 1
    } else if(checkResult(player, bot_player)=="Bot Win!"){
      bot_score = bot_score + 1
    }
    print(paste("Player: ",player,"-",convertResult(player)))
    print(paste("Bot: ",bot_player,"-",convertResult(bot_player)))
    print(paste(checkResult(player, bot_player)))
    print(paste("Score[You:Bot]: ",player_score,":",bot_score))

    
    
    print("Play more? (Y/N)")
    play_more <- readLines("stdin",n=1)    
  }
  print(paste("See you next time ", player_name,"!"))
}  
playgame()
```