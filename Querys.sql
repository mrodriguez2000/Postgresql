-- Consultas básicas a las tablas
select *from empresa e ;

select *from trabajadores t;

-- Modificando el tipo de dato de la columna sueldodevengado
alter table trabajadores alter column sueldodevengado set data type FLOAT;

-- Función que retorna una consulta, dependiendo de los parametros que reciba en modalidadtrabajo
create or replace function Usuarios_ModalidadTrabajo(ModoTrabajo VARCHAR(15))
returns table (nombre VARCHAR(30), cargo VARCHAR(30), modalidadtrabajo VARCHAR(30), sueldodevengado FLOAT)
as $$
begin
	return query
	select t.nombre, t.cargo, t.modalidadtrabajo, t.sueldodevengado from trabajadores t
	where t.modalidadtrabajo LIKE CONCAT('%', ModoTrabajo, '%');
end;
$$ language plpgsql;

-- Llamando la función
select * from public.usuarios_modalidadtrabajo('Rem');