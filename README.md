# Modelaje_Covid


Este código permite correr el modelo propuesto por la WHO para el cálculo del rt a partir de EpiEstim utilizando el número de casos reportados en fechas específicas según el paquete R “EpiEstim” (Cori et al., 2019, 2013; R Core Team, 2019). se realiza de acuerdo a la guía encontrada en https://cran.r-project.org/web/packages/EpiEstim/vignettes/demo.html

Permite generar gráficos dinámicos y fijos relacionados con el comportamiento de los casos en el tiempo.

Adicionalmente permite generar gráficos comparativos en los cuales se muestra el comportamiento de un valor (línea) y su relación con los respectivos intervalos de confianza que se ven en la sombra de la gráfica. En este caso se utiliza para comparar los resultados de dos modelos para el cáculo del rt. 

Complementariamente presenta un código que permite el preprocesamiento y alistamiento de los datos con el fin de que se encuentren óptimos para ingresar al modelo.

