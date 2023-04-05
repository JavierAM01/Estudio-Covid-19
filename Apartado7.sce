clear,

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

