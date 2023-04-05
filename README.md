# Estudio-Covid-19

Se trata de un pequeño estudio del Covid-19. Para ello iremos respondiendo a una serie de preguntas. En este trabajo se practicarán 
dos lenguajes de programación: scilab y máxima.


## Índice 

 - [Comentarios](#id0)
 - [Apartados con Máxima](#id1)
    - [Pregunta 1](#id1.1)
    - [Pregunta 2](#id1.2)
    - [Pregunta 3](#id1.3)
 - [Apartados con Scilab](#id2)
    - [Pregunta 4](#id2.4)
    - [Pregunta 5](#id2.5)
    - [Pregunta 6](#id2.6)
    - [Pregunta 7](#id2.7)
    
 
 ## Comentarios <a name=id0> </a>

Todos los apartados de Maxima vienen en un script de Maxima con nombre: maxima.wxmx. Dentro de este script hay 3 únicas celdas claramente
diferencias donde cada una ejecuta cada uno de los apartados resueltos con Maxima, cada uno es independiente del otro, es decir vienen todas
las variables y deficiniones necesarias para ejecutarlos por separado. En el caso de los apartados con Scilab, estos vienen separados cada
uno con un script con nombre: Apartado $n$ .sce, para $n\in \{4,5,6,7\}$. También son idependientes (vienen todas las definiciones previas necesarias para ejecutar
cada script por separado).


## Apartados con Máxima <a name=id1> </a>

### Pregunta 1 <a name=id1.1> </a>

**Tenemos una función sigmoide(yo,yf,k,t) = yo*yf/(yo+(yf-yo)*exp(-k*t)), que podría representar la evolución en el tiempo del número de casos totales 
generados por una epidemia en el seno de una población (cada 100 mil habitantes). En términos epidemiológicos se habla de la Incidencia acumulada (IA), y lo 
recomendable es que venga expresada en relación al tamaño de la población. Justificar de forma cualitativa (por ejemplo generando 
varias gráficaas diferentes) o cuantitativamente lo que significan los parámetros yo, yf y k en dicha función.**

Lo primero de todo es comentar, claro está, que pese a cualquier valor que se le de a la función, esta será creciente puesto que precisamente 
se trata de incidencia acumulativa. Cualitativamente, según la observación de varias gráficas, tenemos que yo es en número de casos por 100 mil 
habitantes que hay desde el día 0, es decir, desde el comienzo del estudio. Por otro lado, yf es el número límite de casos por 100 mil habitantes, 
es decir globalmente, el estudio no supera dicha cifra. Mientras que el valor de k, hace que el número de casos por 100 mil habitantes crezca más o 
menos rápido durante las primeras semanas según qué valores tome k. 

```maxima
sigmoide(yo,yf,k,t):=yo*yf/(yo+(yf-yo)*exp(-k*t))$
incidencia_acumulada(t) :=sigmoide(1,800,0.2,t)$ 

disp("hacemos crecer el valor de yo")$
incidencia_acumulada1(t) :=sigmoide(1,200,0.1,t)$ 
incidencia_acumulada2(t) :=sigmoide(20,200,0.1,t)$
incidencia_acumulada3(t) :=sigmoide(150,200,0.1,t)$ 
wxplot2d([incidencia_acumulada1, incidencia_acumulada2, incidencia_acumulada3], 
        [t,0,90],[xlabel,"t (días)"], [color, blue, red, black], [legend, "1", "20", "150"],
        [ylabel,"Casos por 100 mil habitantes"],[title,"Incidencia acumulada"])$

disp("hacemos crecer el valor de yf")$
incidencia_acumulada1(t) :=sigmoide(1,200,0.1,t)$ 
incidencia_acumulada2(t) :=sigmoide(1,400,0.1,t)$ 
incidencia_acumulada3(t) :=sigmoide(1,1000,0.1,t)$ 
wxplot2d([incidencia_acumulada1, incidencia_acumulada2, incidencia_acumulada3], 
        [t,0,90],[xlabel,"t (días)"], [color, blue, red, black], [legend, "200", "400", "1000"],
        [ylabel,"Casos por 100 mil habitantes"],[title,"Incidencia acumulada"])$

disp("hacemos crecer el valor de k")$
incidencia_acumulada1(t) :=sigmoide(1,500,0.1,t)$ 
incidencia_acumulada2(t) :=sigmoide(1,500,0.3,t)$ 
incidencia_acumulada3(t) :=sigmoide(1,500,1,t)$ 
wxplot2d([incidencia_acumulada1, incidencia_acumulada2, incidencia_acumulada3], 
        [t,0,90],[xlabel,"t (días)"], [color, blue, red, black], [legend, "0.1", "0.3", "1"],
        [ylabel,"Casos por 100 mil habitantes"],[title,"Incidencia acumulada"])$
```

<div style="text-align:center;">
  <image src="/images/2.1.png" style="width:33%;">
  <image src="/images/2.1_2.png" style="width:33%;">
  <image src="/images/2.1_3.png" style="width:33%;">
</div>

### Pregunta 2 <a name=id1.2> </a>

**Durante una epidemia, por ejemplo la de Covid-19, las autoridades sanitarias suelen monitorizar también el número de casos diarios, e informan 
de la Incidencia diaria (ID). Esta variable es muy importante, pues un aumento de la incidencia diaria podría producir un aumento en las hospitalizaciones, 
que tendrían como consecuencia una saturación del sistema sanitario. Amplíe el código anterior para generar la gráfica de la incidencia diaria; 
puede hacerlo de forma continua o de forma discreta. Calcule también el pico (máximo) de la incidencia diaria, el día que se presentó, y márquelo 
en la gráfica.**


Antes de nada y a nivel cualitativo, podemos observar en la función de la incidencia acumulada, que entre los días 30 y 40 hay un gran crecimiento, 
el cual nos lleva a pensar en un posible máximo (a nivel diario) en ese intervalo.

```maxima
sigmoide(yo,yf,k,t):=yo*yf/(yo+(yf-yo)*exp(-k*t))$
incidencia_acumulada(t) :=sigmoide(1,800,0.2,t)$
 
wxplot2d([incidencia_acumulada], [t,0,90],[xlabel,"t (días)"],
        [ylabel,"Casos por 100 mil habitantes"],[title,"Incidencia acumulada"])$
```

<div style="text-align:center;">
  <image src="/images/2.2.png" style="width:50%;">
</div>

Teniendo en cuenta que la incidencia diaria es la derivada de la incidencia acumulada, calculamos su función continua así como su máximo, es decir,

```maxima
d_inc_ac(t) := diff(incidencia_acumulada(t), t)$
dd_inc_ac(t) := diff(d_inc_ac(t), t)$

xmaximo : rhs(solve( dd_inc_ac(t) = 0, t )[1])$
ymaximo : at(d_inc_ac(t), t=xmaximo)$

wxplot2d([d_inc_ac(t), [discrete, [xmaximo], [ymaximo]]], [t, 0, 90],
        [y, 0, 45], [xlabel,"t (días)"], [ylabel,"Casos por 100 mil habitantes"], 
        [legend, "Incidencia diaria", "Máximo"],
        [title,"Incidencia diaria"], [style, lines, points], [color, black, blue]);
disp(concat("Máximo en (", string(floor(float(xmaximo))), ",", string(floor(float(ymaximo))), ")"))$
```

<div style="text-align:center;">
  <image src="/images/2.2_3.png" style="width:50%;">
</div>

el día que más infectados por habitantes hubo fue el día 33 del estudio.

### Pregunta 3 <a name=id1.3> </a>

**Otra variable importante para las autoridades sanitarias es la incidencia acumulada durante una ventana temporal concreta. En el caso de la Covid-19, 
esta variabble se ha utilizado para establecer niveles de alerta, e indirectamente para el control de la eppidemia. Amplíe el código facilitado para 
generar la gráfica de la Incidencia acumulada a 14 días (IA14); puede hacerlo de forma continua o discreta, teniendo en cuenta que: $IA14(t) = IA(t) – IA(t-14)$.**


Teniendo en cuenta que la incidencia acumulada a 14 días es $IA14(t) = IA(t) - IA(t-14)$ , entonces su gráfica de forma continua es 

```maxima
sigmoide(yo,yf,k,t):=yo*yf/(yo+(yf-yo)*exp(-k*t))$
incidencia_acumulada(t) :=sigmoide(1,800,0.2,t)$
d_inc_ac(t) := diff(incidencia_acumulada(t), t)$

IAr(t) :=  at(incidencia_acumulada(t), t = t-14)$
IA14(t) := incidencia_acumulada(t) - IAr(t)$

wxplot2d([IA14(t), d_inc_ac(t), incidencia_acumulada(t)], [t, 0, 90], [color, red, blue, black], 
    [legend, "IA14", "diaria", "acumulada total"], [xlabel,"t (días)"], [ylabel,"Casos por 100 mil habitantes"]);
```

<div style="text-align:center;">
  <image src="/images/2.3.png" style="width:50%;">
</div>

la de color rojo. En este caso hemos decidido representar las tres funciones continuas en una misma gráfica para poder comentarlas un poco 
de manera cualitativa. Como se puede observar la de la incidencia diaria esta claro que es la más baja pues las otras vienen determinadas 
por la suma de 1 o más días. Por otro lado las primeras semanas se observa cierta similitud entre la incidencia acumulada y la acumulada a 
14 días pues por el momento nos informan prácticamente de lo mismo. En el intervalo de 30 a 50 días, se observa que la IA14 está en sus puntos 
más altos pues durante esas semanas (solo acumula las dos anteriores) la incidencia diaria fue muy alta. Finalmente como es de esperar, desde el
día 50 aproximadamente podemos observar en la acumulada total que ya está llegando a los casos máximos y por tanto no hay muchos más casos nuevos
diarios y la IA14 comienza a descender, un poco más tarde que la diaria, pues todovía recogemos las pasadas dos semanas que sí hubo un gran 
aumento de casos. 



## Apartados resueltos con Scilab <a name="id2"> </a>

### Pregunta 4 <a name="id2.4"> </a>

**La evolución de la epidemia de Covid-19 en España se puede consultar en el PANEL COVID19 (https://cnecovid.isciii.es/covid19/), soportado por el
Centro Nacional de Epidemiología, dependiente del Instituto de Salud Carlos III. De este panel se ha descargado un archivo de datos, que le hemos
facilitado con el nombre *datos_ccaas_31enero_23octubre.csv*, que contiene los datos notificados por las Comunidades Autónomas (CCAA) a la Red Nacional
de Vigilancia Epidemiológica (RENAVE), con fechas comprendidas entre el 31 de enero y el 23 de octubre de 2020 (ambos días incluidos)**

<div style="text-align:center;">
  <image src="/images/tabla.png" style="width:50%;">
</div>

**El campo ccaa_iso representa el código ISO de la Comunidad Autónoma. El campo fecha representa el día al que está asociado el correspondiente dato. 
El campo num_casos representa el total de casos notificados por la Comunidad Autónoma en ese día (Incidencia diaria). El resto de campos representan 
el desglose de los casos según la prueba diagnóstica utilizada: PCR o técnicas moleculares, test rápido de anticuerpos, otras pruebas de laboratorio, 
sin información de la prueba.**

**Como complemento a estos datos se le ha facilitado otro archivo, con el nombre *poblaciones_ccaas_2019.csv*, que contiene información sobre los 
códigos ISO de las 19 Comunidades autónomas españolas (incluidas las dos ciudades autónomas). Y las poblaciones respectivas (en millones de 
habitantes) según el Instituto Nacional Estadística a 1 de enero del 2019. La información está dispuesta en forma de tabla, utilizando la coma
como separador entre campos, y el punto como separador de parte entera y parte decimal. A continuación se muestran, a título informativo, las
seis primeras filas de este archivo.**

**Proponga un código capaz de leer la información completa, o la información estrictamente necesaria, de ambos archivos y capaz de 
colocar los casos diarios registrados (Incidencia diaria) por 100000 habitantes en toda España en una estructura matricial numérica, de 2 columnas
y tantas filas como sean necesarias. Cada fila de la matriiz recogerá en su primera columna el día, en términos relativos al día 31 de enero de 2020
(considerado el día 0) y en la segunda columna el dato correspondiente a ese día.**

Primero tenemos que tener en cuenta que la suma final de todos estos casos vienen dados por los habitantes de España y nos piden que lo 
pongamos por 100 mil habitantes, así que al final de obtener la suma de los casos diarios, haremos una simple regla de tres para hallarla 
por cada 100 mil habitantes. Para hallar la suma haremos un bucle recorriendo todos los días (que son el número de filas de mdatos entre el 
número de provincias) y sumando los casos de cada comunidad en ese día, teniendo en cuenta que son 19 comunidades (aunque en el código lo 
ponemos de forma genérica como el número de filas de las mpoblaciones menos 1, puesto que la primera fila contiene los títulos de las columnas, xp - 1). 
Para recorrer cada día asignaremos a una variable bloque un valor, este será: 1 (primera fila de títulos) más el número de filas de todos los días 
anteriores, que es el número de días que han pasando (dia - 1 ) por el número de provincias (xp - 1). Así la suma de los casos de cada día será la 
suma de todos los valores de un vector columna que recorre la columna 3 de mdatos donde están el número de casos, desde la posición: bloque + 1 (pasadas 
todas las filas de los días anteriores), hasta la posición: bloque + (xp - 1) (la última comunidad de ese día). A todo esto hay que pasar los valores a 
decimales (con la función strtod) pues tenemos los valores de las matrices mdatos y mpoblaciones como cadenas al haber leído los csv con read\_csv.  El 
resultado lo guardaremos (después de la previa regla de tres ya comentada) en la matriz "tabla\_datos". Finalmente representamos los datos.

```scilab
clear,
mdatos = read_csv('datos_ccaas_31enero_23octubre.csv')
mpoblaciones = read_csv('poblaciones_ccaas_2019.csv')

[xd, yd] = size(mdatos);
[xp, yp] = size(mpoblaciones);
habitantes = sum(strtod(mpoblaciones(2:20,3)));
total_dias = (xd-1)/(xp-1);

for dia = 1 : total_dias
    bloque = 1 + (dia-1)*(xp-1);
    ncasos = sum(strtod(mdatos(bloque+1:bloque+xp-1, 3)))
    tabla_datos(dia, 1) =  dia - 1; 
    tabla_datos(dia, 2) = 0.1*ncasos/habitantes;
end

plot(tabla_datos(:,1), tabla_datos(:,2))
xlabel("Días relativos al 31 de enero de 2020")
ylabel("Casos por 100 mil habitantes")
title("Evolución de la epidemia de Covid-19 en España")

disp(tabla_datos)
```


### Pregunta 5 <a name="id2.5"> </a>

**Modifique o amplíe el código del apartado 4 para generar también la estructura matricial similar correspondiente a la incidencia diaria por 
100000 habitantes notificada por la Comunidad Autónoma donde reside (CAR, de ahora en adelante). Y para hacer unarepresentación gráfica comparativa
de ambas pandemias; la de España y la de su CAR.**

Yo resido en la comunidad autónoma de Madrid, cuyo iso es MD y ocupa la posición 14 en cuanto al orden de las tablas, puesto que como es de 
esperar nuestro csv sigue un orden en el estudio de los casos diarios de cada comunidad. Así retocanmos un poco el código del ejercicio 4 en el 
bucle de los días, donde actuaremos de forma análoga a como creamos la tabla tabla\_datos pero en vez de cada día sumar los casos de todas las 
comunidades solo sumaremos la de madrid es decir la posición: bloque + 14, cada día, y lo añadiremos a una matriz tabla\_madrid. Además está claro
que los casos por 100 mil habitantes en Madrid se hacen en relación a los habitantes totales de madrid que ocuapan la posición 14 + 1 en la tabla
de mpoblaciones. Por lo tanto tenemos que la comparativa entre Madrid y España es la siguiente.

```scilab
clear,
mdatos = read_csv('datos_ccaas_31enero_23octubre.csv')
mpoblaciones = read_csv('poblaciones_ccaas_2019.csv')

[xd, yd] = size(mdatos);
[xp, yp] = size(mpoblaciones);
habitantes = sum(strtod(mpoblaciones(2:20,3)));
habitantesCAR = sum(strtod(mpoblaciones(15,3)));
total_dias = (xd-1)/(xp-1);

for dia = 1 : total_dias
    bloque = 1 + (dia-1)*(xp-1);
    ncasos = sum(strtod(mdatos(bloque+1:bloque+xp-1, 3)))
    tabla_datos(dia, 1) =  dia - 1; 
    tabla_datos(dia, 2) = 0.1*ncasos/habitantes;
    tabla_madrid(dia, 1) = dia - 1;
    tabla_madrid(dia, 2) = 0.1*strtod(mdatos(bloque+14, 3))/habitantesCAR;
end

plot(tabla_datos(:,1), tabla_datos(:,2), 'k', tabla_madrid(:,1), tabla_madrid(:,2), 'b')
xlabel("Días relativos al 31 de enero de 2020")
ylabel("Casos por 100 mil habitantes")
title("Comparativa entre la evolución de la epidemia de Covid-19 en España y en Madrid")
legend("España", "Madrid")
```

<div style="text-align:center;">
  <image src="/images/2.5_2.png" style="width:100%;">
</div>

Podemos observar como la comunidad autónoma de Madrid está muy por encima de la media en España.


### Pregunta 6 <a name="id2.6"> </a>

**Proponga una función que, a partir de un vector conteniendo valores discretos de la Incidencia diaria de Covid-19 por 100000 habitantes (ID), 
es capaz de generar el vector de la Incidencia acumulada empleando una ventana temporal de $n\geq 1$ días (IAn). En el cálculo de la IAn puede optar
por emplear la IA, o directamente la ID.**

**Sin pérdida de generalidad, puede dar por hecho que todos los datos facilitados en el vector corresponden a días consecutivos y no hay ausencia 
de datos. Y también puede dar por hecho que no hubo casos en los días previos al día cero (que ocupa la posición 1 en el vector ID).**

**Incorpore, como segundo argumento de salida de la función, un vector NAn con los valores discretos de nivel de alerta utilizando la siguiente clasificación:**

<div style="text-align:center;">
  <image src="/images/nivel_alerta.png" style="width:70%;">
</div>

La función de incidencia acumulada de $n$ días quedaría de la siguiente forma. Los primeros $n$ días es directamente la suma de el día en el
que estamos y los anteriores pues no tenemos días previos suficientes para sumar $n$ de ellos (suponiendo 0 casos previos al día 1). A partir
del día $n + 1$ tenemos que sumar el día en el que estamos y los $n-1$ días previos. Una vez tenemos todos los valores discretos de la función
aplicamos las restricciones para ver en qué nivel de alerta, $\{ 0,1,2,3\}$, se encuentra cada día. La función nos devuelve dos vectores uno con
los valores acumulados y otro con los niveles de alerta.

```scilab
function [IAn, NAn] = acumulador(ID, n)
    ndias = length(ID); 
    for i = 1 : n, IAn(i) = sum(ID(1:i)); end
    for k = n+1 : ndias, IAn(k) = sum(ID(k-n+1:k)); end
    for d = 1 : ndias
        if IAn(d) <= 25 then NAn(d) = 0;
        elseif IAn(d) <= 50 then NAn(d) = 1;
        elseif IAn(d) <= 150 then NAn(d) = 2;
        elseif IAn(d) <= 250 then NAn(d) = 3;
        else NAn(d) = 4;
        end
    end
endfunction
``` 

Observamos un ejemplo de la función haciendo uso de los datos de la incidencia acumulada de los ejercicios anteriores, comparando la incidencia
diaria con la acumulada a 5 días en España, tanto en los casos como en los niveles de alerta. Utilizando plot2d2 para representar de forma escalonada
los niveles de alerta.

```scilab
mdatos = read_csv('datos_ccaas_31enero_23octubre.csv')
mpoblaciones = read_csv('poblaciones_ccaas_2019.csv')

[xd, yd] = size(mdatos);
habitantes = sum(strtod(mpoblaciones(2:20,3)));
total_dias = (xd-1)/19;

for dia = 1 : total_dias
    bloque = 1 + (dia-1)*19;
    ncasos = sum(strtod(mdatos(bloque+1:bloque+19, 3)))
    tabla_datos(dia, 1) =  dia - 1; 
    tabla_datos(dia, 2) = 0.1*ncasos/habitantes;
end

[IA1, NA1] = acumulador(tabla_datos(:,2), 1);
[IA5, NA5] = acumulador(tabla_datos(:,2), 5);
x = tabla_datos(:,1)

subplot(2,1,1)
plot(x, tabla_datos(:,2), 'k', x, IA5, 'b')
xlabel("Días relativos al 31 de enero de 2020")
ylabel("Casos por 100 mil habitantes")
title("Incidencia acumulada de 5 días")
legend("Incidenca diaria", "Incidencia acumulada")

subplot(2,1,2)
plot2d2(x, [NA1, NA5])
xlabel("Días relativos al 31 de enero de 2020")
title("Comparativa entre los niveles de alerta diarios y acumulados a 5 días en España")
```

<div style="text-align:center;">
  <image src="/images/2.6_3.png" style="width:100%;">
</div>


### Pregunta 7 <a name="id2.7"> </a>

**Amplíe el código del apartado 5 para completar la comparativa de ambas pandemias (la de España y la de su CAR) con gráficas de las 
Incidencias acumuladas a 14 días y de los correspondientes Niveles de alerta.**


Esta vez haremos una comparativa entre la incidencia acumulada a 14 días, entre España y Madrid (en mi caso). Además también compararemos
los niveles de alerta de ambos, donde estos serán representados de manera escalonada y cada uno con un color distinto para que puedan ser
fácilmente diferenciados. Con respecto al código, únicamente utilizaremos la función acumulador definida en el apartado 2.6 y las gráficas
las separaremos de forma horizontal con el comando subplot.

```scilab
function [IAn, NAn] = acumulador(ID, n)
    ndias = length(ID); 
    for i = 1 : n, IAn(i) = sum(ID(1:i)); end
    for k = n+1 : ndias, IAn(k) = sum(ID(k-n+1:k)); end
    for d = 1 : ndias
        if IAn(d) <= 25 then NAn(d) = 0;
        elseif IAn(d) <= 50 then NAn(d) = 1;
        elseif IAn(d) <= 150 then NAn(d) = 2;
        elseif IAn(d) <= 250 then NAn(d) = 3;
        else NAn(d) = 4;
        end
    end
endfunction

mdatos = read_csv('datos_ccaas_31enero_23octubre.csv')
mpoblaciones = read_csv('poblaciones_ccaas_2019.csv')

[xd, yd] = size(mdatos);
[xp, yp] = size(mpoblaciones);
habitantes = sum(strtod(mpoblaciones(2:20,3)));
habitantesCAR = sum(strtod(mpoblaciones(15,3)));
total_dias = (xd-1)/(xp-1);

for dia = 1 : total_dias
    bloque = 1 + (dia-1)*(xp-1);
    ncasos = sum(strtod(mdatos(bloque+1:bloque+xp-1, 3)))
    tabla_datos(dia, 1) =  dia - 1; 
    tabla_datos(dia, 2) = 0.1*ncasos/habitantes;
    tabla_madrid(dia, 1) = dia - 1;
    tabla_madrid(dia, 2) = 0.1*strtod(mdatos(bloque+14, 3))/habitantesCAR;
end

x = tabla_datos(:,1);
[CAR_IA14, CAR_NA14] = acumulador(tabla_madrid(:,2),14);
[ESP_IA14, ESP_NA14] = acumulador(tabla_datos(:,2),14);

subplot(2,1,1)
plot(x, ESP_IA14, 'k', x, CAR_IA14, 'b')
xlabel("Días relativos al 31 de enero de 2020")
ylabel("Casos por 100 mil habitantes")
title("Comparativa entre la evolución acumulada de la epidemia de Covid-19 en España y en Madrid")
legend("España", "Madrid")

subplot(2,1,2)
plot2d2(x, [ESP_NA14, CAR_NA14])
xlabel("Días relativos al 31 de enero de 2020")
title("Comparativa entre los niveles de alerta acumulados de España y Madrid")
legend("España", "Madrid")
```

<div style="text-align:center;">
  <image src="/images/2.7_2.png" style="width:100%;">
</div>



