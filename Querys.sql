-- Consultas básicas a las tablas
select *from empresa e ;

select *from trabajadores t ;

select trabajadores.nombre, ciudades.nombreciudad, empresa.nombreempresa from trabajadores inner join empresa on trabajadores.empresa = empresa.idempresa 
inner join ciudades on trabajadores.ciudad = ciudades.idciudad;

-- Creando una tabla temporal
drop table if exists prueba;
select  trabajadores.nombre, trabajadores.sueldodevengado, empresa.nombreempresa into
prueba from trabajadores inner join empresa on trabajadores.empresa = empresa.idempresa;

select *from prueba;

-- Modificando el tipo de dato de la columna sueldodevengado
alter table trabajadores alter column sueldodevengado set data type FLOAT;

-- Consultas
-- Consultar el sueldo promedio, agrupar por ciudad y cargo
select ciudad, cargo, AVG(sueldodevengado) as sueldopromedio from trabajadores group by ciudad, cargo
order by ciudad;

-- Función que retorna una consulta, dependiendo de los parametros que reciba en modalidadtrabajo
drop function if exists Usuarios_ModalidadTrabajo;
create function Usuarios_ModalidadTrabajo(ModoTrabajo VARCHAR(15))
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

select t.nombre, t.cargo, t.sueldodevengado, e.nombreempresa, e.categoriaempresa from trabajadores t 
inner join empresa e on t.empresa = e.idempresa;

-- Función que trae registros dependiendo del tipo de empresa
create or replace function registros_tipo_empresa (tipo_empresa VARCHAR(15))
returns table (nombre VARCHAR(30), cargo VARCHAR(30), sueldodevengado FLOAT, 
	nombreempresa VARCHAR(30), categoriaempresa VARCHAR(30))
as $$
begin
	return query
	select t.nombre, t.cargo, t.sueldodevengado, e.nombreempresa, e.categoriaempresa from trabajadores t 
	inner join empresa e on t.empresa = e.idempresa and e.categoriaempresa 
	ilike '%' || tipo_empresa || '%';
end;
$$ language plpgsql;

select registros_tipo_empresa('Tec');

create or replace function trae_ocupaciones (ocupacion VARCHAR(30))
returns table (nombre VARCHAR(30), cargo VARCHAR(30), nombreempresa VARCHAR(30), sueldodevengado FLOAT)
as $$
begin
	return query
	select t.nombre, t.cargo, e.nombreempresa, t.sueldodevengado from trabajadores t inner join
	empresa e on t.empresa = e.idempresa and t.cargo ilike '%' || ocupacion || '%';
end;
$$ language plpgsql;

select trae_ocupaciones ('ingeniero');

-- Creación de vistas
drop view if exists Filtros;
create view Filtros as select *from trabajadores where 
modalidadtrabajo = 'Remoto' and ciudad = 'Bogota D.C';

select * from Filtros;

create table respaldo(
	idtrabajador int,
	nombre varchar(30),
	cargo varchar(30),
);