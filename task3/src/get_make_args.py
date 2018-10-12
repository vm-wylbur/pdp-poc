#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# Author: PB
# Maintainer(s): PB
# License: (c) HRDAG 2018, GPL v2 or newer
#
# pdp-poc/task3/src/get_make_args.py
#
# -----------------------------------------------------------
#
from pprint import pprint
import argparse
import os
import os.path
import subprocess
import re
from pprint import pprint
import json
import contextlib

VERBOSE = False


def get_makefile_database(targetname, makefile_path=None):
    assert targetname.startswith('output/')
    # remove the target file
    with contextlib.suppress(FileNotFoundError):
        os.remove(targetname)
    curpath = os.path.abspath(os.getcwd())
    # TODO: add version test: must be make verison >=4
    # dry-run the make rule
    MAKE = "/usr/local/opt/make/libexec/gnubin/make"  # need make >v4
    if not makefile_path:
        makefile_path = ""
    else:
        if makefile_path.endswith("Makefile"):
            makefile_path = makefile_path[0:-9]
            os.chdir(makefile_path)
    if VERBOSE: print(os.getcwd())
    makeoutput = subprocess.getoutput(f"{MAKE} -n -r -p {targetname}").split('\n')
    os.chdir(curpath)
    return makeoutput


def extract_cmd_deps_from_make(makeoutput, targetname):
    state = 0
    cmdlines = list()
    deps = ""
    i = 0
    for i,line in enumerate(makeoutput):

        if state == 0:
            if "GNU Make" in line:
                state = 1
            else:
                cmdlines.append(line)
            continue

        if state == 1 and line.startswith(targetname):
            state = 2
            deps = [dep.strip() for dep in line.split(":")[1].split(' ') if dep]
            break
    return cmdlines, deps


def get_args_from_cmdlines(cmdlines):
    cmdlines = [s.replace('\\','').strip() for s in cmdlines]
    cmdline = ' '.join(cmdlines)
    first_arg = cmdline.index('--')
    cmdline = cmdline[first_arg:]

    cmds = [s.replace('=', ' ').strip() for s in re.split('--', cmdline) if s]
    args = {k:v for k, v in [c.split(' ') for c in cmds]}
    return json.dumps(args)

if __name__ == '__main__':
    # call by get_make_args.py targetname [makefile_path]
    parser = argparse.ArgumentParser()
    parser.add_argument('targetname', help="name of rule (output)")
    parser.add_argument('makefile_path', nargs='?', help="path to Makefile")
    args = parser.parse_args()

    makeoutput = get_makefile_database(args.targetname)
    if VERBOSE: pprint(makeoutput[0:30])
    cmdlines, deps = extract_cmd_deps_from_make(makeoutput, args.targetname)
    args = get_args_from_cmdlines(cmdlines)
    print(args)

# done.
