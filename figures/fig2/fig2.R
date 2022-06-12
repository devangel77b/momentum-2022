# load some libraries
library(tidyverse);
library(ggplot2); 

# load the raw data
raw <= read.csv('energy.csv',header=TRUE,sep=',');
data = raw %>%
  select(Data.Set.7.Time.s.,Data.Set.7.Position.1.m.,Data.Set.7.Position.2.m.) %>%
  rename(t=Data.Set.7.Time.s.,x1=Data.Set.7.Position.1.m.,x2=Data.Set.7.Position.2.m.)  %>%
  pivot_longer(c(x1,x2))

fig1 = ggplot(data,aes(x=t,y=value,color=name))+geom_line() + 
  scale_color_manual(values=c("blue","red"))+
  xlab('time, s') + 
  ylab('position, m') + 
  ylim(0,1) +
  theme_bw() + 
  theme(text=element_text(size=8),legend.position="none")+
  geom_hline(yintercept=0,col="gray80") +
  geom_vline(xintercept=2.1,col="orange")+
  annotate("text",x=0.5,y=0.8,label="mass 2",size=3)+
  annotate("text",x=0.5,y=0.3,label="mass 1",size=3)
  
ggsave("elastic.pdf",fig1,width=3,height=2,units="in")