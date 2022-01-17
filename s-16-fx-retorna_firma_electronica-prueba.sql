
--@Autor(es):       (Alfaro) (Alfaro Alejandro Esaú|Domínguez Rodrigo)
--@Fecha Creación:  08/01/2022
--@Descripción:     Script de prueba de funcion fx-retorna-firma
declare

begin
update oficina set firma_electronica = 
fx_get_firma_electronica('firma_electronica_1')
where centro_operativo_id = 2;
commit;
end;
/
show errors;