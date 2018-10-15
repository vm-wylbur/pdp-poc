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
library(tools)
library(rstudioapi)
suppressPackageStartupMessages(library(tidyverse, quietly=TRUE))


get_running_name <- function() {
  if (interactive()) {
    fname <- rstudioapi::getActiveDocumentContext()$path
  } else {
    # via commandArgs, look for file=
    cmdArgs = commandArgs(trailingOnly = FALSE)
    needle <- '--file='
    fname <- grep(needle, cmdArgs, value=TRUE)
    print(fname)
  }
  if (length(fname) > 0) {
    fname <- basename(fname)
    return(tools::file_path_sans_ext(basename(fname)))
  }
  return(FALSE)
}

default_checker <- function(args, python_code) {
  for (line in python_code) { 
    key <- str_sub(str_extract(line, '--[^,]+'), 3, -2)
    if (is.na(key)) next
    pth <- str_sub(str_extract(line, 'default=[\'"].*[\'"]'), 10, -2)
    stopifnot(args[[key]] == pth)
  }
}

chkargs <- function(args, parser, addlog=TRUE) {
  if (addlog & !"log" %in% names(args)) {
    fname <- get_running_name()
    args[["log"]] <- str_glue('output/{fname}.log')
  }
  if (!interactive()) {
    default_checker(args, parser$python_code)
  }
  return(args)
}


# get the args from the Makefile; of course we can move the python to a package
# and of course we can hide this function in a common script
get_args <- function() {
  parser <- ArgumentParser()
  parser$add_argument("--arg1a", type="character", default="../task1a/output/task1a.csv")
  parser$add_argument("--arg1b", type="character", default="../task1b/output/task1b.csv")
  parser$add_argument("--output", type="character", default="cache/task4.csv")
  args <- parser$parse_args()
  args <- chkargs(args, parser)
  return(args)
}


#---main-----
args <- get_args()
print(str(args))

sink(args$log)

arg1a <- read_delim(args$arg1a, delim="|", col_types=cols())
arg1b <- read_delim(args$arg1b, delim="|", col_types=cols())

result <- bind_cols(
  select(arg1b, name),
  arg1a %>% slice(0:nrow(arg1b)) %>% select(c1)
)
# glimpse(result)

write_delim(result, args$output, delim="|")
sink()
print('done.')
# done.
