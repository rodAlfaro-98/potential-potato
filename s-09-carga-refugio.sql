--@Autor(es):       (Alfaro) (Alfaro Alejandro Esaú|Domínguez Rodrigo)
--@Fecha Creación:  30/12/2021
--@Descripción:     Script de creación de la carga centro operativo del proyecto de Pet Home

declare
  v_actual_id number(10,0);
  v_next_id number(10,0);
  v_numero_registro varchar2(8);
  v_capacidad_maxima number(5,0);
  logo
begin
  
  for i in 1 .. 100 loop
    if(mod(i,4) = 0 or mod(i,4) = 3)then
        insert into centro_operativo (centro_operativo_id,empleado_id,
          es_refugio,es_clinica,es_oficina,direccion,latitud,longitud,
          codigo,nombre)
        values(centro_operativo_seq.nextval,i,v_es_refugio, v_es_clinica,
          v_es_oficina,v_direccion,v_latitud,v_longitud,v_codigo,
          v_nombre_refugio);
    end if;
  end loop;
end;
/
commit;