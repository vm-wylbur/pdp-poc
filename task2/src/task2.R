# -*- coding: utf-8 -*-
#
# Author: PB
# Maintainer(s): PB
# License: (c) HRDAG 2018, GPL v2 or newer
#
# hrdag/pdp-poc/task2/src/task2.R
#
# -----------------------------------------------------------

library(argparse)
library(tidyverse)
library(tibble)
library(readr)

parser <- ArgumentParser()
parser$add_argument("--arg1a", type="character", help="first input file")
parser$add_argument("--arg1b", type="character", help="second input file")
parser$add_argument("--log", type="character", help="log file")
parser$add_argument("--output", type="character", help="output file")

args <- parser$parse_args()
sink(args$log)

arg1a <- read_delim(args$arg1a, delim="|")
arg1b <- read_delim(args$arg1b, delim="|")

glimpse(arg1a)
glimpse(arg1b)

result <- bind_cols(
  select(arg1b, name),
  arg1a %>% slice(0:nrow(arg1b)) %>% select(c1)
)
glimpse(result)

write_delim(result, args$output)
sink()
# done.
