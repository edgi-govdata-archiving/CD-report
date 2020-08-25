# create a dataset
specie <- c(rep("sorgho" , 3) , rep("poacee" , 3) , rep("banana" , 3) , rep("triticum" , 3) )
condition <- rep(c("normal" , "stress" , "Nitrogen") , 4)
value <- abs(rnorm(12 , 0 , 15))
data <- data.frame(specie,condition,value)

theme_meg <- function () {
  theme_bw(base_family="Georgia") %+replace%
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),panel.border = element_blank(),
          axis.line = element_line(colour = "black"), axis.title.x=element_text(face = "bold", size = 14),
          axis.title.y=element_text(face = "bold", size = 14, angle=90), plot.title=element_text(face = "bold", size = 14, hjust =.5),
          axis.text.x=element_text(face = "bold", size = 14), axis.text.y=element_text(face = "bold", size = 12))
}


scale_fill_manual(values=c("#e56d13" , "#25539f", "#d43a69"))+
  labs(y="Inspections per 1000 Facilities", x="Program")+
  geom_text(aes(label=Inspectionsper1000), position = position_dodge(width=1), size=8)+
  ggtitle("Comparing Inspections per 1000 Facilities")+
  theme_bw()+
  theme(legend.position = c(0.8, 0.5))

scale_color_viridis(option = "D", discrete = FALSE)+

# Grouped
test <- ggplot(data, aes(fill=condition, y=value, x=specie)) +
  geom_bar(position="dodge", stat="identity")+
  theme_meg()

test


#testing pie charts


df <- data.frame(
  group = c("RestofState", "MA 4"),
  value = c(75,3)
)
head(df)

bp<- ggplot(df, aes(x="", y=value, fill=group))+
  geom_bar(width = 1, stat = "identity")
bp

pie <- bp + coord_polar("y", start=0)
pie


##let's attempt these pie charts

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

RCRApie<- ggplot(RCRArecurring, aes(x="", y=Proportional, fill=Region))+
  geom_bar(width = 1, stat = "identity")+
  coord_polar("y", start=0) +
  geom_text(aes(y = ypos, label = RecurringViolators), family="Georgia", size=8) +
  geom_text(aes(y = ypos, label = (paste(Percent,"% of regulated facilities\nin", Region2))),
            family="Georgia", size=4, vjust=2) +
  ggtitle("Number of Resource Conservation and Recovery Act\nFacilities that spent at least 25% of the last 3 years in Violation")+
  theme_meg()+
  theme(plot.title=element_text(face = "bold", size = 12, hjust =.5),
        axis.line.y=element_blank(), axis.line.x = element_blank(),
        axis.title.y=element_blank(), axis.text.y=element_blank(), axis.text.x=element_blank(),
        axis.title.x=element_blank(), legend.title=element_blank())

RCRApie



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
  labs(y="CWA Effluent Violations", x="Year")+
  ggtitle("CWA Effluent Violations in MA 4")+
  scale_y_continuous(expand=c(0,0), limits=c(0,450))+
  scale_x_discrete(breaks=c(2004,2008,2012,2016,2020))+
  theme_meg()+
  theme(axis.text.x=element_text(size=8), axis.title.x = element_blank())
effluentgraph



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
inspectiongraph


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
  labs(y="Formal Enforcement Actions", x="Year")+
  ggtitle("Formal Enforcement Actions in MA 4")+
  scale_y_continuous(expand=c(0,0), limits=c(0,40))+
  scale_x_discrete(breaks=c(2004,2008,2012,2016,2020))+
  theme_meg()+
  theme(axis.text.x=element_text(size=8),axis.title.x = element_blank())
enforcementactiongraph

enforcementfinegraph <- enforcement %>% ggplot()+
  geom_point(aes(x=factor(Date),y=Amount, color=President, group=1))+
  scale_color_viridis(discrete=TRUE)+
  geom_line(aes(x=factor(Date),y=Amount, color=President, group=1))+
  labs(y="Enforcement Fines", x="Year")+
  ggtitle("Enforcement Fines in MA 4")+
  scale_y_continuous(expand=c(0,0), limits=c(0,3000000))+
  scale_x_discrete(breaks=c(2004,2008,2012,2016,2020))+
  theme_meg()+
  theme(axis.text.x=element_text(size=8), legend.position = c(.9,.9), axis.text.y=element_text(angle=90))
enforcementfinegraph

grid.arrange(effluentgraph,inspectiongraph,enforcementactiongraph, enforcementfinegraph,
             nrow=4) #arranges plots within grid

#$$ graph
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



grid.arrange(effluentgraph,inspectiongraph,enforcegraph, nrow=4) #arranges plots within grid

install.packages("fishualize")
library(fishualize)

