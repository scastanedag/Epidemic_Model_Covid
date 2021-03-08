library("scales")
library("dplyr")

notificacion <- read.table("/Users/sergio.castaneda/Desktop/UNIVERSIDAD_DEL_ROSARIO/PROYECTOS/DINAMICA_SARS_COV/modelo/raw_data/rawdata-co-all.csv", 
                           header=T, sep=",")  #dataframe1
notificacion <- select(notificacion, date, new_cases)
notificacion <- drop_na(notificacion)

# Grouped
ggplot(notificacion, aes(x=date, y=new_cases)) + 
  geom_bar(position ="dodge", stat="identity", color = "darkblue", fill = "deepskyblue4") +
  theme_cowplot() +
  theme(
    axis.text.x = element_text( angle = 90, size =5)
  ) +
  #labels()
  #ggtitle( "Cases" ) + #cambiar titulo
  xlab( "Date" ) + #cambiar nombre eje X
  ylab( "Number of Cases per Day" ) #cambiar nombre eje Y


ggsave(filename = paste("plot.pdf",  dpi = 300,  width = 14, height = 10))   #para guardar el primer plot
