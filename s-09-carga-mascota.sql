declare
    v_fecha_status date;
    type v_nombre is varray(21) of varchar2(50);
    nombres v_nombre;
    v_folio varchar2(8);
    v_fecha_ingreso date;
    v_fecha_nacimiento date;
    v_tipo_masota_id number(10,0);
    v_origen_mascota_id number(1,0);
    v_centro_operativo_id number(5,0);
    v_status_id number(1,0);
    v_cliente_id number(10,0);
    v_papa_id number(10,0);
    v_mama_id number(10,0);
    v_nom varchar2(40);
begin
    nombres := v_nombre('Firulais Jonson','Caramelo','Tianguis','Bigote','Chilaquil','Patitas','Masky','Namux','Nell','Ro','Luna','Nito','Nala','Aang','Zuko','Soka','Toph','Krypto','Katara','Suki');
    for i in 1 .. 100 loop
        v_nom := nombres(round(dbms_random.value(1,19)));
        v_fecha_ingreso := sysdate - (round(dbms_random.value(1,100)));
        v_fecha_status := v_fecha_ingreso + (round(dbms_random.value(1,100)));
        v_fecha_nacimiento := v_fecha_ingreso - (round(dbms_random.value(1,100)));
        v_status_id := round(dbms_random.value(1,5));
        v_origen_mascota_id := round(dbms_random.value(1,3));
        v_folio := substr(1,4)||i;
        if(v_origen_mascota_id = 3) then
            v_papa_id := round(dbms_random.value(1,i));
            v_mama_id := round(dbms_random.value(1,i));
            v_centro_operativo_id := 4*round(dbms_random.value(1,5));
        else
            v_papa_id := null;
            v_mama_id := null;
            v_centro_operativo_id := null;
        end if;
        if(mod(v_status_id,5) = 0 or mod(v_status_id,5) = 4 or mod(v_status_id,5) = 3)then
            v_cliente_id := i;
        else    
            v_cliente_id := null;
        end if;
        v_tipo_masota_id := round(dbms_random.value(1,47));
        insert into mascota (mascota_id,causa_muerte,mascota_mama, 
            mascota_papa,fecha_status,nombre,folio,fecha_ingreso,
            fecha_nacimiento,tipo_mascota_id,origen_mascota_id,centro_operativo_id,
            status_id,cliente_id)
        values(mascota_seq.nextval,null,v_mama_id,v_papa_id,v_fecha_status,v_nom,v_folio,v_fecha_ingreso,
            v_fecha_nacimiento,v_tipo_masota_id,v_origen_mascota_id,v_centro_operativo_id,
            v_status_id,v_cliente_id);
        insert into historial_status(historial_status_id,fecha_status,status_id,mascota_id)
        values(historial_status_seq.nextval,v_fecha_status,v_status_id,i);
    end loop;
end;
/


insert into mascota (mascota_id,causa_muerte,mascota_mama, 
    mascota_papa,fecha_status,nombre,folio,fecha_ingreso,
    fecha_nacimiento,tipo_mascota_id,origen_mascota_id,centro_operativo_id,
    status_id,cliente_id)
values(mascota_seq.nextval,'moquillo',null,null,
sysdate - 3,'Bolillo','MFET78S6',sysdate-1095,sysdate-4745,round(dbms_random.value(1,47)),
round(dbms_random.value(1,2)),null,6,null);

insert into mascota (mascota_id,causa_muerte,mascota_mama, 
    mascota_papa,fecha_status,nombre,folio,fecha_ingreso,
    fecha_nacimiento,tipo_mascota_id,origen_mascota_id,centro_operativo_id,
    status_id,cliente_id)
values(mascota_seq.nextval,'moquillo',null,null,
sysdate - 3,'MArgarita','MLKPS456',sysdate-1295,sysdate-3450,round(dbms_random.value(1,47)),
round(dbms_random.value(1,2)),null,6,null);

insert into mascota (mascota_id,causa_muerte,mascota_mama, 
    mascota_papa,fecha_status,nombre,folio,fecha_ingreso,
    fecha_nacimiento,tipo_mascota_id,origen_mascota_id,centro_operativo_id,
    status_id,cliente_id)
values(mascota_seq.nextval,'moquillo',null,null,
sysdate - 3,'MArgarita','MLKPS457',sysdate-1295,sysdate-3450,round(dbms_random.value(1,47)),
round(dbms_random.value(1,2)),null,6,null);

insert into mascota (mascota_id,causa_muerte,mascota_mama, 
    mascota_papa,fecha_status,nombre,folio,fecha_ingreso,
    fecha_nacimiento,tipo_mascota_id,origen_mascota_id,centro_operativo_id,
    status_id,cliente_id)
values(mascota_seq.nextval,'indigestion',null,null,
sysdate - 3,'Limon','LMSW1235',sysdate-1346,sysdate-2450,round(dbms_random.value(1,47)),
round(dbms_random.value(1,2)),null,6,null);

insert into mascota (mascota_id,causa_muerte,mascota_mama, 
    mascota_papa,fecha_status,nombre,folio,fecha_ingreso,
    fecha_nacimiento,tipo_mascota_id,origen_mascota_id,centro_operativo_id,
    status_id,cliente_id)
values(mascota_seq.nextval,'indigestion',null,null,
sysdate - 3,'Carnalito','CNLTK123',sysdate-1595,sysdate-3050,round(dbms_random.value(1,47)),
round(dbms_random.value(1,2)),null,6,null);

insert into mascota (mascota_id,causa_muerte,mascota_mama, 
    mascota_papa,fecha_status,nombre,folio,fecha_ingreso,
    fecha_nacimiento,tipo_mascota_id,origen_mascota_id,centro_operativo_id,
    status_id,cliente_id)
values(mascota_seq.nextval,'Rabia',null,null,
sysdate - 3,'Tortas','TTTTK123',sysdate-1285,sysdate-2650,round(dbms_random.value(1,47)),
round(dbms_random.value(1,2)),null,6,null);


insert into mascota (mascota_id,causa_muerte,mascota_mama, 
    mascota_papa,fecha_status,nombre,folio,fecha_ingreso,
    fecha_nacimiento,tipo_mascota_id,origen_mascota_id,centro_operativo_id,
    status_id,cliente_id)
values(mascota_seq.nextval,'Rabia',null,null,
sysdate - 3,'Mimoso','DFMSJ123',sysdate-1495,sysdate-3150,round(dbms_random.value(1,47)),
round(dbms_random.value(1,2)),null,6,null);

commit;