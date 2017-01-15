library("ggplot2")
library("ropenaq")
library("dplyr")
library("emojifont")
library("gganimate")
library("ggthemes")
list.emojifonts()

load.emojifont('OpenSansEmoji.ttf')

lala <- aq_measurements(country = "PE", limit = 1000)
lala <- filter(lala, location == "US Diplomatic Post: Lima")
lala <- mutate(lala, label = emoji("surfer"))
Sys.setlocale("LC_ALL","English")
p <- ggplot(lala)+ 
  geom_area(aes(x = dateLocal, 
                 y = value),
             size = 2, fill = "navyblue")+
  geom_text(aes(x = dateLocal, 
                y = value+1,
                label = label,
                frame = dateLocal,
                cumulative = FALSE),
            family="OpenSansEmoji", size=8)+
  ylab(expression(paste("PM2.5 concentration (", mu, "g/",m^3,")")))+ 
  xlab('Local date and time, Lima, Peru')+
  ylim(0, 50)+
  theme_hc(bgcolor = "darkunica") +  
  scale_colour_hc("darkunica")+
  theme(text = element_text(size=20)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  theme(plot.title=element_text(family="OpenSansEmoji",
                                face="bold"))+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())
library("animation")
ani.options(interval = 0.25, ani.width = 800, ani.height = 400)
gg_animate(p, "figs/surf.gif")
