
install.packages("EpiEstim")
library(EpiEstim)
library(incidence)
library(dplyr)
library(dygraphs)
library(xts)          # To make the convertion data-frame / xts format
library(tidyverse)
library(lubridate)
library(cowplot)
library(hrbrthemes)
library(ggplot2)

data <- read_csv("Raw_ Vichada .csv", col_names = TRUE)
data$dates <- format(as.Date(data$dates, "%d/%m/%Y"))
data$dates <- as.Date(data$dates)

modelo_who <- function(dataframe,departamento)  {
    departamento = departamento
    plot(as.incidence(data$I, dates = data$dates))

    ggsave(filename = paste("C:/Users/prestamour/Desktop/MODELO/incidencia_plot/Incidencia_", departamento, "_modelo_who.pdf"), 
           dpi = 300,  width = 14, height = 10)

    res_parametric_si <- estimate_R(data$I, metho="parametric_si", 
                                config = make_config(list(
                                  mean_si = 4.8, 
                                  std_si = 2.3)))



   resultados_modelo <- res_parametric_si$R
   resultados_modelo$`Std(R)` <- as.numeric(resultados_modelo$`Std(R)`)
   resultados_modelo$`Mean(R)` <- as.numeric(resultados_modelo$`Mean(R)`)

   confianza <- 1.96

   resultados_modelo$inferior <-  resultados_modelo$`Mean(R)` - (resultados_modelo$`Std(R)` * confianza)

   resultados_modelo$superior <-  resultados_modelo$`Mean(R)` + (resultados_modelo$`Std(R)` * confianza)


   write.csv(resultados_modelo, 
          file = paste("C:/Users/prestamour/Desktop/MODELO/estadisticas_modelo/Resumen_", departamento, "_modelo_who.csv"), 
          append = FALSE, quote = TRUE, sep = ",", 
          na = "NA", dec = ".", row.names = FALSE, 
          col.names = TRUE)


   p1 <- plot(res_parametric_si, legend = TRUE, "R")
   p2 <- plot(res_parametric_si, legend = TRUE, "incid")
   
   plot_grid(p1,p2,ncol  = 1) 
   
   ggsave(filename = paste("C:/Users/prestamour/Desktop/MODELO/resumen_plot/Resumen_plot_", departamento, "_modelo_who.pdf"), 
          dpi = 300,  width = 14, height = 10)

}


modelo_who(data, departamento = "Vichada")
