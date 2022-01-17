--@Autor(es):       (Alfaro) (Alfaro Alejandro Esaú|Domínguez Rodrigo)
--@Fecha Creación:  05/01/2022
--@Descripción:     Script de creación de procedimiento que 
--asignara quien adoptara cierta mascota

set serveroutput on;

create or replace procedure p_adopcion_mascota(
    p_mascota_id number
) is 
    v_id_max_donacion number(10,0);
    v_max_donaciones number(8,2);
    v_total_donacion_cliente number(8,2);
    v_fecha_mas_antigua date;
    v_num_mascotas_adoptadas number(1,0);
    v_num_interesados number(10,0);
    v_cliente_random number(10,0);
    v_num_iteracion number(10,0);
    v_tiene_cliente number(1,0);
    cursor cur_datos_interesados is 
    select cliente_id, fecha_seleccion
    from interesado_mascota 
    where mascota_id = p_mascota_id;
begin
    v_max_donaciones := 0.0;
    v_id_max_donacion := 0;

    select count(cliente_id) into v_tiene_cliente
    from mascota
    where mascota_id = p_mascota_id;

		if(v_tiene_cliente > 0) then
			raise_application_error(-20010,'La mascota con id '
            ||p_mascota_id|| ' ya cuenta con un dueño');
		end if;

    select count(*) into v_num_interesados
	from interesado_mascota
	where mascota_id = p_mascota_id;
	
    
		if(v_num_interesados = 0) then
        raise_application_error(-20010,'Por el momento no hay interesados en la mascota con id '
        ||p_mascota_id);
    end if;

    select min(fecha_seleccion) into v_fecha_mas_antigua
    from interesado_mascota
    where mascota_id = p_mascota_id
    group by (mascota_id);
    	
	if(sysdate - v_fecha_mas_antigua >= 15 ) then
		for interesado in cur_datos_interesados loop 
			select sum(monto) into v_total_donacion_cliente
			from donativo
			where cliente_id = interesado.cliente_id;

            select count(cliente_id) into v_num_mascotas_adoptadas
            from mascota 
            where cliente_id = interesado.cliente_id;

            if(v_num_mascotas_adoptadas >= 5) then

                insert into motivo_rechazo(motivo_rechazo_id,cliente_id,fecha_rechazo,mascota_id,observaciones)
                values(motivo_rechazo_seq.nextval,interesado.cliente_id,sysdate,p_mascota_id,
                    'El motivo del rechazo de la solicitud de adopción es debido a que el cliente ya posee cicno mascotas
                    y la politica de Pet Home indica que poseer más mascotas no se valido');
            else
			    if(v_total_donacion_cliente > v_max_donaciones) then
				    v_id_max_donacion := interesado.cliente_id;
				    v_max_donaciones := v_total_donacion_cliente;
			    end if;
			end if;
					
		end loop;
		if(v_id_max_donacion > 0 ) then
            for interesado in cur_datos_interesados loop 
                if(interesado.cliente_id <> v_id_max_donacion) then
                    insert into motivo_rechazo(motivo_rechazo_id,cliente_id,fecha_rechazo,mascota_id,observaciones)
                    values(motivo_rechazo_seq.nextval,interesado.cliente_id,sysdate,p_mascota_id,
                        'El motivo del rechazo de la solicitud de adopción es 
                        debido a que se presentó otro cliente con más donaciones');
                end if;
            end loop;
            dbms_output.put_line('Se ha seleccionado el dueño de la mascota');
			update mascota set cliente_id = v_id_max_donacion, status_id = 3 where mascota_id = p_mascota_id;
        else 
			v_cliente_random := dbms_random.value(1,v_num_interesados);
            v_num_iteracion := 1;
            for interesado in cur_datos_interesados loop 

                if(v_num_iteracion = v_cliente_random) then
                    dbms_output.put_line('Se ha seleccionado el dueño de la mascota');
                    update mascota set cliente_id = interesado.cliente_id, status_id = 3 where mascota_id = p_mascota_id;
                else    
                    insert into motivo_rechazo(motivo_rechazo_id,cliente_id,fecha_rechazo,mascota_id,observaciones)
                    values(motivo_rechazo_seq.nextval,interesado.cliente_id,sysdate,p_mascota_id,
                        'El motivo del rechazo de la solicitud de adopción es 
                        debido a que no resultó ganador en el proceso de selección de dueño, aleatorio');
                end if;
            v_num_iteracion := v_num_iteracion + 1;
            end loop;
        end if;
    else
		raise_application_error(-20010,'AUN NO ES PERIODO DE SELCCION DE CLIENTE');
    end if;

end;
/
show errors;