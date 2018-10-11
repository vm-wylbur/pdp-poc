# -*- coding: utf-8 -*-
#
# Author: PB
# Maintainer(s): PB
# License: (c) HRDAG 2018, GPL v2 or newer
#
# hrdag/pdp-poc/task2/Makefile
#
# -----------------------------------------------------------
#
.PHONY: all clean

all: output/task2.csv

clean:
	rm output/*


output/task2.csv: \
		src/task2.R  \
		../task1a/output/task1a.csv \
		../task1b/output/task1b.csv
	Rscript --no-site-init $< \
		--arg1a=../task1a/output/task1a.csv \
		--arg1b=../task1b/output/task1b.csv \
		--log=output/task2.log \
		--output=$@


# done.
