# -*- coding: utf-8 -*-
#
# Author: PB
# Maintainer(s): PB
# License: (c) HRDAG 2018, GPL v2 or newer
#
# hrdag/pdp-poc/clean/src/clean.R
#
# -----------------------------------------------------------

require(argparse)
require(hrdag.pdp.r)  # for chkargs
require(tidyverse)


get_args <- function() {
  parser <- ArgumentParser()
  parser$add_argument("--input", default="../import/output/nlsy.csv")
  parser$add_argument("--output", default="output/nlsy.rds")
  args <- parser$parse_args()
  args$log <- ('output/clean.log')
  args <- chkargs(args, parser)
  return(args)
}


#---main-----
args <- get_args()
print(str(args))

sink(args$log)

nlsy <- read_delim(args$input, delim="|", col_types=cols()) %>%
  mutate_at(vars(age, height, weight), funs(ifelse( . < 0, NA, .))) %>%
  mutate_at(vars(Sex, `self-perception`), funs(as_factor)) %>%
  rename(`self-perception` = 'perception')

print(summary(nlsy$age))
print(summary(nlsy$weight))
print(summary(nlsy$height))
glimpse(nlsy)

saveRDS(nlsy, args$output)
sink()
print('done.')
# done.
