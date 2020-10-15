
filenames = list.files(here("nationalstats"), pattern = ".csv")
file_count = length(filenames)
for (i in filenames){
  name <- gsub("^([^_]*_[^_]*)_.*$","\\1", i)
  assign(name, read.csv(here("nationalstats", i)))
}


CWAper1000 <- violationsper1000_dotplot.csv


##dotplot for NY9 - replace the dotplot code in the .rmd with this for NY9

CWAper1000$Num.per.1000 <- as.numeric(round(CWAper1000$Num.per.1000,0))
CWAper10002 <- CWAper1000
CWAper10002$Test <- as.numeric(0)
CWAper10002$Highlight <- ifelse(CWAper10002$CD.State=="NY9", "NY9", "Other")
CWAper1000$Highlight <- ifelse(CWAper1000$CD.State=="NY9", "NY9", "Other")
CWAper1000$Per100 <- as.numeric(CWAper1000$Num.per.1000/10)


#make a dataframe that is per 100

CWAper100 <- CWAper1000
#removing NY9 and WA5 and MI7, AK, and IA2
CWAper100 <- CWAper100[-c(37,51,28,14,53),]

#total dot plot

dotplot <-ggplot(CWAper100, aes(x=Region, y=Per100, label=CD.State))+
  geom_dotplot(binaxis='y', stackdir='center', stackratio=2,
               dotsize=1, fill="white")+
  geom_hline(yintercept=100, linetype="dashed", color="#e56d13")+
  geom_hline(yintercept=0, linetype="dashed", color="#569b5e")+
  scale_fill_manual(values=c("#ffffff"))+
  labs(title="CWA Violations per 100 Facilities in 2019", x="CD/State", y="")+
  geom_text(aes(label="100 violations per\n100 facilities*", family="Georgia"),
            x=2.35, y=180, color="#e56d13", size=5)+
  geom_text(aes(label="0 violations", family="Georgia"),
            x=2.4, y=15, color="#569b5e", size=5)+
  annotate("text", label="Outliers (not displayed):\nNY9-2650 violations\nWA5-1029 violations\nMI7-865 violations\nAK-841 violations\nIA2-826 violations",
           x=2.3, y=600, color="black", size=5, family="Georgia")+
  #geom_text_repel(aes(family="Georgia"), point.padding= NA, size=2, color = "black", hjust=1)+
  theme_meg()+
  theme(axis.line.x=element_blank(), axis.title.x=element_blank(), plot.title = element_text(size=18),
        legend.title = element_blank(), axis.text.x=element_text(size=15, hjust=.6), axis.text.y=element_text(size=12),
          legend.position = c(0.1,.8), axis.ticks.x=element_blank())+
  scale_x_discrete(labels=c("Energy and Commerce\nCongressional Districts","Environment and Public\nWorks States"))



ggsave("dotplot_total.png", dotplot, path=here("outlierdotplots"), scale = 3, width=16, height=10, units=c("cm"))

dotplot <- ggplot(CWAper100, aes(x=Region, y=Per100, label=CD.State))+
  geom_dotplot(binaxis='y', stackdir='center', stackratio=2,
               dotsize=1, fill="white")+
  scale_fill_manual(values=c("#ffffff"))

point.pos <- ggplot_build(dotplot)$data[[1]]

# Order rows of CDs by violations
idx <- order(CWAper100$Per100)
CWA2 <- CWAper100[idx,]

write.csv(CWA2, here("outlierdotplots/dotplotdata_ordered.csv"))


# scale.fact needs fine tuning
# It is strictly connected to the dimensions of the plot
scale.fact <- 10
CWA2$ytext <- point.pos$stackpos*scale.fact
CWA2$xtext <- point.pos$x
lbls <- gsub(" ","\n",rownames(CWA2))

