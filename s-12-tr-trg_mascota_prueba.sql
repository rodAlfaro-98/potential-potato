--@Autor(es):       (Alfaro) (Alfaro Alejandro Esaú|Domínguez Rodrigo)
--@Fecha Creación:  05/01/2022
--@Descripción:     Script de creación de trigger encargado de validar
-- que los datos sean correctos

set serveroutput on

prompt ====================================================================
prompt Prueba 1.
prompt Insertando un registro y revisando que sea correcto (caso funcional)
prompt ====================================================================

declare
	v_registros number(5,0);
begin

    insert into mascota(mascota_id,fecha_status,nombre,folio,fecha_ingreso,
        fecha_nacimiento,tipo_mascota_id,origen_mascota_id,status_id,cliente_id)
    values(mascota_seq.nextval,sysdate,'Cramberry','CAM15',sysdate-1,sysdate-10,1,2,4,1);

    select count (*) into v_registros
    from mascota
    where nombre = 'Cramberry';

    if(v_registros = 1) then
        dbms_output.put_line('Insert exitoso');
    else 
		dbms_output.put_line('Insert fail');
	end if;
    rollback;    
end;
/
prompt ====================================================================
prompt Prueba 2.
prompt Insertando un registro y revisando que sea correcto (caso erroneo)
prompt ====================================================================

declare
	v_registros number(5,0);
begin
    insert into mascota(mascota_id,fecha_status,nombre,folio,fecha_ingreso,
        fecha_nacimiento,tipo_mascota_id,origen_mascota_id,mascota_mama,mascota_papa,centro_operativo_id)
    values(mascota_seq.nextval,sysdate,'Cramberry','CAM15',sysdate-1,sysdate-10,1,3,1,1,1);

    select count (*) into v_registros
    from mascota
    where nombre = 'Cramberry';

    if(v_registros = 1) then
        dbms_output.put_line('Insert exitoso');
    else 
		dbms_output.put_line('Insert fail');
	end if;

rollback;
end;
/

prompt ====================================================================
prompt Prueba 3.
prompt Actualizando un registro y revisando que sea correcto (caso exitoso)
prompt ====================================================================

declare
	v_centro_operativo_id number(5,0);
begin
    
    update mascota
    set origen_mascota_id = 3, centro_operativo_id = 12
    where mascota_id = 3;

    select centro_operativo_id into v_centro_operativo_id
    from mascota
    where mascota_id = 3;

    if(v_centro_operativo_id = 12) then
        dbms_output.put_line('Update realizado');
    else 
		dbms_output.put_line('Error se regreso a un estado anterior');
	end if;
    commit;
end;
/

prompt ====================================================================
prompt Prueba 4.
prompt Actualizando un registro y revisando que sea correcto (caso erroneo)
prompt ====================================================================

declare
	v_centro_operativo_id number(5,0);
begin
    
    update mascota
    set origen_mascota_id = 1, centro_operativo_id = 12
    where mascota_id = 5;

    commit;

    select centro_operativo_id into v_centro_operativo_id
    from mascota
    where mascota_id = 5;

    if(v_centro_operativo_id = 12) then
        dbms_output.put_line('Update realizado');
    else 
		dbms_output.put_line('Error se regreso a un estado anterior');
	end if;
end;
/