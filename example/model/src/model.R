# -*- coding: utf-8 -*-
#
# Author: PB
# Maintainer(s): PB
# License: (c) HRDAG 2018, GPL v2 or newer
#
# pdp-poc/example/model/src/model.R
# -----------------------------------------------------------
require(pacman)
p_load(here, tidyverse)

args <- list(
    input = here("example/clean/output/nlsy.rds"),
    mlb = here("example/import/output/mlb.csv"),
    trn = here("example/model/output/trn.png"),
    fityaml = here("example/model/output/fit.yaml"),
    trn_fit = here("example/model/output/trn+fit.png"),
    test_fit = here("example/model/output/test+fit.png"),
    test_fit_pb = here("example/model/output/test+fit+pb.png"),
    test_fit_mlb = here("example/model/output/test+fit+mlb.png"),
    fit_hidden = here("example/model/output/fit+hidden.png"),
    trn_test_fit_hidden_hfit = here(paste0("example/model/output/",
                                           "trn+test+fit+hidden+hfit.png")))



# done.
