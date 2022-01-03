--@Autor(es):       (Alfaro) (Alfaro Alejandro Esaú|Domínguez Rodrigo)
--@Fecha Creación:  2/01/2022
--@Descripción:     Script de creación de las tablas temporales del proyecto de Pet Home

prompt Creando tabla temporal cliente interes mascota
drop table cliente_interes_mascota_temp_commit;
create global temporary table cliente_interes_mascota_temp_commit(
  cliente_id number(10,0) not null,
  mascota_id number(10,0) not null,
  fecha_seleccion date,
  constraint cliente_interes_mascota_temp_commit_pk 
  primary key(cliente_id,mascota_id)
) on commit delete rows;

create private temporary table ora$ptt_datos_donaciones_txn (
  cliente_id number(10,0),
  total_donativos number(13,2),
  iva_total_donativo number(13,2),
  max_donacion number(13,2),
  min_donacion number(13,2)
)on commit drop definition;