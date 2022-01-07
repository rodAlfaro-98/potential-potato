--@Autor(es):       (Alfaro) (Alfaro Alejandro Esaú|Domínguez Rodrigo)
--@Fecha Creación:  30/12/2021
--@Descripción:     Script de creación de las entidades del proyecto de Pet Home

connect aa_proy_admin/alfaro

prompt creando "Empleado"

drop table empleado cascade constraint;
create table EMPLEADO(
  empleado_id number(10,0) constraint empleado_pk primary key,
  es_gerente number(1,0),
  es_veterinario number(1,0) not null,
  es_administrativo number(1,0) not null,
  curp varchar2(20) not null constraint  empleado_curp_uk unique,
  numero_cedula  number(10,0) not null 
  constraint empleado_numero_cedula_uk unique,
  fecha_ingreso date not null,
  email varchar2(200) not null constraint empleado_email_uk unique,
  nombres varchar2(500) not null,
  apellido_paterno varchar2(40) not null,
  apellido_materno varchar2(40)  null,
  sueldo_mensual numeric(8,2) not null,
  constraint empleado_es_gerente_es_veterinario_es_administrativo_chk
  check((es_gerente,es_veterinario,es_administrativo) in ((1,1,1),(1,1,0),
    (0,1,1),(1,0,0),(0,1,0),(0,0,1)))
);

prompt creando tabla "CENTRO_OPERATIVO"
drop table CENTRO_OPERATIVO cascade constraint;
create table CENTRO_OPERATIVO(
  centro_operativo_id number (5,0) constraint 
  centro_operativo_pk primary key,
  empleado_id number(10,0) not null,
  es_refugio number(1,0) not null,
  es_clinica number(1,0) not null,
  es_oficina number(1,0) not null,
  direccion varchar2(500) not null,
  latitud number(7,5) not null,
  longitud number(7,5) not null,
  codigo varchar2(5) not null constraint centro_operativo_codigo_uk unique,
  nombre varchar2(80),
  constraint centro_operativo_empleado_id_fk foreign key(empleado_id)
  references empleado(empleado_id),
  constraint centro_operativo_es_refugio_es_clinica_es_oficina_chk
  check((es_refugio,es_clinica,es_oficina) in ((1,1,0),(1,0,0),(0,1,0),
    (0,0,1)))
);

prompt creando tabla "Título"

drop table TITULO cascade constraint;
create table TITULO(
  titulo_id number(10,0) constraint titulo_pk primary key,
  nombre_titulo varchar2(50) not null,
  fecha_titulacion date not null,
  empleado_id number(10,0) not null,
  constraint titulo_empleado_id_fk foreign key(empleado_id)  
  references empleado(empleado_id)
);

prompt creando tabla "Clinica"

drop table CLINICA cascade constraint;
create table CLINICA(
  centro_operativo_id number(5,0) constraint clinica_pk primary key,
  hora_inicio date not null,
  hora_fin date not null,
  telefono_atencion_cliente number(15,0) not null,
  telefono_emergencias number(15,0) not null,
  constraint clinica_centro_operativo_id_fk foreign key(centro_operativo_id)
  references centro_operativo(centro_operativo_id)
);

prompt creando tabla "Refugio"

drop table REFUGIO cascade constraint;
create table REFUGIO(
  centro_operativo_id number(5,0) constraint refugio_pk primary key,
  numero_registro varchar2(8) not null constraint 
  refugio_numero_registro_uk unique,
  capacidad_maxima number(5,0) not null,
  logo blob not null,
  lema varchar2(500) not null,
  refugio_alternativo_id number(5,0) constraint 
  refugio_regugio_id_pk references
  refugio(centro_operativo_id),
  constraint refugio_centro_operativo_id_fk foreign key(centro_operativo_id)
  references refugio(centro_operativo_id)
);

prompt creando tabla "Oficina"

drop table OFICINA cascade constraint;
create table OFICINA(
  centro_operativo_id number(5,0) constraint oficina_pk primary key,
  rfc varchar2(20) not null constraint oficina_rfc_uk unique,
  firma_electronica blob not null,
  nombre_responsable_legal varchar2(120) not null
);


prompt creando tabla "Direccion Web"

drop table DIRECCION_WEB_REFUGIO cascade constraint;
create table DIRECCION_WEB_REFUGIO(
  direccion_web_refugio_id number(10,0) constraint
  direccion_web_refugio_id primary key,
  centro_operativo_id number(5,0) constraint
  direccion_web_refugio_centro_operativo_fk references
  refugio(centro_operativo_id),
  direccion_web varchar2(500) not null
);


