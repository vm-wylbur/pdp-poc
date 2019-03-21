# -*- coding: utf-8 -*-
#
# Author: PB
# Maintainer(s): PB
# License: (c) HRDAG 2018, GPL v2 or newer
#
# pdp-poc/example/model/src/model.R
# -----------------------------------------------------------
# 
# notes: 
#   * the points are jittered, so not every graph is identical
#   * this imposes extreme bias! make clear in text. 
#
require(pacman)
p_load(here, tidyverse, ggplot2)

args <- list(
    input = here("example/clean/output/nlsy.rds"),
    mlb = here("example/import/output/mlb.csv"),
    trn = here("example/model/output/trn.png"),
    fityaml = here("example/model/output/fit.yaml"),
    trn_fit = here("example/model/output/trn+fit.png"),
    trn_fit_pb = here("example/model/output/trn+fit+pb.png"),
    trn_fit_mlb = here("example/model/output/trn+fit+mlb.png"),
    test_fit = here("example/model/output/test+fit.png"),
    trn_hidden = here("example/model/output/hidden.png"),
    trn_fit_hidden_hfit = here(paste0("example/model/output/",
                                      "trn+fit+hidden+hfit.png")))

n_sample <- 200

nlsy <- readRDS(args$input) %>% mutate(p = runif(n = nrow(.)))
trn <- nlsy %>% filter(p < 0.85) %>% filter(obsd == 1)
trn0 <- trn %>% sample_n(n_sample)
test0 <- nlsy %>% filter(p > 0.15) %>% filter(obsd == 1) %>% sample_n(n_sample)
hidden0 <- nlsy %>% filter(obsd == 0) %>% sample_n(n_sample)

# filter for biggest BMIs
mlb0 <- read_delim(args$mlb, delim="|") %>% 
    filter(!is.na(weight)) %>% 
    filter(!is.na(height)) %>% 
    mutate(bmi = (weight/2.2)/((height * 0.0254)**2)) %>% 
    top_n(n_sample, bmi) %>% 
    select(height, weight)
    
# graph limits: ht (36, 85), wt(55, 300)
p0 <- ggplot(trn0, aes(height, weight)) + 
    geom_jitter(shape=1, color='blue') +
    ylim(100, 250) + xlim(55, 80)
ggsave(args$trn, p0)

model1 <- lm(weight ~ height, data=trn)
model1str <- paste0("model1: weight = ", round(model1$coefficients[1], 1), 
                    ' + ',  round(model1$coefficients[2],1), "*height\n")
cat(model1str, file=args$fityaml, append=FALSE)

p1 <- p0 + geom_abline(slope = model1$coefficients[2], 
                       intercept = model1$coefficients[1], 
                       color='blue')
ggsave(args$trn_fit, p1)

p2 <-  ggplot(test0, aes(height, weight)) + 
    geom_jitter(shape=1, color='green4') +
    ylim(100, 250) + xlim(55, 80) +
    geom_abline(slope = model1$coefficients[2], 
                intercept = model1$coefficients[1], 
                color='blue')
ggsave(args$test_fit, p2) 

p3 <- p1 + geom_point(x=66, y=200, color="red")
ggsave(args$trn_fit_pb, p3)

p4 <- p1 + geom_jitter(data=mlb0, shape=2, color="red")
ggsave(args$trn_fit_mlb, p4)

p5 <- p1 + geom_jitter(data=hidden0, shape=1, color='grey55')
ggsave(args$trn_hidden, p5)

model2 <- lm(weight ~ height, data=nlsy)
model2str <- paste0('model2: weight = ', round(model2$coefficients[1], 1), 
                    ' + ',  round(model2$coefficients[2],1), "*height\n")
cat(model2str, file=args$fityaml, append=TRUE)

p6 <- p5 + geom_abline(slope = model2$coefficients[2], 
                       intercept = model2$coefficients[1], 
                       color='grey55')
ggsave(args$trn_fit_hidden_hfit, p6)

sink()
print("done!")
# done.
