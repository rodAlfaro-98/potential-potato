--@Autor(es):       (Alfaro) (Alfaro Alejandro Esaú|Domínguez Rodrigo)
--@Fecha Creación:  08/01/2022
--@Descripción:     Script de prueba de funcion fx_estadistica_defuncion

set serveroutput on;

declare
    v_cantidad number(10,0);
    v_causa varchar2(40);
    v_periodo varchar2(4);
begin
    v_causa := 'moquillo';
		v_periodo := '2022';
    v_cantidad := fx_estadistica_defuncion(v_causa,v_periodo);
    dbms_output.put_line('La cantidad de mascotas que murieron por '
    ||v_causa||' en el periodo del '||v_periodo||' fue de '||v_cantidad);
end;
/
select * from mascota_defuncion_temp;
