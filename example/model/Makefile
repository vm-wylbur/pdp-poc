# -*- coding: utf-8 -*-
#
# Author: PB
# Maintainer(s): PB
# License: (c) HRDAG 2018, GPL v2 or newer
#
# pdp-poc/example/model/Makefile
# -----------------------------------------------------------
#
HERE := $(shell Rscript --vanilla -e 'write(here::here(), stdout())')

model_results = \
		$(HERE)/example/model/output/trn.png \
		$(HERE)/example/model/output/fit.yaml \
		$(HERE)/example/model/output/trn+fit.png \
		$(HERE)/example/model/output/trn+fit+pb.png \
		$(HERE)/example/model/output/trn+fit+mlb.png \
		$(HERE)/example/model/output/test+fit.png \
		$(HERE)/example/model/output/hidden.png \
		$(HERE)/example/model/output/trn+fit+hidden+hfit.png

.PHONY: all clean

all: $(model_results)

clean:
	rm output/*

$(model_results): \
		$(HERE)/example/model/src/model.R \
		$(HERE)/example/clean/output/nlsy.rds \
		$(HERE)/example/import/output/mlb.csv
	@echo "targ is $@"
	Rscript --vanilla $<

# done.
