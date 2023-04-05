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
