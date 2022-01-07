--@Autor(es):       (Alfaro) (Alfaro Alejandro Esaú|Domínguez Rodrigo)
--@Fecha Creación:  05/01/2022
--@Descripción:     Script de creación de trigger encargado de validar
-- que el empleado ingresado a la tabla de centro_operativo sea un gerente



create or replace trigger trg_centro_operativo
after insert or update of  empleado_id,direccion,codigo on centro_operativo 
for each row
declare 
    v_es_gerente number(1,0);
    v_modificaciones varchar2(4000);
    v_empleado_id number(10,0);
begin
    case 
        when inserting then
            v_empleado_id := :new.empleado_id;
            select es_gerente into v_es_gerente
            from empleado
            where empleado_id = v_empleado_id;
            if(v_es_gerente = 1) then
				dbms_output.put_line('El registro fue insertado con exito');
            else
                delete from centro_operativo where empleado_id = :new.empleado_id;
                raise_application_error(-20010,'El empleado con id '||:new.empleado_id||
                  ' no presenta el rol de gerente. Insert invalido');
            end if;
            
        when updating then
            v_empleado_id := :new.empleado_id;
            select es_gerente into v_es_gerente
            from empleado
            where empleado_id = v_empleado_id;
            if(v_es_gerente = 1) then
                v_modificaciones := 'Se cambiaron los siguientes datos: ';
                if(:old.direccion <> :new.direccion) then
                    v_modificaciones :=  v_modificaciones || '\n direccion: anterior direccion= '||:old.direccion;
                    v_modificaciones :=  v_modificaciones || '\n\t nueva direccion= '||:new.direccion;
                end if;
                if(:old.codigo <> :new.codigo) then
                    v_modificaciones :=  v_modificaciones || '\n codigo: anterior codigo= '||:old.codigo;
                    v_modificaciones :=  v_modificaciones || '\n\t nuevo codigo = '||:new.codigo;
                end if;
                if(:old.latitud <> :new.latitud) then
                    v_modificaciones :=  v_modificaciones || '\n latitud: anterior latitud= '||:old.latitud;
                    v_modificaciones :=  v_modificaciones || '\n\t nueva latitud= '||:new.latitud;
                end if;
                if(:old.longitud <> :new.longitud) then
                    v_modificaciones :=  v_modificaciones || '\n latitud: anterior longitud= '||:old.longitud;
                    v_modificaciones :=  v_modificaciones || '\n\t nueva longitud= '||:new.longitud;
                end if;

                insert into operaciones_centro_operativo(operaciones_centro_operativo_id,usuario,fecha_accion,empleado_antiguo,empleado_nuevo,otros_cambios)
                values(operaciones_centro_operativo_seq.nextval,sys_context('USERENV','SESSION_USER'),sysdate,:old.empleado_id, :new.empleado_id,v_modificaciones);

            else
                raise_application_error(-20010,'El empleado con id '||:new.empleado_id||
                  ' no presenta el rol de gerente. Update invalido');
            end if;
    end case;
end;
/
show errors;