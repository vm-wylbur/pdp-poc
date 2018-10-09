#!/usr/bin/env python3
#
#  Author: PB
#  Maintainer: PB
#  License: (c) HRDAG 2018, some rights reserved: GPL v2 or newer
#
#  pdp-poc/task1b/src/task1b_1.py
#
import yaml
import collections
import pandas as pd


def getpaths():
    ''' this function will be at the top of every script.
        hand/paths.yaml is a constant for all scripts '''
    with open('hand/paths.yaml', 'r') as yamlfile:
        try:
            paths = yaml.load(yamlfile)
        except yaml.YAMLError as exc:
            print(exc)
            sys.exit(1)
    return collections.namedtuple('Paths', paths.keys())(**paths)


if __name__ == '__main__':
    paths = getpaths()
    names = pd.read_csv(paths.input_task1b, header=None,
                        names=['name'])
    names.name = names.name.str.upper()
    names.to_csv(paths.cache_task1b_tmp, index=False)

# done.