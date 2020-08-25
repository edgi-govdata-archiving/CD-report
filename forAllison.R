library(tidyverse)
library(pagedown)
library(palmerpenguins)
library(patchwork)
library(here)
library(ggplot2)
library(tidyr)
library(dplyr)
library(shiny)
library(extrafont)
library(viridis)
loadfonts()


#read data

enforcement <- read.csv(here("enforcement.csv"))

enforcementgraph <- enforcement %>% ggplot()+
  geom_point(aes(x=factor(Date),y=Count, color=President, group=1))+
  scale_color_viridis(discrete=TRUE)+
  geom_line(aes(x=factor(Date),y=Count, color=President, group=1))+
  labs(y="Formal Enforcement Actions", x="Year")+
  ggtitle("Formal Enforcement Actions Across Programs in MA 4")+
  scale_y_continuous(expand=c(0,0), limits=c(0,40))+
  theme_meg()+
  theme(axis.text.x=element_text(angle= 80,hjust=1, size=8))
enforcementgraph

#add $$
enforcementgraph <- enforcementgraph +
  geom_point(aes(x= factor(Date), y = Amount * 40/3000000, color=President, group=1))
enforcementgraph <- enforcementgraph +
  geom_line(aes(x= factor(Date), y = Amount * 40/3000000, color=President,group=1))
enforcementgraph

enforcegraph <- enforcementgraph + scale_y_continuous(
  name = "Formal Enforcement Actions",
  sec.axis = sec_axis(~ . *3000000/40,name = "Formal Enforcement Fines ($)"),
  limits = c(0, 40))
enforcegraph



