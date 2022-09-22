##======================================
##
## Plotting utilities, color palettes etc.
##
##======================================
library(tidyverse)

set_theme <- function(bg_color = "black"){
  theme(plot.title = element_text(size = 8),
        legend.position  = "none",
        panel.background = element_rect(fill = bg_color),
        plot.background = element_rect(fill = bg_color),
        panel.grid = element_blank(),
        axis.title = element_blank(),
        axis.ticks = element_blank(),
        axis.text = element_blank())
}

############################
##
## Visual testing
##
############################
draw_segments <- function(object, 
                          color = "black",
                          size = 0.5,
                          bg_color = "white",
                          theme = FALSE){
  
  p <- object %>%
    ggplot() + 
    geom_segment(aes(x = x1, y = y1, xend = x2, yend = y2),
                 size = size,
                 colour = color,
                 lineend = "round") + 
    coord_equal()

  if(theme == TRUE){
    p <- p +
      set_theme(bg_color = bg_color)
  }

  return(p)
}


#####################
##
##  Palettes
##
#####################
pal_mondrean <- c("1" = "gold", "2" = "dodgerblue4", "3" = "red", "4" = "black")
pal_mondrean1 <- c("1" = "gold", "2" = "dodgerblue4", "3" = "red", "4" = "white")

#scales::show_col(pal_mondrean)


