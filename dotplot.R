#Making the dot plot



CWAper1000$Num.per.1000 <- as.numeric(round(CWAper1000$Num.per.1000,0))
CWAper1000$Group <- as.factor("Region")
CWAper10002$Test <- as.numeric(0)
CWAper10002$Highlight <- ifelse(CWAper10002$CD.State=="VA4", "VA4", "Other")
CWAper1000$Highlight <- ifelse(CWAper1000$CD.State=="VA4", "VA4", "Other")


#make a dataframe that is per 100

CWAper100 <- CWAper1000
CWAper100$Per100 <- as.numeric(CWAper100$Num.per.1000/10)
#removing NY9 and WA5 and MI7, AK, and IA2
CWAper100 <- CWAper100[-c(1,21,39,51,70),]


dotplot <-ggplot(CWAper100, aes(x=Group, y=Per100, fill=Highlight))+
  geom_dotplot(binaxis='y', stackdir='centerwhole', stackratio=1.5, binwidth=15, dotsize=1.5 )+
  geom_hline(yintercept=100, linetype="dashed", color="#e56d13")+
  scale_fill_manual(values=c("#ffffff","#569b5e"))+
  labs(title="CWA Violations per 100 Facilities", x="CD/State", y="")+
  geom_text(aes(label="1 violation for every facility", family="Georgia"),
            x=1.4, y=130, color="#e56d13", size=4)+
  theme_meg()+
  theme(axis.text.x=element_blank(), axis.line.x=element_blank(), axis.title.x=element_blank(),
        legend.title = element_blank())

dotplot


dotplot <-ggplot(CWAper100, aes(x=Group, y=Per100, fill=Highlight))+
  geom_dotplot(binaxis='y', stackdir='center', stackratio=1.5, binwidth=15, dotsize=1.5 )+
  scale_fill_manual(values=c("#ffffff","#569b5e"))+
  labs(title="CWA Violations per 100 Facilities", x="CD/State", y="")+
  geom_text_repel(aes(label=CD.State, family="Georgia"), size=3)+
  theme_meg()+
    theme(axis.text.x=element_blank(), axis.line.x=element_blank(), axis.title.x=element_blank(),
          legend.title = element_blank())

dotplot

check_overlap = TRUE, nudge_x=.02

geom_text(aes(label=CD.State, family="Georgia"),
          position = position_dodge(0.9), vjust = -0.8, hjust=.5,size=3)+

CWAper10002$Highlight <- ifelse(CWAper10002$CD.State=="VA4", "VA4", "other")
CWAper1000$Highlight <- ifelse(CWAper1000$CD.State=="VA4", "VA4", "other")


dotplot2 <-ggplot(CWAper10002, aes(x=Group, y=Num.per.1000, fill=Highlight)) +
  geom_point()+
  scale_fill_manual(values=c("black","#569b5e"))+
  labs(title="CWA Violations per 1000 Facilities", x="CD/State", y="")+
  geom_text(aes(label=CD.State, family="Georgia"),
            position = position_dodge(0.9), vjust = -0.8, hjust=.2,size=3)+
  theme_meg()+
  theme(axis.text.x=element_blank(), axis.line.x=element_blank())

dotplot2

,
position = position_dodge(0.9), vjust = -0.1, size=3)+

p
# Change dotsize and stack ratio
ggplot(ToothGrowth, aes(x=dose, y=len)) +
  geom_dotplot(binaxis='y', stackdir='center',
               stackratio=1.5, dotsize=1.2)

