
#Este código permite contruir gráficas para su respectiva comparación.
#En este caso se utiliza para comprar el comportamiento de casos notificados vs casos por incio de sínntomas.


#Realizado por Sergio Castañeda. Universidad del Rosario. Centro de Investigaciones en Microbiología y Biotecnología UR. CIMBIUR

# Se cargan las librerías necesarias
library(dplyr)
library(dygraphs)
library(xts)          # To make the convertion data-frame / xts format
library(tidyverse)
library(lubridate)
library(cowplot)
library(hrbrthemes)
library(ggplot2)

#extrafont :: font_import () #Se utiliza para lograr que no exista problema en relación con las fuentes de la letra al crear el PDF
#extrafont :: loadfonts () #Se utiliza para lograr que no exista problema en relación con las fuentes de la letra al crear el PDF

#cargar los archivos que serán usados

notificacion <- read.table("/Users/sergio.castaneda/Desktop/UNIVERSIDAD_DEL_ROSARIO/PROYECTOS/DINAMICA_SARS_COV/raw_data/rawdata_notificacion/rawdata-co-all.csv", 
                           header=T, sep=",")  #dataframe1

sintomas <- read.table("/Users/sergio.castaneda/Desktop/UNIVERSIDAD_DEL_ROSARIO/PROYECTOS/DINAMICA_SARS_COV/raw_data/rawdata_iniciosintomas/rawdata-co-all.csv", 
                       header=T, sep=",")    #dataframe2


# crear una función que grafique ambas condiciones. 

graficadora <- function(dataframe1, dataframe2, departamento)  {  #los argumentos incluyen datasets y nombre del depto en ""
  
  departamento = departamento  #para poder escribir el departamento y que cambien el título de la gráfica 
  notificacion$date <- ymd(notificacion$date)  #para generar que la columna date sea interpretada como una fecha en formato año-mes-día
  
  p1 <- ggplot(notificacion, aes(x=date, y=new_cases)) +      #gráfica 1
    geom_line( color="blue") + 
    xlab("") +
    theme_ipsum() +
    theme(axis.text.x=element_text(angle=60, hjust=1)) +
    scale_x_date(limit=c(as.Date("2020-04-01"),as.Date("2020-12-31"))) +
    labs(title= paste("Cases in ", departamento, " by Notification date between April 2020 and December 2020"), x="New Cases", y="Date")

  sintomas$date <- ymd(sintomas$date)   #para generar que la columna date sea interpretada como una fecha en formato año-mes-día
  p2 <- ggplot(sintomas, aes(x=date, y=new_cases)) +  #gráfica 2
    geom_line( color="red") + 
    xlab("") +
    theme_ipsum() +
    theme(axis.text.x=element_text(angle=60, hjust=1)) +
    scale_x_date(limit=c(as.Date("2020-04-01"),as.Date("2020-12-31"))) +
    labs(title= paste("Cases in ", departamento,  " by Symptom onset date between April 2020 and December 2020"), x="New Cases", y="Date")

  plot_grid(p1,p2,ncol  = 1)  #función del paquete cowplot que me sirve para unir las dos gráficas anteriores en una sola en una sóla columna
 
  ggsave(filename = paste("Cases in ", departamento, ".pdf"), dpi = 300,  width = 14, height = 10)
          #Con los siguientes parametros podemos controlar
          # el ancho (width) y el alto (height) de la figura
          # la unidades estan en pulgadas por default
          # Como esta es una tira, la hacemos mas ancha que alta
     
       
}


#ejemplo de la ejecución de la función
graficadora(notificacion, sintomas, departamento = "Colombia")

