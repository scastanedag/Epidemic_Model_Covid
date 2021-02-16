#Este código permite generar gráficos comparativos en los cuales se muestra el comportamiento de un valor (línea) y su relación
#con los respectivos intervalos de confianza que se ven en la sombra de la gráfica. En este caso se utiliza para comparar
#los resultados de dos modelos para el cáculo del rt. 

#Realizado por Sergio Castañeda


#se cargan las librerías necesarias
library(tidyverse)
library(cowplot)
library(ggplot2)

#se cargan los dos dataset a comparar
data1 <- read_csv("/Users/sergio.castaneda/Desktop/UNIVERSIDAD_DEL_ROSARIO/PROYECTOS/DINAMICA_SARS_COV/modelo_who/estadisticas_modelo/Resumen_\ Bogota\ _modelo_who.csv", 
                  col_names = TRUE)
data1$t_start <- as.numeric(data1$t_start) # es importante usar as.numeric si es necesario para transformar el formato de la variable

data2 <- read_csv("/Users/sergio.castaneda/Desktop/UNIVERSIDAD_DEL_ROSARIO/PROYECTOS/DINAMICA_SARS_COV/modelo/csv-co_notificacion/COVID19-BO-rt.csv", 
                    col_names = TRUE)

#se crea la función comparación_modelos() 
comparacion_modelos <- function(data1, data2, departamento) {   #se debe ingresar dos dataset previamente cargados 
                                                                # y en el argumento departamento un string entre ""

  plot1 <- ggplot(data1, aes(x = t_start, y = `Mean(R)`)) +    #se genera el plot1. verificar nombres de los ejes
    geom_line(color = "cadetblue", size = 1) +                # color y grosor línea principal
    geom_ribbon(aes(ymin=inferior, ymax=superior),             # generar la sombra correspondiente al IC
                alpha=0.1,       #transparency
                linetype="blank",      #solid, dashed or other line types
                colour="grey70", #border line color
                size=1,          #border line size
                fill="cyan2") +   #fill color
    ggtitle(label = "WHO Model") +  #título
    theme_cowplot()  #para limpiar la imagen


  plot2 <- ggplot(data2, aes(x = X1, y = rt)) +     #plot2. verificar nombres de los ejes
    geom_line(color = "cadetblue", size = 1) +
    geom_ribbon(aes(ymin=`rt2.5%`, ymax=`rt97.5%`), 
              alpha=0.1,       #transparency
              linetype="blank",      #solid, dashed or other line types
              colour="grey70", #border line color
              size=1,          #border line size
              fill="cyan2") +
   ggtitle(label = "Enzo Model") +
    theme_cowplot()


  plot_grid(plot1, plot2, nrow = 1)  #unir gráficos

}


#ejemplo de ejecución de la función
comparacion_modelos(data1, data2, departamento = "Bogota")

