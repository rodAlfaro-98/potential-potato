--@Autor(es):       (Alfaro) (Alfaro Alejandro Esaú|Domínguez Rodrigo)
--@Fecha Creación:  05/01/2022
--@Descripción:     Script que vuelve eficiente la actualización de los sueldos de veterinarios
--o administrativos
set serveroutput on;

create or replace trigger trg_actualiza_sueldo
	for update of sueldo_mensual on empleado 
	compound trigger

type sueldo_actualizado_type is record(
  empleado_log_id empleado_log.empleado_log_id%type,
	empleado_id empleado_log.empleado_id%type,
	sueldo_anterior empleado_log.sueldo_anterior%type,
	sueldo_nuevo empleado_log.sueldo_nuevo%type,
	es_veterinario empleado_log.es_veterinario%type,
	es_administrativo empleado_log.es_administrativo%type,
	fecha_actualizacion empleado_log.fecha_actualizacion%type,
	usuario empleado_log.usuario%type
);

type sueldo_list_type is table of sueldo_actualizado_type;

sueldo_list sueldo_list_type := sueldo_list_type();

before each row is

v_usuario varchar2(30) := sys_context('USERENV','SESSION_USER');
v_index number;

begin
    if(:new.es_gerente = 0) then
        sueldo_list.extend;
        v_index := sueldo_list.last;
        sueldo_list(v_index).empleado_id := :new.empleado_id;
	    sueldo_list(v_index).empleado_log_id := empleado_log_seq.nextval;
	    sueldo_list(v_index).sueldo_anterior := :old.sueldo_mensual;
	    sueldo_list(v_index).sueldo_nuevo := :new.sueldo_mensual;
	    sueldo_list(v_index).es_veterinario := :old.es_veterinario;
        sueldo_list(v_index).es_administrativo := :old.es_administrativo;
        sueldo_list(v_index).fecha_actualizacion := sysdate;
        sueldo_list(v_index).usuario := v_usuario;
    end if;
end before each row;
after statement is
begin
    dbms_output.put_line('Empezando inserciones');
    forall i in sueldo_list.first .. sueldo_list.last
        insert into empleado_log(empleado_log_id,empleado_id,sueldo_anterior,
          sueldo_nuevo,es_veterinario,es_administrativo,fecha_actualizacion,usuario)
		values(sueldo_list(i).empleado_log_id,sueldo_list(i).empleado_id,
          sueldo_list(i).sueldo_anterior,sueldo_list(i).sueldo_nuevo,
          sueldo_list(i).es_veterinario,sueldo_list(i).es_administrativo,
          sueldo_list(i).fecha_actualizacion,sueldo_list(i).usuario);
end after statement;

end;
/
show errors;