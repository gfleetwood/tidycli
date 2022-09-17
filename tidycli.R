#!/usr/bin/Rscript

library(tidyverse)
library(textclean)

# Example to try:

# ls |> 
# map_chr(x, ~ paste(.x, "test", sep = "_")) %>%
# map_chr(~ paste(.x, "tset", sep = "_"))

cat('
      This shell is R aware. So you can, in theory, run any R commands.
      The only addition is the "|>" operator. This is the same as the new base R pipe, but 
      in this shell it\'s used to separate base commands from R ones. For example:
      
      ```
      ls @> 
      map_chr(x, ~ paste(.x, "test", sep = "_")) %>%
      map_chr(~ paste(.x, "tset", sep = "_"))
      ````
      
      The shell will split the command based on the pipe and send the first part, "ls", to the bash shell
      to get a list of all the files and folders. This willl then be based on to the 
      second part of the command (the two maps) in an R environment and evaluated.
      
      This shell scratches an itch to use these R tools for quick processing at the cli.
')

cat("\n\n**tidycli (type 'exit' to quit)**\n")

while(TRUE)
{
      
  cat("\n> ")
  var = readLines("stdin", n = 1)
  
  if(var == "") next
  if(var == "exit") break
  
  cmds = unlist(str_split(var, fixed("@>")))
  
  if(is.na(cmds[2])){
    cat(system(var, intern = T))
  } 
  else {

    r_code = parse(text = paste('function(x)', cmds[2]))
    f = eval(r_code)
    bash_cmd = cmds[1]
    result = system(bash_cmd, intern = T)
    cat(f(result))
  }
  

}


