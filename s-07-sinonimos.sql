--@Autor(es):       (Alfaro) (Alfaro Alejandro Esaú|Domínguez Rodrigo)
--@Fecha Creación:  02/01/2022
--@Descripción:     Script de creación de los sininimos del proyecto de Pet Home


promp Iniciando como aa_proy_admin
connect aa_proy_admin/alfaro

prompt Otorgando permisos de consulta de admin a invitado
grant select on cliente to aa_proy_invitado;
grant select on mascota to aa_proy_invitado;
grant select on revision_mascota_adoptada to aa_proy_invitado;


prompt Iniciando como aa_proy_invitado
connect aa_proy_invitado/alfaro


prompt creando sinonimo privado de cliente

create or replace synonym s_cliente for aa_proy_admin.cliente;

prompt creando sinonimo privado de mascota
create or replace synonym s_mascota for aa_proy_admin.mascota;

prompt creando sinonimo privado de revision_mascota_adoptada
create or replace synonym s_revision_mascota_adoptada 
for aa_proy_admin.revision_mascota_adoptada;