png(file="myplot.png", width=4000, height=2500, res=300)
ggplot(CWA2, aes(x=Region, y=Per100, label=CD.State))+
  geom_dotplot(binaxis='y', stackdir='center', stackratio=2,
               dotsize=1, fill="white")+
  geom_hline(yintercept=100, linetype="dashed", color="#e56d13")+
  geom_hline(yintercept=0, linetype="dashed", color="#569b5e")+
  scale_fill_manual(values=c("#ffffff"))+
  labs(title="CWA Violations per 100 Facilities in 2019", x="CD/State", y="")+
  geom_text(aes(label="100 violations per\n100 facilities*", family="Georgia"),
            x=2.35, y=180, color="#e56d13", size=3)+
  geom_text(aes(label="0 violations", family="Georgia"),
            x=2.4, y=15, color="#569b5e", size=3)+
  annotate("text", label="Outliers (not displayed):\nNY9-2650 violations\nWA5-1029 violations\nMI7-865 violations\nAK-841 violations\nIA2-826 violations",
           x=2.3, y=600, color="black", size=3, family="Georgia")+
  theme_meg()+
  theme(axis.line.x=element_blank(), axis.title.x=element_blank(),
        legend.title = element_blank(), axis.text.x=element_text(size=10, hjust=.6), legend.position = c(0.1,.8), axis.ticks.x=element_blank())+
  scale_x_discrete(labels=c("Energy and Commerce\nCongressional Districts","Environment and Public\nWorks States"))+
  geom_text(aes(label=CD.State, x=xtext, y=ytext), size=3)
dev.off()


#######

ggsave("dotplot_NY9.png", dotplot, path=here("outlierdotplots"), scale = 2, width=8, height=5, units=c("cm"))

dotplot <-ggplot(CWAper100, aes(x=Region, y=Per100, label=CD.State))+
  geom_point(aes(color="black", fill="white"),size=3, shape=21, color= "black", fill="white")+
  geom_hline(yintercept=100, linetype="dashed", color="#e56d13")+
  geom_hline(yintercept=0, linetype="dashed", color="#569b5e")+
  labs(title="CWA Violations per 100 Facilities in 2019", x="CD/State", y="")+
  geom_text(aes(label="100 violations per\n100 facilities*", family="Georgia"),
            x=2.35, y=180, color="#e56d13", size=3)+
  geom_text(aes(label="0 violations", family="Georgia"),
            x=2.4, y=15, color="#569b5e", size=3)+
  annotate("text", label="Outliers (not displayed):\nNY9-2650 violations\nWA5-1029 violations\nMI7-865 violations\nAK-841 violations\nIA2-826 violations",
           x=2.3, y=600, color="black", size=3, family="Georgia")+
  geom_text_repel(aes(family="Georgia"), point.padding= NA, size=2, color = "black", hjust=1)+
  scale_y_continuous(limits=c(0,200))+
  theme_meg()+
  theme(axis.line.x=element_blank(), axis.title.x=element_blank(),
        legend.title = element_blank(), axis.text.x=element_text(size=10, hjust=.6), legend.position = c(0.1,.8), axis.ticks.x=element_blank())+
  scale_x_discrete(labels=c("Energy and Commerce\nCongressional Districts","Environment and Public\nWorks States"))
dotplot


ggsave("dotplot_test.png", dotplot, path=here("outlierdotplots"), scale = 2, width=8, height=10, units=c("cm"))




#ny9

dotplot <-ggplot(CWAper100, aes(x=Region, y=Per100, fill=Highlight))+
  geom_dotplot(binaxis='y', stackdir='centerwhole', stackratio=2.5, binwidth=15,
               dotsize=2)+
  geom_hline(yintercept=100, linetype="dashed", color="#e56d13")+
  geom_hline(yintercept=0, linetype="dashed", color="#569b5e")+
  scale_fill_manual(values=c("#ffffff","#e56d13"))+
  labs(title="CWA Violations per 100 Facilities in 2019", x="CD/State", y="")+
  geom_text(aes(label="100 violations per\n100 facilities*", family="Georgia"),
            x=2.35, y=180, color="#e56d13", size=3)+
  geom_text(aes(label="0 violations", family="Georgia"),
            x=2.4, y=15, color="#569b5e", size=3)+
  annotate("text", label="Outliers (not displayed):",
             x=2.3, y=600, color="black", size=3, family="Georgia")+
  annotate("text", label="NY9-2650 violations",
           x=2.3, y=573, color="#e56d13", size=3, family="Georgia", fontface="bold")+
  annotate("text", label="WA5-1029 violations\nMI7-865 violations\nAK-841 violations\nIA2-826 violations",
           x=2.3, y=480, color="black", size=3, family="Georgia")+
  theme_meg()+
  theme(axis.line.x=element_blank(), axis.title.x=element_blank(),
        legend.title = element_blank(), axis.text.x=element_text(size=10, hjust=.6), legend.position = c(0.1,.8), axis.ticks.x=element_blank())+
  scale_x_discrete(labels=c("Energy and Commerce\nCongressional Districts","Environment and Public\nWorks States"))



