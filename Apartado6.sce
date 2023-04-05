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


/* utilizando parte del código del ejercicio 4 */
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


