# tidycli

## Overview

tidycli is an R powered shell to use R's powerful tools for quick processing at the cli. It was inspired by https://www.nushell.sh/. In theory you can run any R commands. The only addition is the "@>" pipe used to separate bash commands from R ones. For example:
      
```
ls @> map_chr(x, ~ paste(.x, "test", sep = "_")) %>% map_chr(~ paste(.x, "tset", sep = "_"))
````

Where `x` references the output of `ls`.

The shell will split the command based on the "@>" pipe and send the first part, "ls", to the bash shell to get its output - a list of all the files and folders in the directory:

```
[1] "LICENSE"   "README.md" "tidycli"
```

The second part of the command (the maps) becomes a function `f`:


```
f <- function(x) map_chr(x, ~ paste(.x, "test", sep = "_")) %>% map_chr(~ paste(.x, "tset", sep = "_"))
```

Lastly the bash output is passed to the function in an R environment and evaluated. 

```
[1] "LICENSE_test_tset"   "README.md_test_tset" "tidycli_test_tset"
```

All columnar output is treated as csv tables, so running:

`ls -l` 

outputs:

```
[1] "total,20,,,,,,,"                                           
[2] "-rw-rw-r--,1,user,user,226,Sep,18,04:09,file.csv"      
[3] "-rw-rw-r--,1,user,user,1067,Sep,17,15:21,LICENSE"      
[4] "-rw-rw-r--,1,user,user,1014,Sep,18,07:27,README.md"    
[5] "-rw-rw-r--,1,user,user,191,Sep,18,06:47,std_out_to_csv"
[6] "-rwxrwxr-x,1,user,user,2512,Sep,18,07:23,tidycli.R" 
```

Note the padding on the first line to ensure all rows have the same number of columns. You can then use this as a dataframe in R by running:

```
ls -l @> read.table(text = x, sep = ",", header = FALSE, stringsAsFactors = FALSE)
```

Which outputs:

```
          V1 V2     V3     V4   V5  V6 V7    V8             V9
1      total 20                 NA     NA                     
2 -rw-rw-r--  1 user user  226 Sep 18 04:09       file.csv
3 -rw-rw-r--  1 user user 1067 Sep 17 15:21        LICENSE
4 -rw-rw-r--  1 user user 1513 Sep 18 07:28      README.md
5 -rw-rw-r--  1 user user  191 Sep 18 06:47 std_out_to_csv
6 -rwxrwxr-x  1 user user 2512 Sep 18 07:23      tidycli.R
```

## Installation

Take tidycli and run `chmod+x tidycli` to make it executable. Then put it in a bin folder like `/usr/bin`. Activate the shell with `tidycli` at the command line.

## TODO

* Accept multiline input
* Also user to clear screen
* Integrate gnu readline shortcuts