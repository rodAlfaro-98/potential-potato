--@Autor(es):       (Alfaro) (Alfaro Alejandro Esaú|Domínguez Rodrigo)
--@Fecha Creación:  30/12/2021
--@Descripción:     Script de creación de la carga centro operativo del proyecto de Pet Home

declare
  v_nom varchar2(80);
  v_direccion_web varchar2(500);
begin

  for i in 1 .. 100 loop
    
    if(mod(i,4) = 0 or mod(i,4) = 3)then
        select nombre into v_nom
        from centro_operativo
        where centro_operativo_id = i;

        v_direccion_web := replace(v_nom,' ','_')||'.com.mx';
        
        insert into direccion_web_refugio (direccion_web_refugio_id,
          direccion_web,centro_operativo_id)
        values(direccion_web_refugio_seq.nextval,v_direccion_web,i);
    end if;
  end loop;
end;
/
commit;