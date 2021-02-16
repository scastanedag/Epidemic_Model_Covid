# Modelaje_Covid

Sergio Andrés Castañeda. CIMBIUR

Este código permite correr el modelo propuesto por la WHO para el cálculo del rt a partir de EpiEstim utilizando el número de casos reportados en fechas específicas según el paquete R “EpiEstim” (Cori et al., 2019, 2013; R Core Team, 2019). Se construye de acuerdo a la guía encontrada en https://cran.r-project.org/web/packages/EpiEstim/vignettes/demo.html.

Produce a partir de funciones los siguientes resultados: (tomado y traducido de: https://harvardanalytics.shinyapps.io/covid19/)

- Curvas epidémicas (número de incidentes) en función del tiempo t

- Estimado R (Número reproductivo) en función del tiempo t con intervalos de confianza del 95%. Esto se calcula utilizando ventanas semanales deslizantes, con un intervalo de serie paramétrico basado en una media de μsi = 4.8 y desviación estándar σsi = 2,3.

El Estimador COVID-19 está disponible para todos los países. Es parte de los esfuerzos de la Organización Panamericana de la Salud (OPS) y la Organización Mundial de la Salud (OMS) para ayudar a los países a monitorear con éxito las tasas de transmisión y prescribir políticas públicas que aborden la epidemia de COVID-19. (tomado y traducido de: https://harvardanalytics.shinyapps.io/covid19/)

Los scripts aquí descritos permite generar gráficos dinámicos y fijos relacionados con el comportamiento de los casos en función del tiempo.

Adicionalmente, permite generar gráficos comparativos en los cuales se muestra el comportamiento de un valor (línea) y su relación con los respectivos intervalos de confianza que se ven en la sombra de la gráfica. En este caso se utiliza para comparar los resultados de dos modelos para el cáculo del rt. 

Complementariamente presenta un código que permite el preprocesamiento y alistamiento de los datos con el fin de que se encuentren óptimos para ingresar al modelo.

Referencias:

Cori, A., Ferguson, N.M., Fraser, C., Cauchemez, S., 2019. Package ‘EpiEstim.’ https://doi.org/10.1093/aje/kwt133

Cori, A., Ferguson, N.M., Fraser, C., Cauchemez, S., 2013. A New Framework and Software to Estimate Time-Varying Reproduction Numbers During Epidemics. Am. J. Epidemiol. 178, 1505–1512. https://doi.org/10.1093/aje/kwt133

R Core Team, 2019. R: A language and environment for statistical computing. R Foundation for Statistical Computing,.
