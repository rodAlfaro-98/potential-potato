--@Autor(es):       (Alfaro) (Alfaro Alejandro Esaú|Domínguez Rodrigo)
--@Fecha Creación:  07/01/2022
--@Descripción:     Script de función que actualiza el logo de un refugio (PRUEBA)
set serveroutput on

declare
    v_exitoso varchar2(80);
begin
    v_exitoso := fx_actualiza_logo(3,20);
    if(v_exitoso = 1) then
        dbms_output.put_line('Se actualizaron de manera exitosa los registros');
    end if;
    commit;
end;
/ 
--show errors;