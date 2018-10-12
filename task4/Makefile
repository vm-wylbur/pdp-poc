# -*- coding: utf-8 -*-
#
# Author: PB
# Maintainer(s): PB
# License: (c) HRDAG 2018, GPL v2 or newer
#
# hrdag/pdp-poc/task4/Makefile
#
# -----------------------------------------------------------
#
.PHONY: all clean

all: cache/task4.csv

clean:
	rm output/*


cache/task4.csv: \
		src/task4.R  \
		../task1a/output/task1a.csv \
		../task1b/output/task1b.csv
	Rscript --vanilla $< \
		--arg1a ../task1a/output/task1a.csv \
		--arg1b ../task1b/output/task1b.csv \
		--output $@

# done.
