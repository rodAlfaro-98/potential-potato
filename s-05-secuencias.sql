--@Autor(es):       (Alfaro) (Alfaro Alejandro Esaú|Domínguez Rodrigo)
--@Fecha Creación:  30/12/2021
--@Descripción:     Script de creación de las secuencias del proyecto de Pet Home




prompt creando secuencia Empleado

drop sequence empleado_seq;
create sequence empleado_seq
start with 1
increment by 1
nocycle;

drop sequence centro_operativo_seq;
create sequence centro_operativo_seq
start with 1
increment by 1
nocycle;

drop sequence titulo_seq;
create sequence titulo_seq
start with 5
increment by 3
nocycle;

drop sequence direccion_web_refugio_seq;
create sequence direccion_web_refugio_seq
start with 2
increment by 2
nocycle;

drop sequence cliente_seq;
create sequence cliente_seq
start with 1
increment by 1
cache 5
nocycle;

drop sequence DONATIVO_SEQ;
create sequence DONATIVO_SEQ
start with 1
increment by 1
nocycle;

drop sequence TIPO_MASCOTA_SEQ;
create sequence TIPO_MASCOTA_SEQ
start with 1
increment by 1
nocycle;

drop sequence STATUS_SEQ;
create sequence STATUS_SEQ
start with 1
increment by 1
nocycle;

drop sequence MASCOTA_SEQ;
create sequence MASCOTA_SEQ
start with 1
increment by 1
cache 5
nocycle;

drop sequence HISTORIAL_STATUS_SEQ;
create sequence HISTORIAL_STATUS_SEQ
start with 1
increment by 1
nocycle;

drop sequence revision_mascota_adoptada_SEQ;
create sequence revision_mascota_adoptada_SEQ
start with 1
increment by 1
nocycle;

drop sequence REVISION_MASCOTA_REFUGIO_SEQ;
create sequence REVISION_MASCOTA_REFUGIO_SEQ
start with 1
increment by 1
nocycle;

