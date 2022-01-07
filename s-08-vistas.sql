--@Autor(es):       (Alfaro) (Alfaro Alejandro Esaú|Domínguez Rodrigo)
--@Fecha Creación:  02/11/2022
--@Descripción:     Script de creación de las vistas del proyecto de Pet Home



create or replace view v_registro_mascota(
  mascota_id,nombre,nivel_cuidado,estado,nombre_papa,nombre_mama,tipo_mascota_papa,
  tipo_mascota_mama,subcategoria_papa,subcategoria_mama 
) as select m.mascota_id, m.nombre, t.nivel_cuidado,s.estado, nvl(mp.nombre,
  'Mascota no nacio en refugio'), nvl(mm.nombre,'Mascota no nacio en refugio')
  , tp.tipo, tm.tipo, tp.subcategoria, tm.subcategoria
from mascota m
join tipo_mascota t 
on m.tipo_mascota_id = t.tipo_mascota_id
join status s 
on m.status_id = s.status_id
left join mascota mp
on m.mascota_papa = mp.mascota_id 
left join mascota mm
on m.mascota_mama = mm.mascota_id
left join tipo_mascota tp 
on mp.tipo_mascota_id = tp.tipo_mascota_id
left join tipo_mascota tm
on mm.tipo_mascota_id = tm.tipo_mascota_id;

create or replace view v_ultima_revision_mascota_adoptada(
    numero_revision,fecha_revision,calificacion_salud,obervaciones,mascota_id,
    nombre_mascota,cliente_id,nombre_cliente,apellido_paterno_cliente,
    apellido_materno_cliente
) as select r.numero_revision, r.fecha_revision, r.calificacion_salud, 
  r.observaciones, m.mascota_id, m.nombre, c.cliente_id, c.nombre,
  c.apellido_paterno, c.apellido_materno
from revision_mascota_adoptada r
join mascota m 
on r.mascota_id = m.mascota_id
join cliente c 
on m.cliente_id = c.cliente_id
where r.fecha_revision = (
  select ultima_revision
  from(
    select mascota_id, max(fecha_revision) ultima_revision
    from revision_mascota_adoptada
    group by (mascota_id)
  ) where mascota_id = m.mascota_id
);

create or replace view v_titulos_empleados(
		empleado_id,es_gerente,es_veterinario,es_administrativo,
		nombre_titulo,fecha_titulacion
) as select e.empleado_id,e.es_gerente,e.es_veterinario,e.es_administrativo,
  t.nombre_titulo,t.fecha_titulacion
from empleado e join titulo t
on e.empleado_id = t.empleado_id
order by 
 es_gerente,
 es_veterinario,
 es_administrativo;