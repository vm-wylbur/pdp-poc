#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# Author: PB
# Maintainer(s): PB
# License: (c) HRDAG 2019, GPL v2 or newer
#
# pdp-poc/example/import/src/import.py
# -----------------------------------------------------------

import argparse
import pandas as pd


def getargs():
    parser = argparse.ArgumentParser(description='''
        every script should define the path arguments here; and call
        chkargs() to assure that if this fn is run interactively in
        jupyter, the paths are the same as in the Makefile ''')
    parser.add_argument("--input", default="input/NLSY-97-ht-wt.xlsx")
    parser.add_argument("--output", default="output/nlsy.csv")
    args = parser.parse_args()
    args.log = "output/import.log"
    return args


if __name__ == '__main__':

    args = getargs()

    htwt = pd.read_excel(args.input, skiprows=1)

    # I know the number of rows, so I can test for it. It's ok if it changes
    # and forces me to reconsider this line.
    assert len(htwt) == 8168
    with open(args.log, 'wt') as f:
        f.write("found 8168 records, as expected\n")

    htwt.to_csv(args.output, sep="|", index=False)

# done.
