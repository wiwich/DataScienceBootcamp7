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