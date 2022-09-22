##======================================
##
## Produce a random L-systems object based on log file parameters
##    Read random parameters log file
##    Generate a random rule
##    Produce a random object
##
##======================================
library(tidyverse)
source("produce_L.R")

##====================================
##  Read random parameters log file
##====================================

read_L_log_file <- function(fname){
  log <- read_csv(fname, col_types = list(name = col_character(),
                                          symbols = col_character(),
                                          axiom = col_character(),
                                          prob = col_character(),
                                          seed = col_integer(),
                                          rlen = col_integer(),
                                          depth = col_integer(),
                                          angle = col_double(),
                                          slen = col_double(),
                                          factor = col_double(),
                                          gens = col_integer()))
}

##====================================
##  Generate a random rule
##====================================

gen_random_L_rule <- function(length,         # rule string length
                              symbols,        # set of rule symbols
                              p,              # probability of symbols
                              b_depth,        # branching depth
                              seed = NULL){       
  
  set.seed(seed)
  string <- sample(symbols, size = length, replace = TRUE, prob = p)
  
  # randomly insert branching brackets in string
  if(b_depth == 0) return(string)
  
  nb <- b_depth * 2
  b_set <- rep(c("[", "]"), b_depth)
  b_location <- sample(1:(length), size = nb) %>% sort() # after
  
  #  special case: last closing bracket located at end of string
  b <- ifelse(b_location[nb] < length, nb, nb-1)
  for(i in 1:b){
    string <- c(string[1:(b_location[i] + i - 1)],
                b_set[i],
                string[(b_location[i] + i):length(string)])
  }
  if(b < nb) string <- c(string, b_set[nb])
  
  return(string)
}

##====================================
##  Produce a random object
##    Currently supports one rule only with F as re-writing symbol
##====================================

produce_random_L_object <- function(log,      # log file
                                    r_seed){  # seed of entity
  params <- filter(log, seed == r_seed)
  
  s <- gen_random_L_rule(length = params$rlen,
                         symbols = str_split(params$symbols,",")[[1]],
                         p = as.integer(str_split(params$prob,",")[[1]]),
                         b_depth = params$depth,
                         seed = r_seed)
  rules <- list("F" = s)
  
  object <- produce_L_object(axiom = params$axiom,
                             rules = rules,
                             angle = params$angle,
                             len = params$slen,
                             l_factor = params$factor,
                             n_gen = params$gens)
}
