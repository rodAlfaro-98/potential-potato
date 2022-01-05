--@Autor(es):       (Alfaro) (Alfaro Alejandro Esaú|Domínguez Rodrigo)
--@Fecha Creación:  04/01/2022
--@Descripción:     Script de creación de la carga centro operativo del proyecto de Pet Home

declare
  v_numero_registro varchar2(8);
  v_capacidad_maxima number(5,0);
  v_lema varchar2(500);
  type v_nombre is varray(11) of varchar2(500);
  nombres v_nombre;
  v_nom varchar2(500);
  type v_apellido_paterno is varray(11) of varchar2(500);
  app v_apellido_paterno;
  v_refugio_alternativo number(5,0);
  v_maxima number(5,0);
begin
  nombres := v_nombre('Garantizamos','Lo mas importante es','Nos enfocamos en','Nuestra prioridad es');
  app := v_apellido_paterno('la satisfaccion','el cuidado','la felicidad','tus animalitos');
  
  for i in 1 .. 100 loop
    if(mod(i,4) = 0 or mod(i,4) = 3)then
        if(i > 4 ) then
          v_refugio_alternativo := i-4;
        else 
          v_refugio_alternativo := null;
        end if;
        v_lema := nombres(mod(i,4)+1)||' '||app(mod(i,3)+1);
        v_maxima := abs(mod(dbms_random.random,99)+1);
        v_numero_registro := 'RF'||abs(mod(dbms_random.random,99)+1)||'PT'||abs(mod(dbms_random.random,99)+1);
        insert into refugio (centro_operativo_id,
          refugio_alternativo_id,numero_registro,capacidad_maxima,logo,lema)
        values(i,v_refugio_alternativo,v_numero_registro,v_maxima,empty_blob(),v_lema);
    end if;
  end loop;
end;
/
commit;