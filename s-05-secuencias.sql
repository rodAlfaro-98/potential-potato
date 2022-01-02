--@Autor(es):       (Alfaro) (Alfaro Alejandro Esaú|Domínguez Rodrigo)
--@Fecha Creación:  30/12/2021
--@Descripción:     Script de creación de las secuencias del proyecto de Pet Home




prompt creando secuencia Empleado

create sequence empleado_seq
start with 1
increment by 1
nocycle;

create sequence centro_operativo_seq
start with 1
increment by 1
nocycle;

create sequence titulo_seq
start with 5
increment by 3
nocycle;

create sequence direccion_web_refugio_seq
start with 2
increment by 2
nocycle;

create sequence cliente_seq
start with 1
increment by 1
cache 5
nocycle;

create sequence DONATIVO_SEQ
start with 1
increment by 1
nocycle;

create sequence TIPO_MASCOTA_SEQ
start with 1
increment by 1
nocycle;

create sequence STATUS_SEQ
start with 1
increment by 1
nocycle;

create sequence MASCOTA_SEQ
start with 1
increment by 1
cache 5
nocycle;

create sequence HISTORIAL_STATUS_SEQ
start with 1
increment by 1
nocycle;

create sequence revision_mascota_adoptada_SEQ
start with 1
increment by 1
nocycle;

create sequence REVISION_MASCOTA_REFUGIO_SEQ
start with 1
increment by 1
nocycle;

