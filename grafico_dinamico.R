
#Este código permite consturir gráficas dinámicas para ver el comportamiento de casos de Covid19.

#Realizado por Sergio Castañeda


#se instalan y cargan los paquetes necesarios. Universidad del Rosario. Centro de Investigaciones en Microbiología y Biotecnología UR. CIMBIUR

install.packages("dplyr")

# Library
library(dplyr)
library(dygraphs)
library(xts)          # To make the convertion data-frame / xts format
library(tidyverse)
library(lubridate)
library(cowplot)

# Definir csv de origen

datanotificacion <- read.table("/Users/sergio.castaneda/Desktop/UNIVERSIDAD_DEL_ROSARIO/PROYECTOS/DINAMICA_SARS_COV/raw_data/rawdata_notificacion/rawdata-co-all.csv", 
                               header=T, sep=",") %>% head(300)
#datanotificacion <- na.omit(datanotificacion)

# Funcion que permite crear un grafico dinamico de serie de tiempo 
graficadora_zoom_notificacion <- function(el_dataframe)  {
  
  # Para omitir casillas vacias
  na.omit(el_dataframe)
  # Check type of variable
  # str(data)
  # Since my time is currently a factor, I have to convert it to a date-time format!
  el_dataframe$date <- ymd(el_dataframe$date)
  # Crear el elemento xts necesario para usar dygraph 
  don <- xts(x = el_dataframe$new_cases, order.by = el_dataframe$date)
  # Generar el plot
  p <- dygraph(don) %>%
  dyOptions(labelsUTC = TRUE, fillGraph=TRUE, fillAlpha=0.1, drawGrid = FALSE, colors="red") %>%
  dyRangeSelector() %>%
  dyCrosshair(direction = "vertical") %>%
  dyHighlight(highlightCircleSize = 5, highlightSeriesBackgroundAlpha = 0.2, hideOnMouseOut = FALSE)  %>%
  dyRoller(rollPeriod = 1)

  p
  
}

#ejemplo de ejecución de la función
graficadora_zoom_notificacion(datanotificacion)

# save the widget
#library(htmlwidgets)
#saveWidget(p, file=paste0(getwd(), "/HtmlWidget/dygraphs318.html"))
