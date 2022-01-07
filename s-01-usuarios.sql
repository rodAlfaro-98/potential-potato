--@Autor(es):       (Alfaro) (Alfaro Alejandro Esaú|Domínguez Rodrigo)
--@Fecha Creación:  30/12/2021
--@Descripción:     Script de creación de los usuarios del proyecto de Pet Home

prompt Creando usuario Administrador
create user aa_proy_admin identified by alfaro quota unlimited on users;
grant create session, create table, create view, create sequence,
  create procedure, create trigger to aa_proy_admin;

prompt Creando usuario Invitado
create user aa_proy_invitado identified by alfaro quota unlimited on users;
grant create session, create synonym to aa_proy_invitado;

prompt Iniciando con usuario Admin

connect aa_proy_admin/alfaro

prompt Creando TABLAS


promtp CREACION DE TABLAS EXITOSA