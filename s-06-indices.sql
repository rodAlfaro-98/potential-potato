--@Autor(es):       (Alfaro) (Alfaro Alejandro Esaú|Domínguez Rodrigo)
--@Fecha Creación:  03/11/2022
--@Descripción:     Script de creación de los índices del proyecto de Pet Home

Prompt creando indice del username del cliente
create unique index cliente_username_iuk on cliente(username);
--Prompt creando indice unique para Empleado- email
--create unique index empleado_email_iuk on empleado(email);
--Pompt creando indice uniqe para empleado - curp
--create unique index empleado_curp_iuk on empleado(curp);

--Prompt creando indice rfc oficina
--create unique index oficina_rfc_iuk on oficina(rfc);

--Prompt creando indice numero_registro refugio
--create unique index regufio_numero_registro_iuk on refugio(numero_registro);

Prompt creando indice nombre centro_operativo
--drop index centro_operativo_nombre_iuk;
create unique index centro_operativo_nombre_iuk on centro_operativo(lower(nombre));

Prompt creando indice nombre mascota
--drop index mascota_nombre_ix;
create index mascota_nombre_ix  on  mascota(lower(nombre));

--Prompt creando indice compuesto direccion_web-centro_operativo_id
--create index direccion_web_refugio_centro_operativo_iuk 
--on direccion_web_refugio(centro_operativo_id,direccion_web);

Prompt creando indice compuesto empleado_nombre_apellido_paterno_apellido_materno_ix
--drop index empleado_nombres_apellido_paterno_apellido_materno_ix;
create index empleado_nombres_apellido_paterno_apellido_materno_ix
on empleado(nombres,apellido_paterno,apellido_materno);

Prompt creando indice de donativos por fecha
--drop index donativo_fecha_ix;
create index donativo_fecha_ix on donativo(to_char(fecha,'dd/mm/yyyy'));

