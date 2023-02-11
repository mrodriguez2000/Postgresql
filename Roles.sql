create role Usuario01 with
	password 'Usuario01'
	login
	nosuperuser
	nocreatedb
	nocreaterole
	noreplication;

-- Otorgar permiso a usuario para que pueda hacer todas las operaciones CRUD
grant select, insert, update on all tables in schema public to Usuario01;

-- Quitar al usuario todos los permisos
revoke all on table empresa from Usuario01;
revoke all on table trabajadores from Usuario01;

-- Eliminar el rol
drop role Usuario01;