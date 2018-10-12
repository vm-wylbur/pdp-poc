# -*- coding: utf-8 -*-
#
# Author: PB
# Maintainer(s): PB
# License: (c) HRDAG 2018, GPL v2 or newer
#
# hrdag/pdp-poc/task4/src/task4.R
#
# -----------------------------------------------------------

library(argparse)
suppressPackageStartupMessages(library(tidyverse, quietly=TRUE))

# get the args from the Makefile; of course we can move the python to a package
# and of course we can hide this function in a common script
get_args <- function() {
  parser <- ArgumentParser()
  parser$add_argument("--arg1a", type="character", default="../task1a/output/task1a.csv")
  parser$add_argument("--arg1b", type="character", default="../task1b/output/task1b.csv")
  parser$add_argument("--output", type="character", default="cache/task4.csv")
  p_tmp <- parser
  args <- parser$parse_args()
  # we could add logic here:
  # -- check that if run as a script, that the arguments passed match the defaults
  # -- add a log argument, always.
  return(args)
}

args <- get_args()
print(str(args))
sink(args$log)

# print(args)

arg1a <- read_delim(args$arg1a, delim="|", col_types=cols())
arg1b <- read_delim(args$arg1b, delim="|", col_types=cols())

# glimpse(arg1a)
# glimpse(arg1b)

result <- bind_cols(
  select(arg1b, name),
  arg1a %>% slice(0:nrow(arg1b)) %>% select(c1)
)
# glimpse(result)

write_delim(result, args$output, delim="|")
sink()
print('done.')
# done.
