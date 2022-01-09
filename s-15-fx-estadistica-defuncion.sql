--@Autor(es):       (Alfaro) (Alfaro Alejandro Esaú|Domínguez Rodrigo)
--@Fecha Creación:  05/01/2022
--@Descripción:     Script de función que retorna la estadísitca de la causa de muerte elegida por el usuario




create or replace function fx_estadistica_defuncion(
    causa varchar2, año varchar2 
) return number is
    v_num_registros number(5,0);
begin
	if(año = '') then
		insert into mascota_defuncion_temp (mascota_id,nombre,fecha_status,causa_muerte,cliente_id)
        select mascota_id, nombre, fecha_status, causa_muerte, nvl(cliente_id,0)
        from mascota
        where lower(causa_muerte) like '%'||lower(causa)||'%';
    else 
		insert into mascota_defuncion_temp (mascota_id,nombre,fecha_status,causa_muerte,cliente_id)
        select mascota_id, nombre, fecha_status, causa_muerte, nvl(cliente_id,0)
        from mascota
        where lower(causa_muerte) like '%'||lower(causa)||'%'
        and fecha_status between to_date(año,'yyyy') and to_date(año,'yyyy')+365;
    end if;
	select count(*) into v_num_registros from mascota_defuncion_temp;
return v_num_registros;
end;
/
show errors;