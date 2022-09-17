# tidycli

tidycli is an R powered shell. In theory you can run any R commands. The only addition is the "@>" operator used to separate bash commands from R ones. For example:
      
```
ls @> 
map_chr(x, ~ paste(.x, "test", sep = "_")) %>%
map_chr(~ paste(.x, "tset", sep = "_"))
````

The shell will split the command based on the pipe and send the first part, "ls", to the bash shell to get a list of all the files and folders.
This willl then be based on to the second part of the command (the two maps) in an R environment and evaluated.
      
This shell scratches an itch to use these R tools for quick processing at the cli
