##==============================================
#
#   Test random rules by creating a batch of images to be curated
#     see produce_L.R for behavior associated with symbols
#
##===============================================
library(tidyverse)

source("R/produce_random_L.R")
source("R/plot_utils.R")

img_prefix<- "images/test/rls_"
fname <- "images/test/image_log.csv"
log <- read_L_log_file(fname)

##==============================
## generate random images
##==============================

n_img <- 10
for (i in 1: n_img){
  ## rule parameters
  seed <- sample(1:10000, 1)
  r_length <- sample(8:12 , 1)
  symbols <- c("F", "|", "+", "-", "X")
  p <- c(12, 3, 5, 5, 2)
  b_depth <-  sample(0:2, 1)
  
  ## object parameters
  axiom = "F"
  #sample(c(10, 22.5, 30, 45, 60, 90), 1)
  angle <- 90
  len <- 1
  l_factor <- runif(1, 0.50, 1)
  n_gens <- sample(3:5, 1)
  
  ## generate object
  s <- gen_random_L_rule(length = r_length, symbols = symbols, p = p, b_depth = b_depth, seed = seed)
  rules <- list("F" = s)
  
  obj <- produce_L_object(axiom = axiom, rules = rules,  angle = angle, l_factor = l_factor,
                          n_gen = n_gens)
  
  img <- draw_segments(obj, size = 1)
  
  ## save image + log
  img_name <- str_c(img_prefix, format(Sys.time(), "%d-%H-%M-%S"), "_s_", seed, ".png")
  ggsave(img_name, img)
  log <- log %>%
    add_row(name = img_name, seed = seed,
            rlen = r_length, symbols = str_c(symbols, collapse = ","),
            prob = str_c(p, collapse = ","), depth = b_depth,
            axiom = axiom, angle = angle, slen = len, factor = l_factor, gens = n_gens)
}

write_csv(log, fname)

