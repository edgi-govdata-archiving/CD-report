---
title: "Congressional Report Card"
output: 
  html_paged:
    number_sections: false
    css: ["custom.css"]
---

```{r setup, include=FALSE}
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
library(grid)
library(gridExtra)
library(fishualize)
library(ggrepel)
loadfonts()


knitr::opts_chunk$set(echo = FALSE, message = FALSE, warning = FALSE)
```

```{r readData, echo=FALSE}

#reading in all of the data and naming it based on the name of the .csv up to the first 2 underscores
#national data
filenames = list.files(here("nationalstats"), pattern = ".csv")
file_count = length(filenames)
for (i in filenames){  
  name <- gsub("^([^_]*_[^_]*)_.*$","\\1", i)
  assign(name, read.csv(here("nationalstats", i)))
}

names(USAinspectionsper1000_All)[1] <- "Program"
names(USAviolationsper1000_All)[1] <- "Program"

#each time this section is run, change "here" to specify the subfolder for the district or state 
#Also, the way it is set up, you're going to need to cntrl f to change the district and date for the files
filenames = list.files(here("MA4"), pattern = ".csv")
file_count = length(filenames)
for (i in filenames){  
  name <- gsub("^([^_]*_[^_]*_[^_]*_[^-]*-[^-*])-.*$","\\1", i)
  assign(name, read.csv(here("MA4", i)))
}

activefacilities <- `active-facilities_All_pg3_MA-4`

#set up a theme default to reduce code block later 
theme_meg <- function () { 
  theme_bw(base_family="Georgia") %+replace% 
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),panel.border = element_blank(),
          axis.line = element_line(colour = "black"), axis.title.x=element_text(face = "bold", size = 14), 
          axis.title.y=element_text(face = "bold", size = 10, angle=90), plot.title=element_text(face = "bold", size = 14, hjust =.5), 
          axis.text.x=element_text(face = "bold", size = 14), axis.text.y=element_text(face = "bold", size = 8))
}

theme_megpie <- function () { 
  theme_bw(base_family="Georgia") %+replace% 
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),panel.border = element_blank(),
          axis.line = element_line(colour = "black"), axis.title.x=element_text(face = "bold", size = 4), 
          axis.title.y=element_text(face = "bold", size = 2, angle=90), plot.title=element_text(face = "bold", size = 8, hjust =.5), 
          axis.text.x=element_text(face = "bold", size = 2), axis.text.y=element_text(face = "bold", size = 2))
}


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

```

<div class="container">
  <img src="factory_unsplash.jpg" alt="Snow" style="width:100%;">
  <div class="top-left">District Info</div>
</div> 

### 17 August 2020  

#### This report was produced by the Environmental Enforcement Watch, a project of EDGI. Data utlized to produce this report comes from the EPA's Enforcement and Compliance History Online [ECHO](https://echo.epa.gov/). 

<a href="https://www.environmentalenforcementwatch.org/"><img src="eew_logo.png" style="float: left; width: 25%; margin-left: 20%" ></a>

<a href="https://envirodatagov.org/"><img src="edgi_logo.png" style="float: right; width: 35%; margin-right: 20%" ></a>


\pagebreak

<hr style="height:3px;border-width:0;color: #C1E0D7;background-color: #C1E0D7; margin-top: 4em">


##### DISTRICT INFORMATION

# Massachussetts' 4th Congressional District   

## Joe Kennedy 

<a ><img src="Joe_kennedy.jpeg" style="float: left; width: 25%; margin-right: 5%" ></a>

<h2><span style="color:#25539f">Democrat</span></h2>
## In office since January 3rd, 2013

## Relevant Committee Membership: [Energy and Commerce Committee](https://energycommerce.house.gov/)
<div class="text-box-info">

