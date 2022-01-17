--@Autor(es):       (Alfaro) (Alfaro Alejandro Esaú|Domínguez Rodrigo)
--@Fecha Creación:  11/01/2022
--@Descripción:     Script main del proyecto de Pet Home

prompt Conectando a usuario sys
connect sys as sysdba

set serveroutput on;
declare
    v_count number;
begin
    select count(*) into v_count from all_users 
    where username = 'AA_PROY_ADMIN';
    if v_count > 0 then
        dbms_output.put_line('Eliminando al usuario aa_proy_admin');
        execute immediate 'drop user aa_proy_admin cascade';
    end if;
end;
/

declare
    v_count number;
begin
    select count(*) into v_count from all_users 
    where username = 'AA_PROY_INVITADO';
    if v_count > 0 then
        dbms_output.put_line('Eliminando al usuario aa_proy_invitado');
        execute immediate 'drop user aa_proy_invitado cascade';
    end if;
end;
/

@@s-01-usuarios.sql;

prompt Iniciando con usuario Admin
connect aa_proy_admin/alfaro

prompt Generando entidades
@@s-02-entidades.sql

prompt Generando tablas temporales
@@s-03-tablas-temporales.sql

prompt Generando tablas externas
@@s-04-tablas-externas.sql

prompt Generando secuencias
@@s-05-secuencias.sql

prompt Generando indices
@@s-06-indices.sql

prompt Generando sinonimos
@@s-07-sinonimos.sql

prompt Generando vistas
@@s-08-vistas.sql

prompt Carga Inicial
@@s-09-carga-inicial.sql