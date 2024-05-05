USE mysql;

CREATE USER IF NOT EXISTS 'admin'@'%' IDENTIFIED BY 'password';

GRANT ALL PRIVILEGES ON venta_libros.* TO 'admin'@'%' WITH GRANT OPTION;

FLUSH PRIVILEGES;

USE venta_libros;

-- CREACIÓN DE ROLES
CREATE ROLE role_select_vistas;
CREATE ROLE role_crud_sucursales;

-- ASIGNACIÓN DE PRIVILEGIOS AL ROL role_select_vistas
GRANT SELECT ON CLIENTE TO role_select_vistas;
GRANT SELECT ON GERENTE TO role_select_vistas;
GRANT SELECT ON TIPOVENTA TO role_select_vistas;
GRANT SELECT ON EMPLEADO TO role_select_vistas;
GRANT SELECT ON SUCURSAL TO role_select_vistas;
GRANT SELECT ON LIBRO TO role_select_vistas;
GRANT SELECT ON VENTA TO role_select_vistas;

-- ASIGNACIÓN DE PRIVILEGIOS AL ROL role_crud_sucursales
GRANT ALL PRIVILEGES ON SUCURSAL TO role_crud_sucursales;
GRANT ALL PRIVILEGES ON LIBRO TO role_crud_sucursales;
GRANT ALL PRIVILEGES ON VENTA TO role_crud_sucursales;
GRANT ALL PRIVILEGES ON TIPOVENTA TO role_crud_sucursales;
GRANT ALL PRIVILEGES ON GERENTE TO role_crud_sucursales;

CREATE USER 'empleado'@'%' IDENTIFIED BY 'password_empleado';
GRANT role_select_vistas TO 'empleado'@'%';

CREATE USER 'gerente'@'%' IDENTIFIED BY 'password_gerente';
GRANT role_crud_sucursales TO 'gerente'@'%';

FLUSH PRIVILEGES;