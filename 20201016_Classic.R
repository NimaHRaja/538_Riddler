library(reshape2)
library(dplyr)

points <- 
    read.csv("20201016_Classic_points.csv") %>%
    melt(id.vars = c("X","Y")) %>% 
    filter(!is.na(value)) %>%
    rename(name = variable) %>%
    select(-value) %>%
    arrange(name,X,Y) %>%
    mutate(order = rep(c(1,2,4,3),6)) %>%
    mutate(order = if_else(name %in% c("C3","D1") & order == 4, 3,order)) %>%
    mutate(order = if_else(name %in% c("C3","D1") & order == 3, 4,order)) %>%
    arrange(order)

jpeg("20201016_Classic_cases.jpg", width = 800, height = 600)
points %>%
    ggplot(aes(x = X, y = Y)) +
    geom_polygon(aes(fill = name, group = name))
dev.off()
