##======================================
##
## Transformation utilities
##
##======================================
library(tidyverse)

scale_obj <- function(obj, fx, fy){
  obj %>%
    mutate(x1 = x1 * fx, y1 = y1 * fy,
           x2 = x2 * fx, y2 = y2 * fy)
}
