#!/usr/bin/env Rscript --vanilla
#
#  Author: PB
#  Maintainer: PB
#  License: (c) HRDAG 2018, some rights reserved: GPL v2 or newer
#
# generate and output 1000 random integers
# the execution context is always the task

# alternatively we could source a yaml-processing script here, like
## source('../share/src/library.R')
## paths <- getpaths()
require(yaml)
paths <- read_yaml('hand/paths.yaml')

x <- round(abs(rnorm(1000) + 1) * 1000)
y <- round(abs(rpois(1000, 1.1)) * 1000)
d <- data.frame(c1=x, c2=y, row.names=NULL)
write.table(d, paths$output_task1a, sep="|", row.names=FALSE)

# done.