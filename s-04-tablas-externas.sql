--@Autor(es):       (Alfaro) (Alfaro Alejandro Esaú|Domínguez Rodrigo)
--@Fecha Creación:  02/01/2022
--@Descripción:     Script de creación de las tablas temporales del proyecto de Pet Home




prompt Conectando como sys
connect sys as sysdba

prompt creando directorio tmp_dir
create or replace directory tmp_dir as '/tmp/bases';


grant read, write on directory tmp_dir to aa_proy_admin;

prompt Contectando con usuario aa_proy_admin para crear la tabla externa
connect aa_proy_admin
show user
prompt creando tabla externa
create table cliente_ext (
    cliente_id      number(10,0),
    nombre  		varchar2(200),
    apellido_paterno      varchar2(40),
    apellido_materno      varchar2(40),
    direccion       varchar2(500),
    ocupacion       varchar2(40),
    username        varchar2(40),
    password        varchar2(40)
)
organization external (
    type oracle_loader
    default directory tmp_dir
    access parameters (
        records delimited by newline
        badfile tmp_dir:'cliente_ext_bad.log'
        logfile tmp_dir:'cliente_ext.log'
        fields terminated by '#'
        lrtrim
        missing field values are null 
        (
        	cliente_id, nombre, apellido_paterno, apellido_materno,direccion,ocupacion,username,password
        )
    )
    location ('cliente_ext.csv')
)
reject limit unlimited;


prompt creando el directorio /tmp/bases en caso de no existir
!mkdir -p /tmp/bases


prompt copiando el archivo csv a /tmp/bases
!cp cliente_ext.csv /tmp/bases
prompt cambiando permisos
!chmod 777 /tmp/bases

prompt mostrando los datos 

col nombre format a20
col ap_paterno format a20
col ap_materno format a20

select * from cliente_ext;