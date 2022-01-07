--@Autor(es):       (Alfaro) (Alfaro Alejandro Esaú|Domínguez Rodrigo)
--@Fecha Creación:  05/01/2022
--@Descripción:     Script de prueba de procedimiento que 
--identifica a las mascotas que ya requieren una nueva revisión

declare

begin
    p_notificacion_revision_mascota(sysdate + 15);
commit;
end;
/
select * from notificacion_revision_cliente;
select * from notificacion_revision_refugio;