#Este código permite el preprocesamiento de la raw data descargada con el fin de correr el modelo propuesto 
#por la WHO para el cálculo del rt a partir de EpiEstim utilizando el número de casos reportados en fechas específicas 
#según el paquete R “EpiEstim” (Cori et al., 2019, 2013; R Core Team, 2019).

#Realizado por Sergio Castañeda. Universidad del Rosario

#se instalan y cargan los paquetes necesarios


install.packages("pandas")
library(stringr)
library(data.table)
library(dplyr)
library(tidyverse)
library(dygraphs)
library(xts)          # To make the convertion data-frame / xts format
library(lubridate)
library(cowplot)
library(hrbrthemes)
library(ggplot2)
library(readr)
library(pandas)


#se deben cargar los datos a preprocesar. Es importante señalar el col_types para indicarle el formato de la fecha en el que está
raw_data <- read_csv("rawdata-co-HU.csv", col_types = 
                      cols(date = col_date(format = "%Y-%m-%d")), 
                     col_names = TRUE)

#se genera una función que realiza el preprocesamiento de los datos
preprocesamiento_who <- function(dataframe,departamento)  {  #se ingresa el dataframe y el departamento ""
      departamento = departamento
      raw_data$date <- gsub("-", "/", raw_data$date) #se cambian los - por /

      raw_data <- rename(raw_data, dates = date, I = new_cases) #se utiliza rename para cambiar el nombre de las variables

      raw_data <- select(raw_data, dates, I) #utilizando select de dpylr se seleccionan solo las columnas a utilizar

      raw_data$dates <- format(as.Date(raw_data$dates, "%Y/%m/%d"), "%d/%m/%Y") #se cambia el formato de la fecha a d/m/a

      raw_data$I <- as.numeric(raw_data$I) #nos aseguramos de que la variable I (invidencia) se de tipo numérica

      raw_data <- na.omit(raw_data) #eliminamos las filas con NA

      #guardamos el archivo procesado indicándole como separador "," y como separador decimal el "."
      write.csv(raw_data, file = paste("C:/Users/prestamour/Desktop/MODELO/raw_data_who/Raw_", departamento, ".csv"),
            append = FALSE, quote = TRUE, sep = ",", 
            na = "NA", dec = ".", row.names = FALSE, 
            col.names = TRUE)

}

#ejecución de la función
preprocesamiento_who(raw_data, departamento = "Huila")
