--@Autor(es):       (Alfaro) (Alfaro Alejandro Esaú|Domínguez Rodrigo)
--@Fecha Creación:  03/01/2022
--@Descripción:     Script de carga incial clientes del proyecto de Pet Home


set serveroutput on;

declare
  v_actual_id number(10,0);
  v_next_id number(10,0);
  type v_nombre is varray(11) of varchar2(500);
  nombres v_nombre;
  v_nom varchar2(500);
	v_fecha_titulacion date;
begin

  nombres := v_nombre('programador','heroe profesional','certeria','domador de bestias','biologo marino','biologo',
    'ninja','veterinario','administrador','jugador de lol profesional');

  for i in 1 .. 100 loop
	v_nom := nombres(mod(i,9)+1);
	v_fecha_titulacion := sysdate - i;
    insert into titulo (titulo_id,nombre_titulo,fecha_titulacion,empleado_id)
    values(titulo_seq.nextval,v_nom,v_fecha_titulacion,i);
    /*dbms_output.put_line(v_es_gerente||','||v_es_veterinario||','
      ||v_es_administrativo||','||v_curp||','||v_num_cedula||','
      ||v_fecha_ingreso||','||v_email||','||v_nom||','||v_ap_paterno||','
      ||v_ap_materno||','||v_sueldo);*/
  end loop;
end;
/

commit;