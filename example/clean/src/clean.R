# -*- coding: utf-8 -*-
#
# Author: PB
# Maintainer(s): PB
# License: (c) HRDAG 2019, GPL v2 or newer
#
# hrdag/pdp-poc/example/clean/src/clean.R
#
# -----------------------------------------------------------

require(pacman)
p_load(here, tidyverse, janitor)

sink(here('example/clean/output/clean.log'))

args <- list(wtprobs = here('example/clean/hand/wt-probs.csv'),
             input = here('example/clean/input/nlsy.csv'),
             output = here('example/clean/output/nlsy.rds'))

perception_probs <- read_delim(args$wtprobs, delim='|', comment="#")

nlsy <- read_delim(args$input, delim="|") %>% 
   clean_names() %>% 
   filter(weight > 0) %>% filter(height > 0) %>% 
   mutate(age = if_else(age < 0, NA_integer_, age)) %>% 
   left_join(perception_probs)  %>% 
   mutate(prob = if_else(is.na(prob), .75, prob)) %>% 
   mutate(wt = runif(n=nrow(.))) %>% 
   mutate(obsd = prob > wt) %>% 
   select(sex, age, height, weight, obsd) %>% 
   glimpse()

rm(perception_probs)
saveRDS(nlsy, args$output)
sink()

# done. 