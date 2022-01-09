
declare

begin
update oficina set firma_electronica = fx_get_firma_electronica('fimra_electronica_1')
where centro_operativo_id = 2;
commit;
end;
/
show errors;