ggsave("dotplot_NY9.png", dotplot, path=here("outlierdotplots"), scale = 2, width=8, height=5, units=c("cm"))


#WA5

dotplot <-ggplot(CWAper100, aes(x=Region, y=Per100, fill=Highlight))+
  geom_dotplot(binaxis='y', stackdir='centerwhole', stackratio=2.5, binwidth=15,
               dotsize=2)+
  geom_hline(yintercept=100, linetype="dashed", color="#e56d13")+
  geom_hline(yintercept=0, linetype="dashed", color="#569b5e")+
  scale_fill_manual(values=c("#ffffff","#e56d13"))+
  labs(title="CWA Violations per 100 Facilities in 2019", x="CD/State", y="")+
  geom_text(aes(label="100 violations per\n100 facilities*", family="Georgia"),
            x=2.35, y=180, color="#e56d13", size=3)+
  geom_text(aes(label="0 violations", family="Georgia"),
            x=2.4, y=15, color="#569b5e", size=3)+
  annotate("text", label="Outliers (not displayed):\nNY9-2650 violations",
           x=2.3, y=600, color="black", size=3, family="Georgia")+
  annotate("text", label="WA5-1029 violations",
           x=2.3, y=550, color="#e56d13", size=3, family="Georgia", fontface="bold")+
  annotate("text", label="MI7-865 violations\nAK-841 violations\nIA2-826 violations",
           x=2.3, y=480, color="black", size=3, family="Georgia")+
  theme_meg()+
  theme(axis.line.x=element_blank(), axis.title.x=element_blank(),
        legend.title = element_blank(), axis.text.x=element_text(size=10, hjust=.6), legend.position = c(0.1,.8), axis.ticks.x=element_blank())+
  scale_x_discrete(labels=c("Energy and Commerce\nCongressional Districts","Environment and Public\nWorks States"))

ggsave("dotplot_WA5.png", dotplot, path=here("outlierdotplots"), scale = 2, width=8, height=5, units=c("cm"))


#MI7

dotplot <-ggplot(CWAper100, aes(x=Region, y=Per100, fill=Highlight))+
  geom_dotplot(binaxis='y', stackdir='centerwhole', stackratio=2.5, binwidth=15,
               dotsize=2)+
  geom_hline(yintercept=100, linetype="dashed", color="#e56d13")+
  geom_hline(yintercept=0, linetype="dashed", color="#569b5e")+
  scale_fill_manual(values=c("#ffffff","#e56d13"))+
  labs(title="CWA Violations per 100 Facilities in 2019", x="CD/State", y="")+
  geom_text(aes(label="100 violations per\n100 facilities*", family="Georgia"),
            x=2.35, y=180, color="#e56d13", size=3)+
  geom_text(aes(label="0 violations", family="Georgia"),
            x=2.4, y=15, color="#569b5e", size=3)+
  annotate("text", label="Outliers (not displayed):\nNY9-2650 violations\nWA5-1029 violations",
           x=2.3, y=600, color="black", size=3, family="Georgia")+
  annotate("text", label="MI7-865 violations",
           x=2.3, y=525, color="#e56d13", size=3, family="Georgia", fontface="bold")+
  annotate("text", label="AK-841 violations\nIA2-826 violations",
           x=2.3, y=470, color="black", size=3, family="Georgia")+
  theme_meg()+
  theme(axis.line.x=element_blank(), axis.title.x=element_blank(),
        legend.title = element_blank(), axis.text.x=element_text(size=10, hjust=.6), legend.position = c(0.1,.8), axis.ticks.x=element_blank())+
  scale_x_discrete(labels=c("Energy and Commerce\nCongressional Districts","Environment and Public\nWorks States"))

