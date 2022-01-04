--@Autor(es):       (Alfaro) (Alfaro Alejandro Esaú|Domínguez Rodrigo)
--@Fecha Creación:  30/12/2021
--@Descripción:     Script de creación de la carga centro operativo del proyecto de Pet Home

declare
  v_actual_id number(10,0);
  v_next_id number(10,0);
  type v_nombre is varray(11) of varchar2(500);
  nombres v_nombre;
  v_nom varchar2(500);
  type v_apellido_paterno is varray(11) of varchar2(500);
  app v_apellido_paterno;
  v_ap_paterno varchar2(40);
  v_es_refugio number(1,0);
  v_es_clinica number(1,0);
  v_es_oficina number(1,0);
  v_direccion varchar2(500);
  v_longitud number(7,5);
  v_latitud number(7,5);
  v_codigo varchar2(5);
  v_nombre_refugio varchar2(80);
begin

  nombres := v_nombre('Santuario','Abrigo','Establecimiento','Felicidad','Hotel','Patitas','Parque','Bienestar');
  app := v_apellido_paterno('De lomitos','Para Perritos','de tus mascotas','de tus animalitos','de sus michis');
  
  for i in 1 .. 100 loop
    v_direccion := 'calle ' || i || ' induatrial num: ' || (i + 3);
	v_nom := nombres(mod(i,8)+1);
	v_ap_paterno := app(mod(i,5)+1);
	v_codigo := substr(v_nom,1,1)||substr(v_ap_paterno,1,1)||i;
	v_nombre_refugio := v_nom ||' '|| v_ap_paterno;
	v_latitud := mod(dbms_random.random,99) + 1 ;
	v_longitud := mod(dbms_random.random,99) + 1 ;
    if(mod(i,4) = 0)then
        v_es_refugio := 1;
        v_es_clinica := 0;
        v_es_oficina := 0;
    elsif(mod(i,4) = 1) then
        v_es_refugio := 0;
        v_es_clinica := 1;
        v_es_oficina := 0;
    elsif(mod(i,4) = 2) then
        v_es_refugio := 0;
        v_es_clinica := 0;
        v_es_oficina := 1;
    elsif(mod(i,4) = 3) then 
        v_es_refugio := 1;
        v_es_clinica := 1;
        v_es_oficina := 0;
    end if;
    insert into centro_operativo (centro_operativo_id,empleado_id,
        es_refugio,es_clinica,es_oficina,direccion,latitud,longitud,
        codigo,nombre)
    values(centro_operativo_seq.nextval,i,v_es_refugio, v_es_clinica,
      v_es_oficina,v_direccion,v_latitud,v_longitud,v_codigo,
      v_nombre_refugio);
  end loop;
end;
/
commit;