--@Autor(es):       (Alfaro) (Alfaro Alejandro Esaú|Domínguez Rodrigo)
--@Fecha Creación:  05/01/2022
--@Descripción:     Script de prueba de procedimiento que 
--asignara quien adoptara cierta mascota
set serveroutput on;

declare 
v_mascota_1 number(3,0);
begin
    select min(r.mascota_id) into v_mascota_1 from
    (select i.mascota_id 
    from mascota m join interesado_mascota i
    on m.mascota_id = i.mascota_id
    where m.cliente_id is null) r;

	p_adopcion_mascota(p_mascota_id => v_mascota_1);
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
