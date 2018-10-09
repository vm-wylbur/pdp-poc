#!/usr/bin/evn python3
#
#  Author: PB
#  Maintainer: PB
#  License: (c) HRDAG 2018, some rights reserved: GPL v2 or newer
#
# todo: test for existence of input files
#
import yaml
import sys


pathsyaml = sys.argv[1]
with open(pathsyaml, 'r') as yamlfile:
    try:
        paths = yaml.load(yamlfile)
    except yaml.YAMLError as exc:
        print(exc)
        sys.exit(1)

inputs = [pth for key, pth in paths.items() if key.startswith('input_')]
print(' '.join(inputs))

# done.
