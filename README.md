# Revisiting Principled Data Processing

Patrick Ball
2018-10-09

[HRDAG](https://hrdag.org) has dozens of projects spread across more than thirty countries. In order for our team to be able to share work, we need a standard process and directory structure in which to organize all the data and scripts.

Recently we've been struggling to find ways to include collaborators who a

Our most important goals are to reduce the probability of bugs, mostly by making pieces small and comprehensible; and to maximize our ability to audit, that is, the ability to trace results through all their constituent transformations (usually because we're checking what we did, months or years later).

In the post-hoc check scenario, it's essential that anyone in the team should be able to check the work, whether or not s/he was originally involved in creating it. This means that:

* no part of the computation has to be remembered, everything has to be in code that's linked by a Makefile. If we have to remember to do something special, it's broken.
* execution has to be standardized (every task runs by `make`);
* every task that does the same thing has the same name (e.g., `import`, `clean`, `export` are common);
* and the flow of data among tasks must be clear from a standard naming, linking, or storage convention. In particular, data should _never_ be copied from one task to another. Data should be referred to by symlinks or relative paths.


## Principles:
* _transparency_: tasks should be small enough to understand easily, without having to trace too many different scripts. Transparency is facilitated by standard task naming and task organization so that any analyst can assist any project, with minimal time learning where each piece should be.
* _auditability_: each task should produce transformations from inputs to outputs that can be easily tested.
* _scalability_: the structure should be usable by many simultaneous analysts; support many languages; include many datasets (each of which may have many updates
* _reproducible_: Results in documents should be technically traceable backward through every calculation.

## Critiques:
* symlinks are not cross-platform accessible. They break when passing through windows (<v10) and through file stores like Dropbox and Box.com
* Path and dependency handling is always messy.

## Proposal
Bring all the dependency management into a single `yaml` file. This file can be used to generate dependencies for make as well as provide paths (by key name) for scripts. This eliminates symlinks from the workflow.

## Examples

Read the code in this order:

`task1a/Makefile`
`task1a/hand/paths.yaml`
`tasks1a/src/gennums.R`
`tasks1b/Makefile`
`tasks1b/hand/paths.yaml`
`tasks1b/src/task1b_1.py`
`tasks1b/src/task1b_2.py`

<!--done-->
