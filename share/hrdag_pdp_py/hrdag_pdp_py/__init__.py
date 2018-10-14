#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# Author: PB
# Maintainer(s): PB
# License: (c) HRDAG 2018, GPL v2 or newer
#
# filename: pdp_poc/share/hrdag_pdp_py/hrdag_pdp_py/__init__.py
#
# -----------------------------------------------------------
#


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

# done.
