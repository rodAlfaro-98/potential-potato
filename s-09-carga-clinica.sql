--@Autor(es):       (Alfaro) (Alfaro Alejandro Esaú|Domínguez Rodrigo)
--@Fecha Creación:  30/12/2021
--@Descripción:     Script de creación de la carga centro operativo del proyecto de Pet Home

declare
  v_actual_id number(10,0);
  v_next_id number(10,0);
  v_hora_inicio date;
  v_hora_fin date;
  v_telefono_atencion_cliente number(15,0);
  v_telefono_emergencias number(15,0);
begin  
  for i in 1 .. 100 loop
  v_hora_inicio := to_date('03/01/2022 07:00','dd/mm/yyyy hh24:mi');
  v_hora_fin := to_date('03/01/2022 17:00','dd/mm/yyyy hh24:mi');
  v_telefono_atencion_cliente := 5565987412 + i;
  v_telefono_emergencias := 5521469874 + i;
    if(mod(i,4) = 1 or mod(i,4) = 3)then
        insert into clinica (centro_operativo_id,hora_inicio, hora_fin, 
          telefono_atencion_cliente,telefono_emergencias)
        values(i,v_hora_inicio,v_hora_fin,v_telefono_atencion_cliente,
          v_telefono_emergencias);
    end if;
  end loop;
end;
/
commit;