ggsave("dotplot_MI7.png", dotplot, path=here("outlierdotplots"), scale = 2, width=8, height=5, units=c("cm"))


#AK
dotplot <-ggplot(CWAper100, aes(x=Region, y=Per100, fill=Highlight))+
  geom_dotplot(binaxis='y', stackdir='centerwhole', stackratio=2.5, binwidth=15,
               dotsize=2)+
  geom_hline(yintercept=100, linetype="dashed", color="#e56d13")+
  geom_hline(yintercept=0, linetype="dashed", color="#569b5e")+
  scale_fill_manual(values=c("#ffffff","#e56d13"))+
  labs(title="CWA Violations per 100 Facilities in 2019", x="CD/State", y="")+
  geom_text(aes(label="100 violations per\n100 facilities*", family="Georgia"),
            x=2.35, y=180, color="#e56d13", size=3)+
  geom_text(aes(label="0 violations", family="Georgia"),
            x=2.4, y=15, color="#569b5e", size=3)+
  annotate("text", label="Outliers (not displayed):\nNY9-2650 violations\nWA5-1029 violations\nMI7-865 violations",
           x=2.3, y=600, color="black", size=3, family="Georgia")+
  annotate("text", label="AK-841 violations",
           x=2.3, y=505, color="#e56d13", size=3, family="Georgia", fontface="bold")+
  annotate("text", label="IA2-826 violations",
           x=2.3, y=467, color="black", size=3, family="Georgia")+
  theme_meg()+
  theme(axis.line.x=element_blank(), axis.title.x=element_blank(),
        legend.title = element_blank(), axis.text.x=element_text(size=10, hjust=.6), legend.position = c(0.1,.8), axis.ticks.x=element_blank())+
  scale_x_discrete(labels=c("Energy and Commerce\nCongressional Districts","Environment and Public\nWorks States"))

ggsave("dotplot_AK.png", dotplot, path=here("outlierdotplots"), scale = 2, width=8, height=5, units=c("cm"))



#IA2
dotplot <-ggplot(CWAper100, aes(x=Region, y=Per100, fill=Highlight))+
  geom_dotplot(binaxis='y', stackdir='centerwhole', stackratio=2.5, binwidth=15,
               dotsize=2)+
  geom_hline(yintercept=100, linetype="dashed", color="#e56d13")+
  geom_hline(yintercept=0, linetype="dashed", color="#569b5e")+
  scale_fill_manual(values=c("#ffffff","#e56d13"))+
  labs(title="CWA Violations per 100 Facilities in 2019", x="CD/State", y="")+
  geom_text(aes(label="100 violations per\n100 facilities*", family="Georgia"),
            x=2.35, y=180, color="#e56d13", size=3)+
  geom_text(aes(label="0 violations", family="Georgia"),
            x=2.4, y=15, color="#569b5e", size=3)+
  annotate("text", label="Outliers (not displayed):\nNY9-2650 violations\nWA5-1029 violations\nMI7-865 violations\nAK-841 violations",
           x=2.3, y=600, color="black", size=3, family="Georgia")+
  annotate("text", label="IA2-826 violations",
           x=2.3, y=485, color="#e56d13", size=3, family="Georgia", fontface="bold")+
  theme_meg()+
  theme(axis.line.x=element_blank(), axis.title.x=element_blank(),
        legend.title = element_blank(), axis.text.x=element_text(size=10, hjust=.6), legend.position = c(0.1,.8), axis.ticks.x=element_blank())+
  scale_x_discrete(labels=c("Energy and Commerce\nCongressional Districts","Environment and Public\nWorks States"))

ggsave("dotplot_IA2.png", dotplot, path=here("outlierdotplots"), scale = 2, width=8, height=5, units=c("cm"))




