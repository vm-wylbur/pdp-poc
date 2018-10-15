# -*- coding: utf-8 -*-
#
# Author: PB
# Maintainer(s): PB
# License: (c) HRDAG 2018, GPL v2 or newer
#
# pdp-poc/clean/Makefile
# -----------------------------------------------------------
#
.PHONY: all clean

all: output/nlsy.rds

clean:
	-rm cache/*
	-rm output/*

output/nlsy.rds: \
		src/clean.R \
		../import/output/nlsy.csv
	Rscript --vanilla $< \
		--input=../import/output/nlsy.csv \
		--output=$@

# done.
