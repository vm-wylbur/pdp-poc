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
p_load(here, tidyverse, tidylog, janitor)

sink(here('example/clean/output/clean.log'))

args <- list(wtprobs = here('example/clean/hand/wt-probs.csv'),
             input = here('example/clean/input/nlsy.csv'),
             output = here('example/clean/output/nlsy.rds'))

perception_probs <- read_delim(args$wtprobs, delim='|', comment="#")

#  person’s weight in kilograms divided by the square of height in meters

nlsy <- read_delim(args$input, delim="|") %>%
   clean_names() %>%
   filter(weight > 50) %>% filter(height > 36) %>%
   mutate(age = if_else(age < 0, NA_integer_, age)) %>%
   left_join(perception_probs)  %>%
   mutate(prob = if_else(is.na(prob), .75, prob)) %>%
   mutate(bmi = (weight/2.2)/((height * 0.0254)**2)) %>% 
   mutate(prob = if_else(bmi > 27, 0, prob)) %>% 
   mutate(prob = if_else(bmi > 25, prob * 0.5, prob)) %>% 
   mutate(prob = if_else(bmi > 23, prob * 0.75, prob)) %>% 
   mutate(prob = if_else(bmi > 21, prob * 0.85, prob)) %>% 
   mutate(wt = runif(n=nrow(.))) %>%
   mutate(obsd = prob > wt) %>%
   select(sex, age, height, weight, self_perception, obsd) %>%
   glimpse()

print(table(nlsy$obsd))
rm(perception_probs)
saveRDS(nlsy, args$output)
sink()

# done.