--@Autor(es):       (Alfaro) (Alfaro Alejandro Esaú|Domínguez Rodrigo)
--@Fecha Creación:  05/01/2022
--@Descripción:     Script de función que actualiza el logo de un refugio




--Para que este programa funcione se necesita haber realizado la práctica 12
prompt Configurando directorio
connect sys/"Th3B3@tl3s" as sysdba
create or replace directory fotos_dir as 
  '/media/rodrigoad/PROSYS/unam-clases/BD/ProyectoFinal/potential-potato/fotos_refugio';

grant read, write on directory fotos_dir to aa_proy_admin;

prompt Creando procedimiento con usuario aa_proy_admin

connect aa_proy_admin/alfaro;
set serveroutput on

create or replace function fx_actualiza_logo
(p_refugio_id in number, p_num_images in number) return number is


v_bfile bfile;
v_src_offset number;
v_dest_offset number;
v_blob blob;
v_src_length number;
v_dest_length number;
v_nombre_archivo varchar2(50);
v_iterador number;
v_id number;
v_random number;

cursor cur_datos_refugio is 
    select centro_operativo_id
    from refugio
    where centro_operativo_id >= p_refugio_id;

begin
v_iterador := 0;
for refugio in cur_datos_refugio loop

    v_id := refugio.centro_operativo_id;
    if(v_iterador = p_num_images) then
        exit;
    end if;

    v_random := round(dbms_random.value(1,10));

    v_nombre_archivo := 'refugio'||v_random||'.jpg';
    dbms_output.put_line('Cargando foto para '||v_nombre_archivo);
    --Validando si el archivo existe
    v_bfile := bfilename('FOTOS_DIR',v_nombre_archivo);

    if(dbms_lob.fileexists(v_bfile) = 0) then
        raise_application_error(-20001,'El archivo '
        ||v_nombre_archivo||' no existe');
    end if;
    --abrir archivo
    if(dbms_lob.isopen(v_bfile) = 1) then
        raise_application_error(-20001,'El archivo esta abierto '
        ||v_nombre_archivo||' no se puede usar');
    end if;

    --abriemdo archivo
    dbms_lob.open(v_bfile,dbms_lob.lob_readonly);
    --Actualizando blob en la tabla
    --Asegurarse que la tabla auto contenga datos y la columna foto debe tener un blob vacío
    --Asignar v_blob

    dbms_output.put_line(v_id);

    select logo into v_blob
    from refugio 
    where centro_operativo_id = v_id
    for update;

    v_src_offset := 1;
    v_dest_offset := 1;
    --Escribiendo bytes
    dbms_lob.loadblobfromfile(
        dest_lob        => v_blob,
        src_bfile       => v_bfile,
        amount          => dbms_lob.getlength(v_bfile),
        dest_offset     => v_dest_offset,
        src_offset      => v_src_offset
    );
    --cerrando archivo
    dbms_lob.close(v_bfile);

    --Validando escritura
    v_src_length := dbms_lob.getlength(v_bfile);
    v_dest_length := dbms_lob.getlength(v_blob);

    v_iterador := v_iterador + 1;

end loop;

return 1;

end;
/
show errors