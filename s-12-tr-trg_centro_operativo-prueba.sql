--@Autor(es):       (Alfaro) (Alfaro Alejandro Esaú|Domínguez Rodrigo)
--@Fecha Creación:  05/01/2022
--@Descripción:     Script de prueba de trigger encargado de validar
-- que el empleado ingresado a la tabla de centro_operativo sea un gerente
set serveroutput on

prompt ====================================================================
prompt Prueba 1.
prompt Insertando un registro y revisando que sea correcto (caso funcional)
prompt ====================================================================

declare
	v_registros number(5,0);
begin

  insert into centro_operativo (
		centro_operativo_id,empleado_id,es_refugio,es_clinica,es_oficina,direccion,
    latitud,longitud,codigo,nombre)
	values(centro_operativo_seq.nextval,3,1,0,0,'Rio blanco 201',95.720,35.14,
    'MP201','Maria^s PetShop');

    select count (*) into v_registros
    from centro_operativo
    where nombre = 'Maria^s PetShop';

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
    insert into centro_operativo (
		  centro_operativo_id,empleado_id,es_refugio,es_clinica,
   	  es_oficina,direccion,latitud,longitud,codigo,nombre)
	  values(centro_operativo_seq.nextval,1,1,
		  0,0,'Rio blanco 201',95.720,35.14,'MP201','Maria^s Refugio');

    select count (*) into v_registros
    from centro_operativo
    where nombre = 'Maria^s Refugio';

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
	v_empleado_id number(10,0);
begin
    
    update centro_operativo
    set empleado_id = 3, direccion = 'Rio Blanco 666',latitud = 80.92,
      longitud = 70.23,codigo = 'MKLOP'
    where centro_operativo_id = 100;

    select empleado_id into v_empleado_id
    from centro_operativo
    where centro_operativo_id = 100;

    if(v_empleado_id = 3) then
        dbms_output.put_line('Update realizad');
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
	v_empleado_id number(10,0);
begin
    
    update centro_operativo
    set empleado_id = 1, direccion = 'Rio Blanco 666',latitud = 80.92,
      longitud = 70.23, codigo = 'MKLOP'
    where centro_operativo_id = 100;

    select empleado_id into v_empleado_id
    from centro_operativo
    where centro_operativo_id = 100;

    if(v_empleado_id = 1) then
        dbms_output.put_line('Update realizad');
    else 
		dbms_output.put_line('Error se regreso a un estado anterior');
	end if;
    commit;
end;
/