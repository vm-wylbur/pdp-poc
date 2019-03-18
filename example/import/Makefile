# -*- coding: utf-8 -*-
#
# Author: PB
# Maintainer(s): PB
# License: (c) HRDAG 2019, GPL v2 or newer
#
# pdp-poc/example/import/Makefile
# -----------------------------------------------------------
#
.PHONY: all clean

all: output/nlsy.csv output/mlb.csv

clean:
	rm output/*

output/nlsy.csv: \
		src/import.py \
		input/NLSY-97-ht-wt.xlsx
	python $< \
		--input=input/NLSY-97-ht-wt.xlsx \
		--output=$@

output/mlb.csv: \
		input/mlb-ht-wt.csv
	cd output && ln -sf ../input/mlb-ht-wt.csv mlb.csv
# done.
