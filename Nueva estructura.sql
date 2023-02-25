create table Ciudades(
	IdCiudad VARCHAR(3) not null primary key,
	NombreCiudad VARCHAR(30) not null,
	Pais VARCHAR(30)
);

-- Insertando datos en la tabla ciudades
insert into ciudades
(idciudad, nombreciudad)
values
('BOG', 'Bogota'),
('BUC', 'Bucaramanga'),
('CAL', 'Cali'),
('BAQ', 'Barranquilla'),
('MED', 'Medellin');

update ciudades set pais = 'Colombia';

select *from ciudades c;

-- Creando clave foranea para relacionar la tabla ciudades con trabajadores
alter table trabajadores add constraint FK_Ciudades foreign key(ciudad) references ciudades(idciudad);

-- Añadiendo una nueva columna a la tabla de trabajadores
alter table trabajadores add direccion VARCHAR(30);