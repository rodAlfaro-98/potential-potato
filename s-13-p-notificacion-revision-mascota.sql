--@Autor(es):       (Alfaro) (Alfaro Alejandro Esaú|Domínguez Rodrigo)
--@Fecha Creación:  05/01/2022
--@Descripción:     Script de creación de procedimiento que 
--identifica a las mascotas que ya requieren una nueva revisión


create or replace procedure p_notificacion_revision_mascota(
    v_fecha_a_revisar date
)is 

    cursor cur_datos_mascota is 
    select mascota_id, status_id,cliente_id
    from mascota;
    v_fecha_revision date;
    v_veterinario_id number(10,0);
    v_diagnostico_pasado varchar2(500);
    v_revision_id number(10,0);
    v_calificacion_salud number(2,0);
    v_observaciones varchar2(500);
    v_num_revisiones number(10,0);
begin

		delete from notificacion_revision_cliente 
		where notificacion_revision_cliente_id >= 1;

		delete from notificacion_revision_refugio 
		where notificacion_revision_refugio_id >= 1;    
        
    for mascota in cur_datos_mascota loop

		
        if mascota.cliente_id is not null then
			select count(*) into v_num_revisiones
			from revision_mascota_adoptada
			where mascota_id = mascota.mascota_id;

			if(v_num_revisiones > 0) then
			
			select max(rr.fecha_revision) into v_fecha_revision
			from mascota m join revision_mascota_adoptada rr
			on m.mascota_id = rr.mascota_id
			where m.mascota_id = mascota.mascota_id;

            select rr.revision_mascota_adoptada_id into v_revision_id
            from mascota m join revision_mascota_adoptada rr
						on m.mascota_id = rr.mascota_id
			where m.mascota_id = mascota.mascota_id;

            select rr.calificacion_salud into v_calificacion_salud
            from mascota m join revision_mascota_adoptada rr
						on m.mascota_id = rr.mascota_id
			where m.mascota_id = mascota.mascota_id;

            select rr.observaciones into v_observaciones
            from mascota m join revision_mascota_adoptada rr
						on m.mascota_id = rr.mascota_id
			where m.mascota_id = mascota.mascota_id;

			if(v_fecha_a_revisar - 180 >= v_fecha_revision) then
								insert into notificacion_revision_cliente(notificacion_revision_cliente_id,
                  revision_mascota_adoptada_id,mascota_id,calificacion_salud,
                  status_actual_id,observaciones,fecha_ultima_revision)
                values(notificacion_revision_cliente_seq.nextval,v_revision_id,mascota.mascota_id,
                  v_calificacion_salud,mascota.status_id,v_observaciones,v_fecha_revision);
							end if;
				end if;
        else
            select count(*) into v_num_revisiones
            from revision_mascota_refugio
            where mascota_id = mascota.mascota_id;

            if(v_num_revisiones > 0) then
            
                select max(rr.fecha_revision) into v_fecha_revision
			    from mascota m join revision_mascota_refugio rr
			    on m.mascota_id = rr.mascota_id
			    where m.mascota_id = mascota.mascota_id;

                select rr.revision_mascota_refugio_id into v_revision_id
                from mascota m join revision_mascota_refugio rr
				on m.mascota_id = rr.mascota_id
			    where m.mascota_id = mascota.mascota_id;

                select rr.empleado_id into v_veterinario_id
                from mascota m join revision_mascota_refugio rr
				on m.mascota_id = rr.mascota_id
			    where m.mascota_id = mascota.mascota_id;

                select rr.diagnostico into v_diagnostico_pasado
                from mascota m join revision_mascota_refugio rr
				on m.mascota_id = rr.mascota_id
			    where m.mascota_id = mascota.mascota_id;

                if(mascota.status_id = 5) then
                
                    insert into notificacion_revision_refugio(notificacion_revision_refugio_id,
                      revision_mascota_refugio_id,mascota_id,veterinario_id,
                      diagnostico_pasado,status_actual_id,fecha_ultima_revision)
                    values(notificacion_revision_refugio_seq.nextval,v_revision_id,mascota.mascota_id,
                    v_veterinario_id,v_diagnostico_pasado,mascota.status_id,v_fecha_revision);
                else
				    if(v_fecha_a_revisar - 180 >= v_fecha_revision) then
					    insert into notificacion_revision_refugio(notificacion_revision_refugio_id,
                            revision_mascota_refugio_id,mascota_id,veterinario_id,
                            diagnostico_pasado,status_actual_id,fecha_ultima_revision)
                        values(notificacion_revision_refugio_seq.nextval,v_revision_id,mascota.mascota_id,
                            v_veterinario_id,v_diagnostico_pasado,mascota.status_id,v_fecha_revision);
					end if;
                end if;
            end if;
        end if;
    end loop;
end;
/
show errors