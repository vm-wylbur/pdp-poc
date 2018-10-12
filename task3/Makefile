# -*- coding: utf-8 -*-
#
# Author: PB
# Maintainer(s): PB
# License: (c) HRDAG 2018, GPL v2 or newer
#
# hrdag/pdp-poc/task3/Makefile
#
# -----------------------------------------------------------
#
.PHONY: all clean

all: output/task3.csv output/task3b.csv

clean:
	rm output/*


output/task3.csv: \
		src/task3.R  \
		../task1a/output/task1a.csv \
		../task1b/output/task1b.csv
	Rscript --vanilla $< \
		--arg1a ../task1a/output/task1a.csv \
		--arg1b ../task1b/output/task1b.csv \
		--log output/task3.log \
		--output $@


output/task3b.csv: \
		src/task3b.R  \
		../task1a/output/task1a.csv \
		../task1b/output/task1b.csv
	Rscript --vanilla $< \
		--arg1a=../task1a/output/task1a.csv \
		--arg2=../task2/output/task2.csv \
		--log=output/task3b.log \
		--output=$@

# done.
