#
#  Author: PB
#  Maintainer: PB
#  License: (c) HRDAG 2018, some rights reserved: GPL v2 or newer
#
# pdp-poc/task1b/Makefile
#
# This example has a few dependencies, including files in input/
# and files from other tasks in hand/paths.yaml
#
# we will include this line hardcoded in every Makefile
# the relative path to getdeps might change a little, but
# hand/paths.yaml should always be there.
DEPS=$(shell ../share/src/getdeps.py hand/paths.yaml)

.PHONY: all clean

all: cache/task1b_tmp.csv output/task1b.csv

clean:
	rm cache/* output/*


# this script only depends on files from outside the task
# however, it writes a file to be used only internally
cache/task1b_tmp.csv: src/task1b_1.py $(DEPS)
	python $<

# this script reads an internal dependency along with the externals.
output/task1b.csv: src/task1b_2.py $(DEPS) cache/task1b_tmp.csv
	python $<

# done.
