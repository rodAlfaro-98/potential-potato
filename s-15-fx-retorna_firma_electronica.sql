--@Autor(es):       (Alfaro) (Alfaro Alejandro Esaú|Domínguez Rodrigo)
--@Fecha Creación:  05/01/2022
--@Descripción:     Script de función que actualiza el logo de un refugio




--Para que este programa funcione se necesita haber realizado la práctica 12
prompt Configurando directorio
connect sys/"Th3B3@tl3s" as sysdba
create or replace directory firmas_electronicas as 
  '/media/rodrigoad/PROSYS/unam-clases/BD/ProyectoFinal/potential-potato/firmas_electronicas';

grant read, write on directory firmas_electronicas to aa_proy_admin;

prompt Creando procedimiento con usuario aa_proy_admin

connect aa_proy_admin/alfaro;
set serveroutput on

create or replace function fx_get_firma_electronica
(p_nombre_firma varchar) return blob is


v_bfile bfile;
v_src_offset number;
v_dest_offset number;
v_blob blob;
v_src_length number;
v_dest_length number;


begin
 


    dbms_output.put_line('Cargando foto para '||p_nombre_firma);
    --Validando si el archivo existe
    v_bfile := bfilename('FIRMAS_ELECTRONICAS',p_nombre_firma);

    if(dbms_lob.fileexists(v_bfile) = 0) then
        raise_application_error(-20001,'El archivo '||p_nombre_firma||' no existe');
    end if;
    --abrir archivo
    if(dbms_lob.isopen(v_bfile) = 1) then
        raise_application_error(-20001,'El archivo esta abierto '||p_nombre_firma||' no se puede usar');
    end if;

    --abriemdo archivo
    dbms_lob.open(v_bfile,dbms_lob.lob_readonly);
    --Actualizando blob en la tabla
    --Asegurarse que la tabla auto contenga datos y la columna foto debe tener un blob vacío
    --Asignar v_blob


    dbms_lob.CREATETEMPORARY(v_blob,TRUE,dbms_lob.session);

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

    return v_blob;

end;
/
show errors