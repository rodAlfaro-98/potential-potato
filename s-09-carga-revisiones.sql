--@Autor(es):       (Alfaro) (Alfaro Alejandro Esaú|Domínguez Rodrigo)
--@Fecha Creación:  05/01/2022
--@Descripción:     Script de carga de las tablas revision_mascota_refugio
-- y revision_mascota_adoptada


declare
    v_status_id number(1,0);
    v_refugio_id number(5,0);
    v_num_revision number(10,0);
    v_empleado_id number(10,0);
    v_fecha_revision date;
    v_calificacion_salud number(2,0);
    v_costo number(7,2);
    v_centro_operativo_id number(5,0);
    type v_nombre is varray(7) of varchar2(500);
    nombres v_nombre;
    v_nom varchar2(500);
begin
    
    for i in 1 .. 100 loop

        nombres := v_nombre('Sin mayores complicaciones','Enfermedad leve',
          'Requiere medicamentos','Requiere operacion',
          'Requiere vendaje de pata','Requiere seguimiento',
          'Completamente sano');
        v_nom := nombres(round(dbms_random.value(1,6)));

        select status_id into v_status_id
        from mascota
        where mascota_id = i;

        if(v_status_id <= 3) then
            select centro_operativo_id into v_refugio_id
            from mascota
            where mascota_id = i;
         v_fecha_revision := sysdate - 30*round(dbms_random.value(1,7));

            v_empleado_id := 6*round(dbms_random.value(1,16))+1;

            insert into Revision_mascota_refugio(revision_mascota_refugio_id,
              diagnostico,foto,mascota_id,empleado_id,fecha_revision)
            values(REVISION_MASCOTA_REFUGIO_SEQ.nextval,v_nom,empty_blob(),
              i,v_empleado_id,v_fecha_revision);
        else
            v_num_revision := round(dbms_random.value(1,100));
            v_fecha_revision := sysdate - 30*round(dbms_random.value(1,7));
            v_calificacion_salud := round(dbms_random.value(1,10));
            v_costo := i * round(dbms_random.value(1,50));
            v_centro_operativo_id := 2*round(dbms_random.value(1,49))+1;
            insert into revision_mascota_adoptada(
                revision_mascota_adoptada_id,numero_revision,
                fecha_revision,calificacion_salud,costo,observaciones,
                mascota_id,centro_operativo_id
            )
            values(revision_mascota_adoptada_seq.nextval,v_num_revision,
              v_fecha_revision, v_calificacion_salud,v_costo,v_nom,i,
              v_centro_operativo_id);
        end if;
    end loop;
end;
/
commit;