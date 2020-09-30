
filenames = list.files(here("nationalstats"), pattern = ".csv")
file_count = length(filenames)
for (i in filenames){
  name <- gsub("^([^_]*_[^_]*)_.*$","\\1", i)
  assign(name, read.csv(here("nationalstats", i)))
}


CWAper1000 <- violationsper1000_CWA


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
CWAper100 <- CWAper100[-c(38,52,29,15,54),]



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
  annotate("text", label="Outliers:",
             x=2.3, y=600, color="black", size=3, family="Georgia")+
  annotate("text", label="NY9-2650 violations",
           x=2.3, y=573, color="#e56d13", size=3, family="Georgia", fontface="bold")+
  annotate("text", label="WA5-1029 violations\nMI7-865 violations\nAK-841 violations\nIA2-826 violations",
           x=2.3, y=480, color="black", size=3, family="Georgia")+
  theme_meg()+
  theme(axis.line.x=element_blank(), axis.title.x=element_blank(),
        legend.title = element_blank(), axis.text.x=element_text(size=10), legend.position = c(0.1,.8))


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
  annotate("text", label="Outliers:\nNY9-2650 violations",
           x=2.3, y=600, color="black", size=3, family="Georgia")+
  annotate("text", label="WA5-1029 violations",
           x=2.3, y=550, color="#e56d13", size=3, family="Georgia", fontface="bold")+
  annotate("text", label="MI7-865 violations\nAK-841 violations\nIA2-826 violations",
           x=2.3, y=480, color="black", size=3, family="Georgia")+
  theme_meg()+
  theme(axis.line.x=element_blank(), axis.title.x=element_blank(),
        legend.title = element_blank(), axis.text.x=element_text(size=10), legend.position = c(0.1,.8))

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
  annotate("text", label="Outliers:\nNY9-2650 violations\nWA5-1029 violations",
           x=2.3, y=600, color="black", size=3, family="Georgia")+
  annotate("text", label="MI7-865 violations",
           x=2.3, y=525, color="#e56d13", size=3, family="Georgia", fontface="bold")+
  annotate("text", label="AK-841 violations\nIA2-826 violations",
           x=2.3, y=470, color="black", size=3, family="Georgia")+
  theme_meg()+
  theme(axis.line.x=element_blank(), axis.title.x=element_blank(),
        legend.title = element_blank(), axis.text.x=element_text(size=10), legend.position = c(0.1,.8))

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
  annotate("text", label="Outliers:\nNY9-2650 violations\nWA5-1029 violations\nMI7-865 violations",
           x=2.3, y=600, color="black", size=3, family="Georgia")+
  annotate("text", label="AK-841 violations",
           x=2.3, y=505, color="#e56d13", size=3, family="Georgia", fontface="bold")+
  annotate("text", label="IA2-826 violations",
           x=2.3, y=467, color="black", size=3, family="Georgia")+
  theme_meg()+
  theme(axis.line.x=element_blank(), axis.title.x=element_blank(),
        legend.title = element_blank(), axis.text.x=element_text(size=10), legend.position = c(0.1,.8))

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
  annotate("text", label="Outliers:\nNY9-2650 violations\nWA5-1029 violations\nMI7-865 violations\nAK-841 violations",
           x=2.3, y=600, color="black", size=3, family="Georgia")+
  annotate("text", label="IA2-826 violations",
           x=2.3, y=485, color="#e56d13", size=3, family="Georgia", fontface="bold")+
  theme_meg()+
  theme(axis.line.x=element_blank(), axis.title.x=element_blank(),
        legend.title = element_blank(), axis.text.x=element_text(size=10), legend.position = c(0.1,.8))

ggsave("dotplot_IA2.png", dotplot, path=here("outlierdotplots"), scale = 2, width=8, height=5, units=c("cm"))




