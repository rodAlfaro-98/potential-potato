--@Autor(es):       (Alfaro) (Alfaro Alejandro Esaú|Domínguez Rodrigo)
--@Fecha Creación:  04/01/2022
--@Descripción:     Script de creación de la carga centro operativo del proyecto de Pet Home



declare
    v_rfc varchar2(20);
    v_nombre_responsable_legar varchar2(120);
    type v_nombre is varray(11) of varchar2(500);
    nombres v_nombre;
    v_nom varchar2(500);
    type v_apellido_paterno is varray(11) of varchar2(500);
    app v_apellido_paterno;
    type v_apellido_materno is varray(11) of varchar2(500);
    apm v_apellido_materno;
    v_ap_paterno varchar2(40);
    v_ap_materno varchar2(40);

begin
    nombres := v_nombre('Juan','Pedro','Pablo','Hugo','Luis','Maria','Fernanda','Valeria','Francisca','Alberto');
    app := v_apellido_paterno('Alfaro','Gutierrez','Perez','Lopez','Garcia','Hernandez','Robledo','Martinez','Dominguez','Todoroki');
    apm := v_apellido_materno('Alfaro','Gutierrez','Perez','Lopez','Garcia','Hernandez','Robledo','Martinez','Dominguez','Todoroki');
    for i in 1 .. 100 loop
        v_nombre_responsable_legar := nombres(mod(i,9)+1)||' '||app(mod(i,8)+1)||' '||apm(mod(i,10)+1);
        v_rfc := 'ABCD000101HKS'||i;
        if(mod(i,4) = 2) then
            insert into OFICINA(centro_operativo_id,rfc,firma_electronica,
                nombre_responsable_legal)
            values(i,v_rfc,empty_blob(),v_nombre_responsable_legar);
        end if;
    end loop;
end;
/
commit;