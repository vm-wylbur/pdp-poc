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
# from hrdag_pdp_py import chkargs


def chkargs(args, parser):
    ''' compare default args to passed args, fail if not equal '''
    actions = parser.__dict__['_option_string_actions']
    for actionname, action in actions.items():
        if not actionname.startswith('--') or actionname == '--help':
            continue
        actionname = actionname[2:]
        passedaction = vars(args)[actionname]

        msg = (f"argument={actionname}: default={action.default}"
               f" != passed={passedaction}, failing.")
        assert action.default == passedaction, msg
    return True


def getargs():
    ''' every script should define the path arguments here; and call
        chkargs() to assure that if this fn is run interactively in
        jupyter, the paths are the same as in the Makefile '''
    parser = argparse.ArgumentParser()
    parser.add_argument("--input", default="input/NLSY-97-ht-wt.xlsx")
    parser.add_argument("--output", default="output/nlsy.csv")
    args = parser.parse_args()
    args.log = "output/import.log"
    chkargs(args, parser)
    return args


if __name__ == '__main__':

    args = getargs()

    htwt = pd.read_excel(args.input, skiprows=1)

    # I know the number of rows, so I can test for it. It's ok if it changes
    # and forces me to reconsider this line.
    assert len(htwt) == 8168

    htwt.to_csv(args.output, sep="|", index=False)

# done.
