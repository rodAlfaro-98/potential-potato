--@Autor(es):       (Alfaro) (Alfaro Alejandro Esaú|Domínguez Rodrigo)
--@Fecha Creación:  05/01/2022
--@Descripción:     Script de consultas del proyecto de Pet Home

--Obtenemos ID de los clientes que no han adoptado lomitos
select cliente_id from cliente

minus

(select cliente_id from cliente

intersect 

select cliente_id from mascota);

--Permite saber qué lomitos adoptados han tenido más complicaciones
select m.mascota_id,c.cliente_id,m.nombre,m.folio,c.nombre "NOMBRE CLIENTE" ,
  c.apellido_paterno, c.apellido_materno,q1.gasto_total
from mascota m 
join cliente c 
on c.cliente_id = m.cliente_id
join (select mascota_id,sum(costo) gasto_total
from REVISION_MASCOTA_ADOPTADA
group by mascota_id) q1
on m.mascota_id = q1.mascota_id;

--Permite saber los datos del perro que está siendo elegido por el cliente
select cim.cliente_id, cim.mascota_id, cim.fecha_seleccion, m.nombre, m.folio
from cliente_interes_mascota_temp_commit cim
join mascota m 
on cim.mascota_id = m.mascota_id;

--Muestra un registro completo de los empleados con sus datos de titulación y el centro
--operativo al que pertenecen dependiendo de cual pertenezcan muestra la capcidad maxima,
--hora_inico,hora_fin o el nombre del responsable legal
select e.empleado_id,e.es_gerente,e.es_veterinario,e.es_administrativo,
	e.nombres,e.apellido_paterno,e.apellido_paterno,t.nombre_titulo,t.fecha_titulacion,
	c.centro_operativo_id,c.es_refugio,c.es_clinica,c.es_oficina,c.nombre,r.capacidad_maxima,
	cl.telefono_atencion_cliente,cl.telefono_emergencias,o.nombre_responsable_legal
from empleado e join titulo t
on e.empleado_id = t.empleado_id 
join centro_operativo c
on e.empleado_id = c.empleado_id
left join refugio r 
on c.centro_operativo_id = r.centro_operativo_id
left join clinica cl
on c.centro_operativo_id = cl.centro_operativo_id
left join oficiona o
on c.centro_operativo_id = o.centro_operativo_id;

--Informe de cliente con sus donativos y en caso de tener mascota mostrar nombre y id
select cliente_id,c.nombre,c.username,c.nombre "nombre_cliente",
	d.donativo_id,d.fecha "fecha_donativo",d.monto,m.nombre "nombre_mascota",m.mascota_id
from cliente c natural join donativo d
left join mascota m using(cliente_id);

--Monto total de donativos por cliente hechos en 2021
select c.cliente_id,sum(d.monto) "total_donativos",
  count(c.cliente_id) "numero donativos"
	from cliente c join donativo d 
	on c.cliente_id = d.cliente_id
where to_char(d.fecha,'yyyy') = '2021'
group by c.cliente_id;

--Consulta tabla externa
--Muestra los id que concuerdan tanto en la externa como en la tabla dentro de la base de cliente
--De estos clientes se muestra el id de su mascota su nombre , su tipo y subcategoria
--Además de en caso de tener revisiones y ser adoptadas muestra el numero de revision y las observaciones
--si es revision de refugio el diagnostico
--De todas las mascotas 'ENFERMA'
select c.cliente_id,m.mascota_id,m.nombre,t.tipo,t.subcategoria,
	ra.numero_revision,ra.calificacion_salud,ra.observaciones,rr.diagnostico
from cliente c join cliente_ext ce
on c.cliente_id = ce.cliente_id
join mascota m 
on m.cliente_id = c.cliente_id
join tipo_mascota t
on m.tipo_mascota_id = t.tipo_mascota_id
join status s 
on s.status_id = m.status_id
left join revision_mascota_adoptada ra
on ra.mascota_id = m.mascota_id
left join revision_mascota_refugio rr
on rr.mascota_id = m.mascota_id
where s.estado = 'ENFERMA';



--Consulta vista (Permite ver el registro de las mascotas que no han sido adoptadas)
select vr.mascota_id,vr.nombre,vr.nivel_cuidado,vr.estado,vr.nombre_papa,
  vr.nombre_mama,vr.tipo_mascota_papa,vr.tipo_mascota_mama,vr.subcategoria_papa
  ,vr.subcategoria_mama  from v_registro_mascota vr
join mascota m 
on vr.mascota_id = m.mascota_id
where m.status_id <=3;

connect aa_proy_invitado/alfaro;
select sc.cliente_id, sc.nombre "NOMBRE CLIENTE", sc.apellido_paterno, 
  sc.apellido_materno, sm.nombre "NOMBRE MASCOTA", sm.folio
from s_cliente sc
right join s_mascota sm
on sc.cliente_id = sm.cliente_id;