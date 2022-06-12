# load some libraries
library(tidyverse);
library(ggplot2); 

# load the raw data
raw = read.csv('all.csv',header=TRUE,sep=',');
dat = raw %>%
  select(dE.J) %>%
  summarize(across(everything(), list(mean=mean,sd=sd))) %>%
  pivot_longer(cols=everything(),names_sep="_",names_to=c("variable","statistic")) %>%
  pivot_wider(names_from="statistic")
  
fig3 = ggplot(dat) + 
  geom_bar(aes(x=variable,y=mean),stat="identity",fill="orange",width=0.6)+
  geom_errorbar(aes(x=variable,ymin=mean-sd,ymax=mean+sd),width=0.4)+
  ylab('change in energy, J')+
  theme_bw()+
  theme(text=element_text(size=8))+
  theme(axis.title.x=element_blank(),axis.text.x=element_blank(),axis.ticks.x=element_blank())+
  geom_hline(yintercept=0,col="gray80") 

ggsave("energy_change.pdf",fig3,width=3,height=2,units="in")