prompt creando tabla "Cliente"

drop table CLIENTE cascade constraint;
create table CLIENTE(
   cliente_id number(10,0) constraint cliente_pk primary key,
   nombre varchar2(200) not null,
   apellido_paterno varchar2(40) not null,
   apellido_materno varchar2(40) not null,
   direccion varchar2(500) not null,
   ocupacion varchar2(40) not null,
   username varchar2(40) not null constraint cliente_username_uk unique,
   password varchar2(40) not null
);

prompt creando tabla "Donativo"

drop table DONATIVO cascade constraint;
create table DONATIVO(
  donativo_id number(10,0) constraint donativo_pk primary key,
  fecha date not null,
  monto number(7,2) not null,
  cliente_id number(10,0) constraint donativo_cliente_id_fk 
  references cliente(cliente_id)
);

prompt creando tabla "Origen Mascota"

drop table ORIGEN_MASCOTA cascade constraint;
create table ORIGEN_MASCOTA(
  origen_mascota_id number(10,0) constraint origen_mascota_pk primary key,
  clave varchar2(5) constraint origen_mascota_clave_uk unique,
  descripcion varchar2(200) not null
);

prompt creando "TIPO_MASCOTA"

drop table TIPO_MASCOTA cascade constraint;
create table TIPO_MASCOTA(
  tipo_mascota_id number(10,0) constraint tipo_mascota_pk primary key,
  tipo varchar2(40) not null,
  subcategoria varchar2(40) not null,
  nivel_cuidado number(1,0) not null
);

prompt creando tabla "Status"

drop table STATUS cascade constraint;
create table STATUS(
  status_id number(1,0) constraint status_pk primary key,
  estado varchar2(40) not null
);

prompt creando tabla "Lomitos"
drop table MASCOTA cascade constraint;
create table MASCOTA(
  mascota_id number(10,0) constraint mascota_pk primary key,
  mascota_mama number(10,0) null 
  constraint mascota_mascota_mama_fk references mascota(mascota_id),
  mascota_papa number(10,0) null
  constraint mascota_mascota_papa_fk references mascota(mascota_id),
  fecha_status date not null,
  nombre varchar2(50) not null,
  folio varchar2(8) not null constraint mascota_folio_uk unique,
  fecha_ingreso date not null,
  fecha_nacimiento date not null,
  causa_muerte varchar2(200) null,
  tipo_mascota_id number(10,0) constraint mascota_tipo_mascota_id_fk
  references tipo_mascota(tipo_mascota_id),
  origen_mascota_id number(10,0) constraint mascota_origen_mascota_id_fk
  references origen_mascota(origen_mascota_id),
  centro_operativo_id number(5,0) null 
  constraint mascota_centro_operativo_id_fk 
  references refugio(centro_operativo_id),
  status_id number(1,0) constraint mascota_status_id_fk references
  status(status_id),
  cliente_id number(10,0) null constraint mascota_cliente_id_fk
  references cliente(cliente_id)
);


prompt creando tabla "HISTORIAL_STATUS"

drop table historial_status cascade constraint;
create table HISTORIAL_STATUS(
	historial_status_id number(10,0) constraint histotial_status_pk primary key,
	fecha_status date not null,
	status_id number(1,0) constraint historial_status_status_id_fk
	references status(status_id),
	mascota_id number(10,0) constraint historial_status_mascota_id_fk
	references mascota(mascota_id)
);


prompt creando tabla "Revision_mascota_adoptada"
drop table revision_mascota_adoptada cascade constraint;
create table REVISION_MASCOTA_ADOPTADA(
  revision_mascota_adoptada_id number(10,0) 
  constraint Revision_mascota_adoptada_pk primary key,
  numero_revision number(10,0) not null,
  fecha_revision date not null,
  calificacion_salud number(2,0) not null,
  costo number(7,2) not null,
  observaciones varchar2(500) not null,
  mascota_id number(10,0) constraint revision_mascota_adoptada_mascota_id_fk
  references mascota(mascota_id),
  centro_operativo_id number(10,0)
  constraint revision_mascota_adoptada_centro_operativo_id_fk
  references clinica(centro_operativo_id)
);

