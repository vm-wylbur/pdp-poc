# -*- coding: utf-8 -*-
#
# Author: PB
# Maintainer(s): PB
# License: (c) HRDAG 2018, GPL v2 or newer
#
# pdp-poc/import/Makefile
# -----------------------------------------------------------
#
.PHONY: all clean

all: output/nlsy.csv

clean:
	rm cache/* && rm output/*

output/nlsy.csv: \
		src/import.py \
		input/NLSY-97-ht-wt.xlsx
	python $< \
		--input=input/NLSY-97-ht-wt.xlsx \
		--output=$@

# done.
