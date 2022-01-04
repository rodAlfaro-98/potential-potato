--@Autor(es):       (Alfaro) (Alfaro Alejandro Esaú|Domínguez Rodrigo)
--@Fecha Creación:  03/01/2022
--@Descripción:     Script de carga incial origen mascota del proyecto de Pet Home

insert into status (status_id, estado)
values(STATUS_SEQ.nextval,'EN REFUGIO');

insert into status (status_id, estado)
values(STATUS_SEQ.nextval,'DISPONIBLE PARA ADOPCION');

insert into status (status_id, estado)
values(STATUS_SEQ.nextval,'SOLICITADO PARA ADOPCION');

insert into status (status_id, estado)
values(STATUS_SEQ.nextval,'ADOPTADA');

insert into status (status_id, estado)
values(STATUS_SEQ.nextval,'ENFERMA');

insert into status (status_id, estado)
values(STATUS_SEQ.nextval,'FALLECIDA EN REFUGIO');

insert into status (status_id, estado)
values(STATUS_SEQ.nextval,'FALLECIDA EN HOGAR');