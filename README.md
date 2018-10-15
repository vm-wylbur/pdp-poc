# Revisiting Principled Data Processing

Patrick Ball<br/>
2018-10-14

[HRDAG](https://hrdag.org) has dozens of projects spread across more than thirty countries. In order for our team to be able to share work, we need a standard process and directory structure in which to organize all the data and scripts.

These repositories include code used to audit and organize work

# The logic of principled data processing

The fundamental unit of our work is a **task**. A task is a directory containing a `Makefile` with at least one subdirectory -- `src/`. There are many other files and directories that the task might contain, but a task _must_ contain a `Makefile` and a `src/` directory.

A task does some reasonably small chunk of work. For example, a task might hold files share by a partner, and perhaps transform those files into a more usable format. Tasks that hold files contributed by partners are called `import`, the code to do the importing is in `import/src/`, the files themselves are stored in `import/input/`, and the execution of the task is described in `import/Makefile`. In the example in this repository, the `import/` task exemplifies this pattern.




## Directories in a task

* `output/`
* `input/`
* `cache/`
* `hand/`
* `frozen/`
* `doc/`

## Special directories
* `src/__cache__/`

## Installation

explain installing python `share/hrdag_pdp_py` package and the `share/hrdag.pdp.r` R package. Maybe add script for the installation.


## changes from earlier work

* no symlinks
* less emphasis on `input/` directory
* `Makefile` now at the task level
* re-emphasis on command line arguments in Makefile
* new `src/__cache__` and `cache/` directories
* no more `knitr`: new tool for magic numbers in LaTeX, enables TeXShop use

## Library code

* python and R library code for `getargs()`, `chkargs()`, check that all non-output arguments are dependencies; extractions of tasks and LaTeX `src/` dirs to share with non-pdp-using colleagues.


# open thoughts

_move to `doc/` dir_

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
* _openness_: work should be shareable with colleagues who do not use our approach.



## Critiques:
* symlinks are not cross-platform accessible. They break when passing through windows (<v10) and through file stores like Dropbox and Box.com
* Path and dependency handling is always messy.


## Examples

Read the code in this order:
```
examples here
```
<!--done-->