prompt creando tabla "Revision_mascota_refugio"
drop table REVISION_MASCOTA_REFUGIO cascade constraint;
create table REVISION_MASCOTA_REFUGIO(
  revision_mascota_refugio_id number(10,0) 
  constraint revision_mascota_refugio_pk primary key,
  diagnostico varchar2(500) not null,
  foto blob not null,
  mascota_id number(10,0) not null
  constraint revision_mascota_refugio_mascota_id_fk
  references mascota(mascota_id),
  empleado_id number(10,0) not null
  constraint revision_mascota_refugio_empleado_id_fk
  references empleado(empleado_id),
  fecha_revision date not null
);

prompt creando tabla "Interesado_mascota"
drop table interesado_mascota cascade constraint;
create table interesado_mascota(
  cliente_id number(10,0) not null,
  mascota_id number(10,0) not null,
  fecha_seleccion date,
  constraint interesado_mascota_pk
  primary key(cliente_id,mascota_id),
  constraint interesado_mascota_cliente_id_fk 
  foreign key(cliente_id) references cliente(cliente_id),
  constraint interesado_mascota_mascota_id_fk 
  foreign key(mascota_id) references mascota(mascota_id)
);

prompt creando tabla "operaciones_centro_operativo"
drop table operaciones_centro_operativo cascade constraint;
create table operaciones_centro_operativo(
  operaciones_centro_operativo_id number (10,0) constraint 
  operaciones_centro_operativo_pk primary key,
  usuario varchar2(80),
  fecha_accion date not null,
  empleado_antiguo number(10,0) constraint
  operaciones_centro_operativo_empleado_antiguo_fk
  references empleado(empleado_id),
  empleado_nuevo number(10,0) constraint
  operaciones_centro_operativo_empleado_nuevo_fk
  references empleado(empleado_id),
  otros_cambios varchar2(4000) not null
);

prompt creando tabla "empleado_log"
drop table empleado_log cascade constraint;
create table empleado_log(
  empleado_log_id number(10,0) constraint empleado_log_fk primary key,
  empleado_id number(10,0) constraint empleado_log_empleado_id_fk
  references empleado(empleado_id),
  sueldo_anterior number(8,2) not null,
  sueldo_nuevo number(8,2) not null,
  es_veterinario number(1,0) not null,
  es_administrativo number(1,0) not null,
  fecha_actualizacion date not null,
  usuario varchar2(30) not null
);

prompt creando tabla "motivo rechazo"
drop table motivo_rechazo cascade constraint;
create table motivo_rechazo(
  motivo_rechazo_id number(10,0) constraint motivo_rechazo_pk primary key,
  cliente_id number(10,0) not null constraint motivo_rechazo_cliente_id_fk
  references cliente(cliente_id),
  fecha_rechazo date not null,
  mascota_id number(10,0) not null constraint motivo_rechazo_mascota_id_fk
  references mascota(mascota_id),
  observaciones varchar2(4000) not null
);

prompt creando tabla "notificacion revision cliente"
drop table notificacion_revision_cliente cascade constraint;
create table notificacion_revision_cliente(
  notificacion_revision_cliente_id number(10,0) constraint
  notificacion_revision_cliente_pk primary key,
  revision_mascota_adoptada_id number(10,0) constraint
  notificacion_revision_cliente_revision_mascota_adoptada_fk
  references revision_mascota_adoptada(revision_mascota_adoptada_id),
  mascota_id number(10,0) constraint 
  notificacion_revision_cliente_mascota_id_fk references mascota(mascota_id),
  calificacion_salud number(2,0) not null,
  status_actual_id number(10,0) constraint 
  notificacion_revision_cliente_status_actual_id_fk references status(status_id),
  observaciones varchar2(500) not null,
  fecha_ultima_revision date not null
);

prompt creando tabla "notificacion revision refugio"
drop table notificacion_revision_refugio cascade constraint;
create table notificacion_revision_refugio(
  notificacion_revision_refugio_id number(10,0) constraint 
  notificacion_revision_refugio_pk primary key,
  revision_mascota_refugio_id number(10,0) constraint
  notificacion_revision_refugio_revision_mascota_refugio_id_fk
  references REVISION_MASCOTA_REFUGIO(revision_mascota_refugio_id),
  mascota_id number(10,0) constraint 
  notificacion_revision_refugio_mascota_id_fk references mascota(mascota_id),
  veterinario_id number(10,0) constraint 
  notificacion_revision_refugio_veterinario_id_fk 
  references empleado(empleado_id),
  diagnostico_pasado varchar2(500) not null,
  status_actual_id number(10,0) constraint 
  notificacion_revision_refugio_status_actual_id_fk references status(status_id),
  fecha_ultima_revision date not null
);