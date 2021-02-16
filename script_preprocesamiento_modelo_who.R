
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

raw_data <- read_csv("rawdata-co-HU.csv", col_types = 
                      cols(date = col_date(format = "%Y-%m-%d")), 
                     col_names = TRUE)

preprocesamiento_who <- function(dataframe,departamento)  {
      departamento = departamento
      raw_data$date <- gsub("-", "/", raw_data$date) 

      raw_data <- rename(raw_data, dates = date, I = new_cases)

      raw_data <- select(raw_data, dates, I)

      raw_data$dates <- format(as.Date(raw_data$dates, "%Y/%m/%d"), "%d/%m/%Y")

      raw_data$I <- as.numeric(raw_data$I)

      raw_data <- na.omit(raw_data)

      write.csv(raw_data, file = paste("C:/Users/prestamour/Desktop/MODELO/raw_data_who/Raw_", departamento, ".csv"),
            append = FALSE, quote = TRUE, sep = ",", 
            na = "NA", dec = ".", row.names = FALSE, 
            col.names = TRUE)

}

preprocesamiento_who(raw_data, departamento = "Huila")
