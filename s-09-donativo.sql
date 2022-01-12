declare
  v_actual_id number(10,0);
  v_next_id number(10,0);
  v_fecha date;
  v_monto number(7,2);
  v_cliente number(10,0);
begin
  for i in 1 .. 200 loop
	  v_fecha := sysdate - i;
    v_monto := i *100;
    v_cliente := round(dbms_random.value(1,100));
    dbms_output.put_line(v_fecha||','||v_monto||','||v_cliente);
    insert into donativo(donativo_id,fecha,monto,cliente_id) values(donativo_seq.nextval,v_fecha,v_monto,v_cliente);
  end loop;
end;
/