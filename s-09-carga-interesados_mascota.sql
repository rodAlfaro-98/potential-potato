declare
    v_mascota_id number(10,0);
    v_donacion  number(7,2);
    v_interesados number(2,0);
	v_fecha_seleccion date;
    v_cliente_random number(3,0);
begin

    for i in 1..10 loop
        v_mascota_id := dbms_random.value(1,100);
        
		select count(mascota_id) into v_interesados
        from interesado_mascota
        where mascota_id = v_mascota_id;

        if(v_interesados = 0) then 
            for i in 1..5 loop

                v_cliente_random :=dbms_random.value(1,100);

                select count(mascota_id) into v_interesados
                from interesado_mascota
                where mascota_id = v_mascota_id
                and cliente_id = v_cliente_random;
                
                if(v_interesados = 0) then
                    v_fecha_seleccion := sysdate - dbms_random.value(1,16);

                    insert into interesado_mascota (cliente_id,mascota_id,fecha_seleccion)
    				values(v_cliente_random,v_mascota_id,v_fecha_seleccion);
                
                    v_donacion := dbms_random.value(1,10) * 20;

                    insert into donativo(donativo_id,fecha,monto,cliente_id)
                    values(DONATIVO_SEQ.nextval,v_fecha_seleccion,v_donacion,v_cliente_random);
                end if;
            end loop;
        end if;
    end loop;
end;
/
show errors;