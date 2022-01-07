--@Autor(es):       (Alfaro) (Alfaro Alejandro Esaú|Domínguez Rodrigo)
--@Fecha Creación:  05/01/2022
--@Descripción:     Script de prueba de procedimiento que 
--asignara quien adoptara cierta mascota
set serveroutput on;

declare 

begin

	p_adopcion_mascota(p_mascota_id => 18);
end;
/

declare

begin
    p_adopcion_mascota(p_mascota_id => 1);
end;
/

declare

begin
    p_adopcion_mascota(p_mascota_id => 59);
end;
/
show errors;
