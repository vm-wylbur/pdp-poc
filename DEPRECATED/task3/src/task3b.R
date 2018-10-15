# -*- coding: utf-8 -*-
#
# Author: PB
# Maintainer(s): PB
# License: (c) HRDAG 2018, GPL v2 or newer
#
# hrdag/pdp-poc/task3/src/task3b.R
#
# -----------------------------------------------------------

library(jsonlite)
library(argparse)
suppressPackageStartupMessages(library(tidyverse, quietly=TRUE))

# get the args from the Makefile; of course we can move the python to a package
# and of course we can hide this function in a common script
get_args_from_make <- function(targetname) {
  cmd = str_glue("src/get_make_args.py {targetname}")
  # TODO: add error handling if get_make_args fails
  #       maybe use diff sys.exit() codes to handle diff failures.
  args_in_json <- system(cmd, intern=TRUE)
  return(fromJSON(args_in_json))
}

args <- get_args_from_make(targetname="output/task3b.csv")
sink(args$log)
print("args extracted from Makefile")
print(args)

arg1a <- read_delim(args$arg1a, delim="|", col_types=cols())
arg3 <- read_delim(args$arg3, delim="|", col_types=cols())

glimpse(arg1a)
glimpse(arg3)

result <- arg3 %>% mutate(c1ln = log(c1))
glimpse(result)

write_delim(result, args$output, delim="|")
sink()
print('done.')
# done.
