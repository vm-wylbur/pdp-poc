#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# Author: PB
# Maintainer(s): PB
# License: (c) HRDAG 2018, GPL v2 or newer
#
# pdp-poc/import/src/import.py
# -----------------------------------------------------------

import argparse
import pandas as pd


def getargs():
    parser = argparse.ArgumentParser()
    parser.add_argument("--input", default="input/NY-97-ht-wt.xlsx")
    parser.add_argument("--output", default="output/nysy.csv")
    args = parser.parse_args()


    return args


if __name__ == '__main__':

    args = getargs()


# done.
