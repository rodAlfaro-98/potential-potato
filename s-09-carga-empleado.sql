--@Autor(es):       (Alfaro) (Alfaro Alejandro Esaú|Domínguez Rodrigo)
--@Fecha Creación:  30/12/2021
--@Descripción:     Script de creación de la carga empleado del proyecto de Pet Home
set serveroutput on;

declare
  v_actual_id number(10,0);
  v_next_id number(10,0);
  type v_nombre is varray(11) of varchar2(500);
  nombres v_nombre;
  v_curp varchar2(18);
  v_num_cedula number(10,0);
  v_nom varchar2(500);
  type v_apellido_paterno is varray(11) of varchar2(500);
  app v_apellido_paterno;
  type v_apellido_materno is varray(11) of varchar2(500);
  apm v_apellido_materno;
  v_ap_paterno varchar2(40);
  v_ap_materno varchar2(40);
  v_fecha_ingreso date;
  v_sueldo number(8,2);
  v_es_gerente number(1,0);
  v_es_veterinario number(1,0);
  v_es_administrativo number(1,0);
  v_email varchar2(200);
begin

  nombres := v_nombre('Juan','Pedro','Pablo','Hugo','Luis','Maria','Fernanda',
    'Valeria','Francisca','Alberto');
  app := v_apellido_paterno('Alfaro','Gutierrez','Perez','Lopez','Garcia',
    'Hernandez','Robledo','Martinez','Dominguez','Todoroki');
  apm := v_apellido_materno('Alfaro','Gutierrez','Perez','Lopez','Garcia',
    'Hernandez','Robledo','Martinez','Dominguez','Todoroki');
  
  for i in 1 .. 100 loop
    v_curp := 'AADR980715HDFL'||i;
	v_num_cedula := '1356897' || i;
	v_nom := nombres(mod(i,9)+1);
	v_ap_paterno := app(mod(i,8)+1);
	v_ap_materno := apm(mod(i,7)+1);
	v_fecha_ingreso := sysdate - i;
	v_email := 'email_usuario_'||i||'_'||v_nom||'@pethome.com';
	v_sueldo := i * 1000;
    if(mod(i,6) = 0)then
        v_es_gerente := 1;
        v_es_veterinario := 0;
        v_es_administrativo := 0;
    elsif(mod(i,6) = 1) then
        v_es_gerente := 0;
        v_es_veterinario := 1;
        v_es_administrativo := 0;
    elsif(mod(i,6) = 2) then
        v_es_gerente := 0;
        v_es_veterinario := 0;
        v_es_administrativo := 1;
    elsif(mod(i,6) = 3) then 
        v_es_gerente := 1;
        v_es_veterinario := 1;
        v_es_administrativo := 1;
    elsif(mod(i,6) = 4) then 
        v_es_gerente := 1;
        v_es_veterinario := 1;
        v_es_administrativo := 0;
    elsif(mod(i,6) = 5) then 
        v_es_gerente := 0;
        v_es_veterinario := 1;
        v_es_administrativo := 1;
    end if;
    insert into empleado (empleado_id,es_gerente,
        es_veterinario,es_administrativo,curp,numero_cedula,fecha_ingreso,email,
        nombres,apellido_paterno,apellido_materno,sueldo_mensual)
    values(empleado_seq.nextval,v_es_gerente,v_es_veterinario,
      v_es_administrativo,v_curp,v_num_cedula,v_fecha_ingreso,v_email,v_nom,
      v_ap_paterno,v_ap_materno,v_sueldo);
    /*dbms_output.put_line(v_es_gerente||','||v_es_veterinario||','
      ||v_es_administrativo||','||v_curp||','||v_num_cedula||','
      ||v_fecha_ingreso||','||v_email||','||v_nom||','||v_ap_paterno||','
      ||v_ap_materno||','||v_sueldo);*/
  end loop;
end;
/