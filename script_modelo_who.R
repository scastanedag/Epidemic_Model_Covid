#Este código permite correr el modelo propuesto por la WHO para el cálculo del rt a partir de EpiEstim
#utilizando el número de casos reportados en fechas específicas según el paquete R “EpiEstim” (Cori et al., 2019, 2013; R Core Team, 2019).
#se realiza de acuerdo a la guía encontrada en https://cran.r-project.org/web/packages/EpiEstim/vignettes/demo.html


#Realizado por Sergio Castañeda



#se instalan y cargan los paquetes necesarios
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


#se carga el data set a procesar

data <- read_csv("Raw_ Vichada .csv", col_names = TRUE)
data$dates <- format(as.Date(data$dates, "%d/%m/%Y"))  #importante para hacer coincidir el formato fecha a día-mes-año
data$dates <- as.Date(data$dates) #importante para hacer coincidir el formato fecha a día-mes-año


#se genera una función que corre el modelo y genera los csv y plots correspondientes

modelo_who <- function(dataframe,departamento)  {    #a la función se debe ingresar los argumentos dataframe y departamento (un string "")
    departamento = departamento #para que el departamento ingresado como string sea tratado en adelante con el nombre
    plot(as.incidence(data$I, dates = data$dates))  #plot de incidencia 

    ggsave(filename = paste("C:/Users/prestamour/Desktop/MODELO/incidencia_plot/Incidencia_", departamento, "_modelo_who.pdf"), 
           dpi = 300,  width = 14, height = 10)   #para guardar el primer plot

    #Estimado R (Número reproductivo) en función del tiempo t con intervalos de confianza del 95%. 
    #Esto se calcula utilizando ventanas semanales deslizantes, con un intervalo de serie paramétrico 
    #basado en una media de μsi= 4.8 y desviación estándar σsi = 2,3
    
    res_parametric_si <- estimate_R(data$I, metho="parametric_si",    
                                config = make_config(list(
                                  mean_si = 4.8, 
                                  std_si = 2.3)))

   #se guarda el output de los estadísticos en una variable

   resultados_modelo <- res_parametric_si$R
   resultados_modelo$`Std(R)` <- as.numeric(resultados_modelo$`Std(R)`) #se guardan como variables numéricas
   resultados_modelo$`Mean(R)` <- as.numeric(resultados_modelo$`Mean(R)`) #se guardan como variables numéricas

   confianza <- 1.96  #se asigna el valor correspondiente al 95% de confianza

   #se genera el límite superior e inferior del IC95% con base en la media y el error estándar
   resultados_modelo$inferior <-  resultados_modelo$`Mean(R)` - (resultados_modelo$`Std(R)` * confianza)
   resultados_modelo$superior <-  resultados_modelo$`Mean(R)` + (resultados_modelo$`Std(R)` * confianza)

   #se guarda un archivo csv que contiene los estadísticos del modelo
   write.csv(resultados_modelo, 
          file = paste("C:/Users/prestamour/Desktop/MODELO/estadisticas_modelo/Resumen_", departamento, "_modelo_who.csv"), 
          append = FALSE, quote = TRUE, sep = ",", 
          na = "NA", dec = ".", row.names = FALSE, 
          col.names = TRUE)
   # se genera el plot de Rt y de incidencia 
   p1 <- plot(res_parametric_si, legend = TRUE, "R")
   p2 <- plot(res_parametric_si, legend = TRUE, "incid")
   
   #se unen los plot
   plot_grid(p1,p2,ncol  = 1) 
   
   #se guarda el plot
   ggsave(filename = paste("C:/Users/prestamour/Desktop/MODELO/resumen_plot/Resumen_plot_", departamento, "_modelo_who.pdf"), 
          dpi = 300,  width = 14, height = 10)

}

#ejemplo de ejecución de la función modelo_who()
modelo_who(data, departamento = "Vichada")
