--@Autor(es):       (Alfaro) (Alfaro Alejandro Esaú|Domínguez Rodrigo)
--@Fecha Creación:  05/01/2022
--@Descripción:     Script de pruebda de trigger encargado de validar
-- que los datos sean correctos 
set serveroutput on;

update empleado
set sueldo_mensual = sueldo_mensual * 1.02
where es_veterinario = 1 and es_administrativo = 0 and es_gerente = 0;

update empleado
set sueldo_mensual = sueldo_mensual * 1.03
where es_administrativo = 1 and es_veterinario = 0 and es_gerente = 0;

update empleado
set sueldo_mensual = sueldo_mensual * 1.05
where es_gerente = 1 and es_veterinario = 0 and es_administrativo = 0;

commit;