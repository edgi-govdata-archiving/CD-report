#Let's bring in some packages

#install.packages("here")
#install.packages("ggplot2")
#install.packages("tidyr")
#install.packages("dplyr")
#install.packages("wesanderson")


library(here)
library(ggplot2)
library(tidyr)
library(dplyr)
library(wesanderson)


#let's load in the data

vRCRA <- read.csv(here("MA4_data/MA4_RCRA_violations.csv"))
vRCRA$year <- as.numeric(vRCRA$year)

iRCRA <- read.csv(here("MA4_data/MA4_RCRA_inspections.csv"))
iRCRA$year <- as.numeric(iRCRA$year)

eRCRA <- read.csv(here("MA4_data/MA4_RCRA_enforcement.csv"))
eRCRA$year <- as.numeric(eRCRA$year)

vCAA <- read.csv(here("MA4_data/MA4_CAA_violations.csv"))
vCAA$year <- as.numeric(vCAA$year)

iCAA <- read.csv(here("MA4_data/MA4_CAA_inspections.csv"))
iCAA$year <- as.numeric(iCAA$year)

eCAA <- read.csv(here("MA4_data/MA4_CAA_enforcement.csv"))
eCAA$year <- as.numeric(eCAA$year)

#some basics on axis formatting

largernumbers <- element_text(face = "bold", size = 14)
largernumbers2 <- element_text(face = "bold", size = 12)

#let's make a figure that looks *sparklyyyy*

vRCRAviol <- ggplot(vRCRA, mapping=aes(x=factor(year), y=vRCRA_violations, color=President, group=1))+
  scale_color_manual(values=c("#00bb38" , "#619eff"))+
  geom_point(size=3)+
  geom_line()+
  labs(y="RCRA violations", x="Year")+
  ggtitle("RCRA violations in MA 4")+
  theme_bw()+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),panel.border = element_blank(),
        axis.line = element_line(colour = "black"),
        axis.title.x=largernumbers,
        axis.text.y=largernumbers2, axis.title.y=largernumbers,plot.title = largernumbers,
        axis.text.x=element_text(angle= 80,hjust=1))




vRCRAviol


#now let's save it

#ggsave("RCRA_violations_MA4.png", plot = RCRAviol)

