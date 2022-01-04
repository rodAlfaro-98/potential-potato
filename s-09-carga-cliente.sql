--@Autor(es):       (Alfaro) (Alfaro Alejandro Esaú|Domínguez Rodrigo)
--@Fecha Creación:  30/12/2021
--@Descripción:     Script de carga incial clientes del proyecto de Pet Home


set serveroutput on;

declare
  v_actual_id number(10,0);
  v_next_id number(10,0);
  type v_nombre is varray(11) of varchar2(500);
  nombres v_nombre;
  v_nom varchar2(500);
  type v_apellido_paterno is varray(11) of varchar2(500);
  app v_apellido_paterno;
  type v_apellido_materno is varray(11) of varchar2(500);
  apm v_apellido_materno;
  v_ap_paterno varchar2(40);
  v_ap_materno varchar2(40);
	v_direccion varchar2(500);
  type v_ocupaciones is varray(11) of varchar2(40);
  v_ocupacion v_ocupaciones;
  v_ocup varchar2(40);
	v_username varchar2(40);
	v_password varchar2(40);
begin

  nombres := v_nombre('Juan','Pedro','Pablo','Hugo','Luis','Maria','Fernanda','Valeria','Francisca','Alberto');
  app := v_apellido_paterno('Alfaro','Gutierrez','Perez','Lopez','Garcia','Hernandez','Robledo','Martinez','Dominguez','Todoroki');
  apm := v_apellido_materno('Alfaro','Gutierrez','Perez','Lopez','Garcia','Hernandez','Robledo','Martinez','Dominguez','Todoroki');
  v_ocupacion := v_ocupaciones('programador','heroe profesional','cazador de demonios','carnicero','biologo marino','alquimista estatal',
    'ninja','heroe clase S','sensei','jugador de lol profesional');

  for i in 1 .. 100 loop
	v_nom := nombres(mod(i,9)+1);
	v_ap_paterno := app(mod(i,8)+1);
	v_ap_materno := apm(mod(i,7)+1);
	v_direccion := 'calle' || i || 'induatrial num:' || (i + 3);
    v_ocup := v_ocupacion(mod(i,10) +1);
	v_username := v_nom || i || v_ap_paterno;
    v_password := v_nom || i;
    insert into cliente (cliente_id,nombre,apellido_paterno,apellido_materno,direccion,ocupacion,username,password)
    values(cliente_seq.nextval,v_nom,v_ap_paterno,v_ap_materno,v_direccion,v_ocup,v_username,v_password);
    /*dbms_output.put_line(v_es_gerente||','||v_es_veterinario||','
      ||v_es_administrativo||','||v_curp||','||v_num_cedula||','
      ||v_fecha_ingreso||','||v_email||','||v_nom||','||v_ap_paterno||','
      ||v_ap_materno||','||v_sueldo);*/
  end loop;
end;
/

commit;