<p>The House Energy and Commerce Committee is the oldest house committee, and has one of the broadest mandates. Among other things, it has jurisdiction over environmental protection, clean air and climate change, safe drinking water, and toxic chemicals and hazardous waste. Additionally, it has oversight of the Environmental Protection Agency.</p>
</div>
### Relevant Subcommittees: 
1. [Energy](https://energycommerce.house.gov/subcommittees/energy-116th-congress) 
2. [Oversights and Investigations](https://energycommerce.house.gov/subcommittees/oversight-and-investigations-116th-congress) 

## What powers do representatives on this committee/subcommittee have? 

<div class="text-box-info">

<p>As a member of this committee and subcommittee, Joe can . . .</p>

</div>

## Cosponsored Bills in Interest Areas 

Pull info from govtrack


\pagebreak

<hr style="height:3px;border-width:0;color: #C1E0D7;background-color: #C1E0D7; margin-top: 4em">

##### DISTRICT INFORMATION

<h1><span style="color:yellow">Highlights for Your District</span></h1>
<a ><img src="MA4_data/ma4_map.jpeg" style="float: right; width: 55%" ></a>
<h2><span style="color:#DC143C">`r activefacilities[1,2] ` 
`r activefacilities[1,1]` facilities</span></h2>
<h2><span style="color:#DC143C">`r activefacilities[2,2] ` 
`r activefacilities[2,1]` facilities</span></h2>
<h2><span style="color:#DC143C">`r activefacilities[3,2] ` 
`r activefacilities[3,1]` facilities</span></h2>
<h2><span style="color:#DC143C">`r activefacilities[4,2] ` 
`r activefacilities[4,1]` facilities</span></h2>

## Number of Regulated Facilities that spent at least 25% of the last 3 years in Violation per Program:

```{r echo=FALSE, out.width= "95%", out.extra='style="float:center; padding:0px"'}


##let's attempt these pie charts

#CAA

##first let's fix up the data
#ok so We'll put the % in the title for the state, and try to figure out the same for MA 4
CAArecurring <- `recurring-violations_All_pg3_MA-4`[-c(2,3,5,6),]
CAArecurring <- CAArecurring %>%
  select(CD,Facilities, Percent)
names(CAArecurring)[1] <- "Region"
CAArecurring[1,1] <- as.character("Rest of State")
CAArecurring[2,1] <- as.character("MA 4")
CAArecurring$Region2 <- as.character("all of MA")
CAArecurring[2,4] <- as.character("MA 4")
CAArecurring$RecurringViolators <- (as.numeric(CAArecurring[1,2]-CAArecurring[2,2]))
CAArecurring[2,5] <- as.numeric(CAArecurring[2,2])
CAArecurring$Proportional <- (as.numeric((100/(CAArecurring[1,2]))*CAArecurring[1,5]))
CAArecurring[2,6] <- as.numeric(100-CAArecurring[1,6])
CAArecurring[3] <-round(CAArecurring[3],2)


##CAA pie chart

# Compute the position of labels
CAArecurring <- CAArecurring %>%
  arrange(desc(Region)) %>%
  mutate(prop = Proportional) %>%
  mutate(ypos = cumsum(prop)- 0.5*prop )

CAApie <- ggplot(CAArecurring, aes(x = "", 
                                   y = Proportional, 
                                   fill = Region)) +
  geom_bar(stat = "identity", 
           show.legend = FALSE, 
           width = 1,
           color = "white") +
  geom_text(x = 1.2, aes(y = ypos, 
                label = RecurringViolators, family="Georgia"),
            color = "black",
            size = 6) +
  geom_text_repel(aes(x = 1.5, 
                      y = ypos, 
                      label = paste("This is",Percent,"% of facilities\nin", Region2)),
                   segment.color = "gray80",
                   color = "gray50",
                   size = 3,
                   nudge_x = .4, 
                   segment.size = 0.6, 
                   show.legend = FALSE, family="Georgia") +
  ggtitle("Clean Water Act") +
  scale_fill_manual(values=c("yellow","#00bfff")) +
  scale_color_manual(values=c("yellow","#00bfff")) +
  coord_polar("y", start = 0) +
  theme_minimal() +
  theme(axis.line = element_blank(),
        axis.text = element_blank(),
        panel.grid = element_blank(),
        axis.title = element_blank(),
        plot.title = element_text(hjust = 0.5, margin = margin(0,0,0,0), family="Georgia"))
#CWA

##first let's fix up the data
#ok so We'll put the % in the title for the state, and try to figure out the same for MA 4
CWArecurring <- `recurring-violations_All_pg3_MA-4`[-c(1,3,4,6),]
CWArecurring <- CWArecurring %>%
  select(CD,Facilities, Percent)
names(CWArecurring)[1] <- "Region"
CWArecurring[1,1] <- as.character("Rest of State")
CWArecurring[2,1] <- as.character("MA 4")
CWArecurring$Region2 <- as.character("all of MA")
CWArecurring[2,4] <- as.character("MA 4")
CWArecurring$RecurringViolators <- (as.numeric(CWArecurring[1,2]-CWArecurring[2,2]))
CWArecurring[2,5] <- as.numeric(CWArecurring[2,2])
CWArecurring$Proportional <- (as.numeric((100/(CWArecurring[1,2]))*CWArecurring[1,5]))
CWArecurring[2,6] <- as.numeric(100-CWArecurring[1,6])
CWArecurring[3] <-round(CWArecurring[3],2)


##CWA pie chart

# Compute the position of labels
CWArecurring <- CWArecurring %>%
  arrange(desc(Region)) %>%
  mutate(prop = Proportional) %>%
  mutate(ypos = cumsum(prop)- 0.5*prop )


CWApie <- ggplot(CWArecurring, aes(x = "", 
                                   y = Proportional, 
                                   fill = Region)) +
  geom_bar(stat = "identity", 
           show.legend = FALSE, 
           width = 1,
           color = "white") +
  geom_text(x = 1.2, aes(y = ypos, 
                label = RecurringViolators, family="Georgia"),
            color = "black",
            size = 6) +
  geom_text_repel(aes(x = 1.5, 
                      y = ypos, 
                      label = paste("This is",Percent,"% of facilities\nin", Region2)),
                   segment.color = "gray80",
                   color = "gray50",
                   size = 3,
                   nudge_x = .4, 
                   segment.size = 0.6, 
                   show.legend = FALSE, family="Georgia") +
  ggtitle("Clean Water Act") +
  scale_fill_manual(values=c("yellow","#00bfff")) +
  scale_color_manual(values=c("yellow","#00bfff")) +
  coord_polar("y", start = 0) +
  theme_minimal() +
  theme(axis.line = element_blank(),
        axis.text = element_blank(),
        panel.grid = element_blank(),
        axis.title = element_blank(),
        plot.title = element_text(hjust = 0.5, margin = margin(0,0,0,0), family="Georgia"))
  

#RCRA

##first let's fix up the data
#ok so We'll put the % in the title for the state, and try to figure out the same for MA 4
RCRArecurring <- `recurring-violations_All_pg3_MA-4`[-c(1,2,4,5),]
RCRArecurring <- RCRArecurring %>%
  select(CD,Facilities, Percent)
names(RCRArecurring)[1] <- "Region"
RCRArecurring[1,1] <- as.character("Rest of State")
RCRArecurring[2,1] <- as.character("MA 4")
RCRArecurring$Region2 <- as.character("all of MA")
RCRArecurring[2,4] <- as.character("MA 4")
RCRArecurring$RecurringViolators <- (as.numeric(RCRArecurring[1,2]-RCRArecurring[2,2]))
RCRArecurring[2,5] <- as.numeric(RCRArecurring[2,2])
RCRArecurring$Proportional <- (as.numeric((100/(RCRArecurring[1,2]))*RCRArecurring[1,5]))
RCRArecurring[2,6] <- as.numeric(100-RCRArecurring[1,6])
RCRArecurring[3] <-round(RCRArecurring[3],2)


##RCRA pie chart

# Compute the position of labels
RCRArecurring <- RCRArecurring %>%
  arrange(desc(Region)) %>%
  mutate(prop = Proportional) %>%
  mutate(ypos = cumsum(prop)- 0.5*prop )

RCRApie <- ggplot(RCRArecurring, aes(x = "", 
                                   y = Proportional, 
                                   fill = Region)) +
  geom_bar(stat = "identity", 
           show.legend = FALSE, 
           width = 1,
           color = "white") +
  geom_text(x = 1.2, aes(y = ypos, 
                label = RecurringViolators, family="Georgia"),
            color = "black",
            size = 6) +
  geom_text_repel(aes(x = 1.5, 
                      y = ypos, 
                      label = paste("This is",Percent,"% of facilities\nin", Region2)),
                   segment.color = "gray80",
                   color = "gray50",
                   size = 3,
                   nudge_x = .4, 
                   segment.size = 0.6, 
                   show.legend = FALSE, family="Georgia") +
  ggtitle("Resource Conservation\nand Recovery Act") +
  scale_fill_manual(values=c("yellow","#00bfff")) +
  scale_color_manual(values=c("yellow","#00bfff")) +
  coord_polar("y", start = 0) +
  theme_minimal() +
  theme(axis.line = element_blank(),
        axis.text = element_blank(),
        panel.grid = element_blank(),
        axis.title = element_blank(),
        plot.title = element_text(hjust = 0.5, margin = margin(0,0,0,0), family="Georgia"))

CAApie | CWApie | RCRApie  

```

```{r echo=FALSE }
##getting %difference effluent violations

##So, we're going to do the first 3 years of Obama and Trump so average
#[9:11,2] Obama
# [17:19,2] Trump
effluentviolations <- `effluent-violations_CWA_pg3_MA-4`
effluentchange <- data.frame("Obama Average" =mean(effluentviolations[9:11,2]),
                             "Trump Average" =mean(effluentviolations[17:19,2]))
effluentchange$PercentDifference <- as.numeric(100*(effluentchange[1,2]-effluentchange[1,1])/
                                                 effluentchange[1,1])
effluentchange[,1:3] <-round(effluentchange[,1:3],2)

#then simple plot
#first add in the Presidential Years
effluentviolations$President <- as.character("Bush")
effluentviolations[9:16,3] <- as.character("Obama")
effluentviolations[17:20,3] <- as.character("Trump")

effluentgraph <- ggplot(effluentviolations, mapping=aes(x=factor(Year),
  y=Violations, color=President, group=1))+
  scale_color_viridis(discrete= TRUE)+
  geom_point(size=3, show.legend=FALSE)+
  geom_line(show.legend=FALSE)+
  labs(y="Violations", x="Year")+
  ggtitle("CWA Effluent Violations in MA 4")+
  scale_y_continuous(expand=c(0,0), limits=c(0,450))+
  scale_x_discrete(breaks=c(2004,2008,2012,2016,2020))+
  theme_meg()+
  theme(axis.text.x=element_text(size=8), axis.title.x = element_blank())

##Inspections % change and graph

##So, we're going to do the first 3 years of Obama and Trump so average
#[9:11,2] Obama
# [17:19,2] Trump
inspections <- `inspections_All_pg3_MA-4`
inspectionchange <- data.frame("Obama Average" =mean(inspections[9:11,2]),
                             "Trump Average" =mean(inspections[17:19,2]))
inspectionchange$PercentDifference <- as.numeric(100*(inspectionchange[1,2]-inspectionchange[1,1])/
                                                 inspectionchange[1,1])
inspectionchange[,1:3] <-round(inspectionchange[,1:3],2)

#then simple plot
#first add in the Presidential Years
inspections$President <- as.character("Bush")
inspections[9:16,3] <- as.character("Obama")
inspections[17:20,3] <- as.character("Trump")

inspectiongraph <- ggplot(inspections, mapping=aes(x=factor(Date),
                                                        y=Count, color=President, group=1))+
  scale_color_viridis(discrete= TRUE)+
  geom_point(size=3, show.legend=FALSE)+
  geom_line(show.legend=FALSE)+
  labs(y="Inspections", x="Year")+
  ggtitle("Facility Inspections in MA 4")+
  scale_y_continuous(expand=c(0,0), limits=c(0,125))+
  scale_x_discrete(breaks=c(2004,2008,2012,2016,2020))+
  theme_meg()+
  theme(axis.title.x = element_blank(), axis.text.x=element_text(size=8))

#enforcement
##So, we're going to do the first 3 years of Obama and Trump so average
#[9:11,2] Obama
# [17:19,2] Trump
enforcement <- `enforcements_All_pg3_MA-4`
enforcement$Amount <- round(enforcement$Amount,0)
enforcementchange <- data.frame("Obama Average Count" =mean(enforcement[9:11,2]),
                               "Trump Average Count" =mean(enforcement[17:19,2]),
                               "Obama Average Fine" =mean(enforcement[9:11,3]),
                               "Trump Average Fine" =mean(enforcement[17:19,3]))
enforcementchange$PercentDifferenceCount <- as.numeric(100*(enforcementchange[1,2]-enforcementchange[1,1])/
                                                   enforcementchange[1,1])
enforcementchange$PercentDifferenceFine <- as.numeric(100*(enforcementchange[1,4]-enforcementchange[1,3])/
                                                         enforcementchange[1,3])
enforcementchange[,1:6] <-round(enforcementchange[,1:6],2)

#plot change in enforcement
enforcement$President <- as.character("Bush")
enforcement[9:16,4] <- as.character("Obama")
enforcement[17:20,4] <- as.character("Trump")

enforcementactiongraph <- enforcement %>% ggplot()+
  geom_point(aes(x=factor(Date),y=Count, color=President, group=1), show.legend=FALSE)+
  scale_color_viridis(discrete=TRUE)+
  geom_line(aes(x=factor(Date),y=Count, color=President, group=1), show.legend = FALSE)+
  labs(y="# Actions", x="Year")+
  ggtitle("Formal Enforcement Actions in MA 4")+
  scale_y_continuous(expand=c(0,0), limits=c(0,40))+
  scale_x_discrete(breaks=c(2004,2008,2012,2016,2020))+
  theme_meg()+
  theme(axis.text.x=element_text(size=8),axis.title.x = element_blank())

enforcementfinegraph <- enforcement %>% ggplot()+
  geom_point(aes(x=factor(Date),y=Amount, color=President, group=1))+
  scale_color_viridis(discrete=TRUE)+
  geom_line(aes(x=factor(Date),y=Amount, color=President, group=1))+
  labs(y="Fines ($)", x="Year")+
  ggtitle("Enforcement Fines in MA 4")+
  scale_y_continuous(expand=c(0,0), limits=c(0,3000000))+
  scale_x_discrete(breaks=c(2004,2008,2012,2016,2020))+
  guides(shape = guide_legend(override.aes = list(size = 1.5)))+
  guides(color = guide_legend(override.aes = list(size = 1.5)))+
  theme_meg()+
  theme(axis.text.x=element_text(size=8),legend.position=c(.9,.8),  legend.title = element_text(size = 6), 
               legend.text = element_text(size = 6))


effluentgraph/inspectiongraph/enforcementactiongraph/enforcementfinegraph

```
\pagebreak

<hr style="height:3px;border-width:0;color: #C1E0D7;background-color: #C1E0D7; margin-top: 4em">

##### DISTRICT INFORMATION

# Your District in Comparison

### The following two figures display the number of inspections and violations at the national, state, and district level per 1000 regulated facilites in 2019. Soon this will also include enforcement actions and fines 
```{r, fig.height = 6, fig.width = 8, fig.align = "left"}

#comparing inspections

#let's combine the inspections data at national, state, CD level 
names(USAinspectionsper1000_All)[2] <- "Inspectionsper1000"
USAinspectionsper1000_All$Region <- as.factor("National")
names(`inspectionsper1000_All_pg4_MA-081120 (1).csv`)[2] <- "Inspectionsper1000"
`inspectionsper1000_All_pg4_MA-081120 (1).csv`$Region <- as.factor("State")
names(`inspectionsper1000_All_pg4_MA-4`)[2] <- "Inspectionsper1000"
`inspectionsper1000_All_pg4_MA-4`$Region <- as.factor("Congressional District")
inspectionsper1000 <- rbind(USAinspectionsper1000_All, `inspectionsper1000_All_pg4_MA-081120 (1).csv`, `inspectionsper1000_All_pg4_MA-4`)
inspectionsper1000$Inspectionsper1000 <- as.numeric(inspectionsper1000$Inspectionsper1000)
inspectionsper1000[2] <-round(inspectionsper1000[2],0) 

#Now let's visualize this 
inspect1000bar <- ggplot(inspectionsper1000, aes(fill=Region, y=Inspectionsper1000, x=Program))+
  geom_bar(position="dodge", stat="identity")+
  scale_fill_manual(values=c("#e56d13" , "#25539f", "#d43a69"))+
  labs(y="Inspections per 1000 Facilities\n", x="")+
  geom_text(aes(label=Inspectionsper1000, family="Georgia"), position = position_dodge(0.9), vjust = -0.1, size=4)+
  ggtitle("Inspections per 1000 Facilities in 2019")+
  scale_y_continuous(expand=c(0,0),limits = c(0,300))+
  theme_meg()+
  theme(legend.position = c(0.8, 0.5))

#comparing violations
#let's combine the violations data at national, state, CD level 
names(USAviolationsper1000_All)[2] <- "violationsper1000"
USAviolationsper1000_All$Region <- as.factor("National")
names(`violationsper1000_All_pg4_MA-081220.csv`)[2] <- "violationsper1000"
`violationsper1000_All_pg4_MA-081220.csv`$Region <- as.factor("State")
names(`violationsper1000_All_pg4_MA-4`)[2] <- "violationsper1000"
`violationsper1000_All_pg4_MA-4`$Region <- as.factor("Congressional District")
violationsper1000 <- rbind(USAviolationsper1000_All, `violationsper1000_All_pg4_MA-081220.csv`, `violationsper1000_All_pg4_MA-4`)
violationsper1000$violationsper1000 <- as.numeric(violationsper1000$violationsper1000)
violationsper1000[2] <-round(violationsper1000[2],0)

#Now let's visualize this 
violations1000bar <- ggplot(violationsper1000, aes(fill=Region, y=violationsper1000, x=Program))+
  geom_bar(position="dodge", stat="identity")+
  scale_fill_manual(values=c("#e56d13" , "#25539f", "#d43a69"))+
  labs(y="Violations per 1000 Facilities\n", x="")+
  geom_text(aes(label=violationsper1000, family="Georgia"), position = position_dodge(0.9), vjust = -0.1, size=4)+
  ggtitle("Violations per 1000 Facilities in 2019")+
  scale_y_continuous(expand=c(0,0),limits = c(0,600))+
  theme_meg()+
  theme(legend.position = c(0.8, 0.5))

inspect1000bar / violations1000bar
  
```

### Still need - 
* Enforcement fines nationally and statewide 
* GHG emissions nationally and statewide (2018)



\pagebreak

<hr style="height:3px;border-width:0;color: #C1E0D7;background-color: #C1E0D7; margin-top: 4em">
##### Program Specific Information 

# Clean Air Act

<div class="text-box-info">

The Clean Air Act (CAA) is the comprehensive federal law that regulates air emissions from stationary and mobile sources. Among other things, this law authorizes EPA to establish National Ambient Air Quality Standards (NAAQS) to protect public health and to regulate emissions of hazardous air pollutants [EPA](https://www.epa.gov/laws-regulations/summary-clean-air-act). For the CAA, inspections are the most common way of identifying violations, so less violations aren't necessarily an improvement. Recent cuts in inspections is likely related to a drop in violations.
[More info on CAA](https://docs.google.com/presentation/d/1MzRQf3QeJqmYMSttdk0ghrXeOmOZgOV_MTynl-ri6Ik/edit?usp=sharing)
</div>

```{r, fig.height = 5, fig.width = 8, fig.align = "center"}
largernumbers <- element_text(face = "bold", size = 14)
largernumbers2 <- element_text(face = "bold", size = 12)

vCAAviol <- ggplot(vCAA, mapping=aes(x=factor(year), y=CAA_violations, color=President, group=1))+
  scale_color_manual(values=c("#25539f", "#d43a69"))+
  geom_point(size=3)+
  geom_line()+
  labs(y="CAA violations", x="Year")+
  ggtitle("CAA violations in MA 4")+
  theme_bw()+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),panel.border = element_blank(),
        axis.line = element_line(colour = "black"),
        axis.title.x=largernumbers,
        axis.text.y=largernumbers2, axis.title.y=largernumbers,plot.title = largernumbers,
        axis.text.x=element_text(angle= 80,hjust=1))

iCAAinsp <- ggplot(iCAA, mapping=aes(x=factor(year), y=CAA_inspections, color=President, group=1))+
  scale_color_manual(values=c("#25539f", "#d43a69"))+
  geom_point(size=3)+
  geom_line()+
  labs(y="CAA Inspections", x="Year")+
  ggtitle("CAA Inspections in MA 4")+
  theme_bw()+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),panel.border = element_blank(),
        axis.line = element_line(colour = "black"),
        axis.title.x=largernumbers,
        axis.text.y=largernumbers2, axis.title.y=largernumbers,plot.title = largernumbers,
        axis.text.x=element_text(angle= 80,hjust=1))

eCAAe <- ggplot(eCAA, mapping=aes(x=factor(year), y=CAA_enforcement, color=President, group=1))+
  scale_color_manual(values=c("#25539f", "#d43a69"))+
  geom_point(size=3)+
  geom_line()+
  labs(y="CAA Enforcement ($)", x="Year")+
  ggtitle("CAA Enforcement in MA 4")+
  theme_bw()+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),panel.border = element_blank(),
        axis.line = element_line(colour = "black"),
        axis.title.x=largernumbers,
        axis.text.y=largernumbers2, axis.title.y=largernumbers,plot.title = largernumbers,
        axis.text.x=element_text(angle= 80,hjust=1))


(vCAAviol | iCAAinsp) / eCAAe



```
<div class="body">
### Add here: 

* Enforcement # over time since 2001	
* Number and Naming facilities with top compliance problems past 3 years
</div>


\pagebreak

<hr style="height:3px;border-width:0;color: #C1E0D7;background-color: #C1E0D7; margin-top: 4em">
##### Program Specific Information 

# Clean Water Act 

<div class="text-box-info">

The Clean Water Act is a series of regulations that govern discharges of pollutants and regulates water quality standards for waters of the United States. The CWA established the National Pollutant Discharge Elimination System (NPDES) which permits discharges of pollutants [EPA](https://www.epa.gov/laws-regulations/summary-clean-water-act). Unlike the CAA, CWA violations are reported automatically through the National Pollutant Discharge Elimination System (NPDES), so violations are recorded independently of facility inspections. CWA inspections often occur in response to recorded violations.
[More info on CWA](https://docs.google.com/presentation/d/1g6ZN3B5jvs3F1VAigiUtNNezjXdJnzuELfo9Deo9Y2w/edit?usp=sharing)
</div>

### Once we have the data, add here:

* Violations over time since 2001	
* Inspections over time since 2001	
* Enforcement ($ and #) over time since 2001	
* Number and Naming facilities with top compliance problems past 3 years	


\pagebreak

<hr style="height:3px;border-width:0;color: #C1E0D7;background-color: #C1E0D7; margin-top: 4em">

##### Program Specific Information

# Resource Conservation and Recovery Act 


<div class="text-box-info">

The Resource Conservation and Recovery Act (RCRA) gives EPA the authority to 
control hazardous waste from the "cradle-to-grave", regulating the generation, transportation, treatment, storage, and disposal of hazardous waste. Although facilities self-report under RCRA, like the CAA, violations are most often found after an inspection, and a reduction in violations might mean a reduction in inspections. [EPA](https://www.epa.gov/laws-regulations/summary-resource-conservation-and-recovery-act) [More info on RCRA](https://docs.google.com/presentation/d/1lV9b_vkcfCbTz8uss1XjXLHy2svpi2tmizb6et1Wfkc/edit?usp=sharing)

</div>

```{r, fig.height = 5, fig.width = 8, fig.align = "center"} 
largernumbers <- element_text(face = "bold", size = 14)
largernumbers2 <- element_text(face = "bold", size = 12)

vRCRAviol <- ggplot(vRCRA, mapping=aes(x=factor(year), y=RCRA_violations, color=President, group=1))+
  scale_color_manual(values=c("#e56d13" , "#25539f", "#d43a69"))+
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

iRCRAinsp <- ggplot(iRCRA, mapping=aes(x=factor(year), y=RCRA_inspections, color=President, group=1))+
  scale_color_manual(values=c("#e56d13" , "#25539f", "#d43a69"))+
  geom_point(size=3)+
  geom_line()+
  labs(y="RCRA Inspections", x="Year")+
  ggtitle("RCRA Inspections in MA 4")+
  theme_bw()+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),panel.border = element_blank(),
        axis.line = element_line(colour = "black"),
        axis.title.x=largernumbers,
        axis.text.y=largernumbers2, axis.title.y=largernumbers,plot.title = largernumbers,
        axis.text.x=element_text(angle= 80,hjust=1))

eRCRAe <- ggplot(eRCRA, mapping=aes(x=factor(year), y=RCRA_enforcement, color=President, group=1))+
  scale_color_manual(values=c("#e56d13" , "#25539f", "#d43a69"))+
  geom_point(size=3)+
  geom_line()+
  labs(y="RCRA Enforcement", x="Year")+
  ggtitle("RCRA Enforcement in MA 4")+
  theme_bw()+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),panel.border = element_blank(),
        axis.line = element_line(colour = "black"),
        axis.title.x=largernumbers,
        axis.text.y=largernumbers2, axis.title.y=largernumbers,plot.title = largernumbers,
        axis.text.x=element_text(angle= 80,hjust=1))


(vRCRAviol | iRCRAinsp) / eRCRAe



```

<div class="body">
### Add here: 

* Enforcement # over time since 2001	
* Number and Naming facilities with top compliance problems past 3 years
</div>



\pagebreak

<hr style="height:3px;border-width:0;color: #C1E0D7;background-color: #C1E0D7; margin-top: 4em">
##### Program Specific Information 

# The Greenhouse Gas Reporting Program  

<div class="text-box-info">

The GHGRP is an EPA Program mandated by law that requires reporting of major sources and suppliers of GHG emissions in the United States, including from large direct emissions sources, fuel and industrial gas suppliers, and CO2 injections sites. About 8,000 facilities are required to report their emissions annually, covering 85-90% of total US Annual GHG emissions [EPA](https://www.epa.gov/ghgreporting). By reporting direct sources and suppliers in the same way, the program can misrepresent the geography of emissions, making it appear as if industrial regions have an excess of emissions and suburban areas--where many household-level direct emissions occur--have little to no emissions. 
[More info on GHGRP](https://docs.google.com/presentation/d/1oky0P2PSVsURLACzw6i3JaTtaNW_L1y0c2qpkEWBmds/edit?usp=sharing)

</div>

### Once we have the data, add here:

* Your district, 2010-2018 < what does this look like visually?
* Real world comparison	
* Major emitters in your district	


\pagebreak

<hr style="height:3px;border-width:0;color: #C1E0D7;background-color: #C1E0D7; margin-top: 4em">


##### About the Report  

# Data Limitations   

<div class="text-box-info">

<h3>Disclaimer</h3>

<p>Info about COVID policy.</p>

</div>

* Gaps and Problems with ECHO data
  + Inability to assess compliance over time
  + Inability to easily assess data on politically-meaningful timeframes, e.g. 2, 4,     and 6 years. Just 3 and 5.
  + No idea how many facilities operated in the past
  + Multiple program IDs for a single facility/permit
  + Geocoding errors
  + Mislabeled times (e.g. the inspections that will occur in 2052)



\pagebreak

<hr style="height:3px;border-width:0;color: #C1E0D7;background-color: #C1E0D7; margin-top: 4em">


##### About the Report

# About the Authors

### About EEW and this Project

Environmental Enforcement Watch (EEW) is a collaborative project across EDGI working groups. The EEW project builds on EDGI’s 2019 [Sheep in the Closet Report](https://envirodatagov.org/publication/a-sheep-in-the-closet-the-erosion-of-enforcement-at-the-epa/) that documents large declines in EPA enforcement of environmental laws. This project and others used data from EPA’s [ECHO](https://echo.epa.gov/) database, revealing how useful ECHO could be for communities to track pollution and EPA responses in their areas. However, they also revealed the inaccessibility of ECHO for non-specialists, along with many omissions, errors, and confusions present in the data itself.

A key goal of EEW is to highlight gaps and inadequacies in the enforcement of environmental laws, demonstrating EPA’s failure to fulfill its congressionally mandated duty. To help bring awareness and action to the state of environmental non-compliance across the US, we are using Jupyter Notebooks that utilize ECHO data to present these congressional report cards for the 75 Senators and House Representatives that sit on the House Energy & Commerce Committee and the Senate Environment & Public Works Committee. By providing a novel and poignant look at the chronic state of non-compliance in their states and districts, we hope to provide these key representatives with the information and pressure they need to hold the EPA accountable. 


<div class="text-box-info">

<h3>About EDGI</h3>
<p>EDGI is an international network of over 175 members from more than 80 different academic institutions and non-profits, comprised foremost by grassroots volunteer efforts. Since 2016, EDGI has served as a preeminent watchdog group for federal environmental data, generating international effort to duplicate and monitor repositories of public data that are vital to environmental health research and knowledge.
EDGI’s work has been widely acknowledged, leading to EDGI testifying before Congress on declines in EPA enforcement, and hundreds of mentions in leading national and international media such as _The New York Times_,_The Washington Post_, Vice News, and CNN. For more about our work, read our [2019 Annual Report](https://envirodatagov.org/publication/edgi-annual-report-2019/)and [2020 Annual Report](https://envirodatagov.org/publication/edgi-annual-report-2020/).<p>

</div>


#### [Contact Us](https://www.environmentalenforcementwatch.org/contact/)

<div class="text-box-info">

<h3>Links to data will eventually appear here</h3>

</div>


<a href="https://www.environmentalenforcementwatch.org/"><img src="eew_logo.png" style="float: left; width: 25%; margin-left: 20%" ></a>

<a href="https://envirodatagov.org/"><img src="edgi_logo.png" style="float: right; width: 35%; margin-right: 20%" ></a>

