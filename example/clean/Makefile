# -*- coding: utf-8 -*-
#
# Author: PB
# Maintainer(s): PB
# License: (c) HRDAG 2018, GPL v2 or newer
#
# pdp-poc/example/clean/Makefile
# -----------------------------------------------------------
#
.PHONY: all clean

all: output/nlsy.rds

clean:
	rm output/*

output/nlsy.rds: \
		src/clean.R \
		hand/wt-probs.csv \
		input/nlsy.csv
	Rscript --vanilla $<

# done.
