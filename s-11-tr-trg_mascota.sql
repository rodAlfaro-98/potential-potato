--@Autor(es):       (Alfaro) (Alfaro Alejandro Esaú|Domínguez Rodrigo)
--@Fecha Creación:  05/01/2022
--@Descripción:     Script de creación de trigger encargado de validar
-- que los datos sean correctos 

/*Al insertar Mascota revisar que el valor de centro_operativo_id sea un refugio y que este no sea nulo en caso de que su estado <= 3 y además que no tenga cliente_id.
*/
set serveroutput on

create or replace trigger trg_mascota
before insert or update or delete on mascota
for each row
declare 
    v_status_id number(1,0);
    v_centro_operativo_id number(5,0);
    v_es_refugio number(1,0);
    v_hay_refugio number(1,0);
begin
  case
    when inserting then
     
        select count(*) into v_hay_refugio
        from centro_operativo
        where centro_operativo_id = :new.centro_operativo_id;
        
        if(v_hay_refugio > 0) then
            select es_refugio into v_es_refugio
            from centro_operativo
            where centro_operativo_id = :new.centro_operativo_id;
        else
            v_es_refugio := 0;
        end if;

		if(:new.status_id >=3 and (v_centro_operativo_id is not null or :new.cliente_id is null ) )then
            raise_application_error(-20010,'El status '||:new.status_id
            || 'indica que no nació en refugio y ya fue adoptada la mascota');
        end if;
        if(:new.status_id < 3 and :new.cliente_id is not null) then
            raise_application_error(-20010,'El status '||:new.status_id
            || 'indica que la mascota no ha sido adoptada');
        end if;
        if(:new.status_id >= 6 and :new.causa_muerte is null) then
            raise_application_error(-20010,'El status '||:new.status_id
            || 'indica que la mascota ya falleció y no hay causa de muerte');
        end if;
        if(v_es_refugio = 0 and :new.origen_mascota_id = 3) then
            raise_application_error(-20010,'El status '||:new.status_id
            || 'indica que la mascota nacio en refugio y el centro_operativo '
            ||:new.centro_operativo_id||' no corresponde a un refugio');
        end if;
        if(v_es_refugio = 1 and :new.origen_mascota_id <> 3) then
            raise_application_error(-20010,'El status '||:new.status_id
            || 'indica que la mascota no nacio en refugio');
        end if;
        dbms_output.put_line('Insertando primer estatus en historial_status');
        insert into historial_status(historial_status_id,fecha_status,status_id,mascota_id)
        values(HISTORIAL_STATUS_SEQ.nextval,sysdate,:new.status_id,:old.mascota_id);
    when updating then

        select count(*) into v_hay_refugio
        from centro_operativo
        where centro_operativo_id = :new.centro_operativo_id;
        
        if(v_hay_refugio > 0) then
            select es_refugio into v_es_refugio
            from centro_operativo
            where centro_operativo_id = :new.centro_operativo_id;
        else
            select count(*) into v_hay_refugio
            from centro_operativo
            where centro_operativo_id = :old.centro_operativo_id;
            
            if(v_hay_refugio > 0) then
                select es_refugio into v_es_refugio
                from centro_operativo
                where centro_operativo_id = :new.centro_operativo_id;
            else
                v_es_refugio := 0;
            end if;
        end if;

		if(v_es_refugio = 1 and :new.origen_mascota_id < 3) then
            raise_application_error(-20010,'El status '||:new.status_id
            || ' indica que la mascota no nacio en refugio');
        end if;
        if(v_es_refugio = 0 and :new.origen_mascota_id = 3) then
            raise_application_error(-20010,'El status '||:new.status_id
            || ' indica que la mascota nacio en refugio y el centro_operativo '
            ||:new.centro_operativo_id||' no corresponde a un refugio');
        end if;
        if(:old.status_id <> :new.status_id) then
            dbms_output.put_line('Insertando nuevo estatus en historial_status');
            insert into historial_status(historial_status_id,fecha_status,status_id,mascota_id)
            values(HISTORIAL_STATUS_SEQ.nextval,sysdate,:new.status_id,:old.mascota_id);
        end if;
		if((:new.status_id = 6 or :new.status_id = 7) and :new.causa_muerte = null) then
            raise_application_error(-20010,'El status '||:new.status_id
            ||' indica que la mascota falleció y no hay causa de muerte');
        end if;
    when deleting then
        raise_application_error(-20010,'No se puede borrar una mascota a pesar de haber fallecido');
  end case;
	
end;
/
show errors;