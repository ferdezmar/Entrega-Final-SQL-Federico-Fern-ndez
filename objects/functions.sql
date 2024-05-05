USE venta_libros;

DROP FUNCTION IF EXISTS contar_ventas_cliente;
DROP FUNCTION IF EXISTS cantidad_libros_por_sucursal;
DROP FUNCTION IF EXISTS contar_ventas_empleado;

-- Contar Ventas por cliente
-- Función para contar las ventas de un cliente en un intervalo de tiempo.

DELIMITER //

CREATE FUNCTION contar_ventas_cliente(cliente_id INT, fecha_inicio DATETIME, fecha_fin DATETIME) RETURNS INT
READS SQL DATA
BEGIN
    DECLARE ventas_count INT;
    
    SELECT COUNT(*) INTO ventas_count
    FROM VENTA
    WHERE IDCLIENTE = cliente_id
    AND FECHA >= fecha_inicio
    AND FECHA <= fecha_fin;
    
    RETURN ventas_count;
END //

DELIMITER ;


-- Libros por sucursal
-- Función para obtener la cantidad de libros por cada sucursal.

DELIMITER //

CREATE FUNCTION cantidad_libros_por_sucursal(sucursal_id INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE libros_count INT;
    
    SELECT COUNT(*) INTO libros_count
    FROM LIBRO
    WHERE IDSUCURSAL = sucursal_id;
    
    RETURN libros_count;
END //

DELIMITER ;


-- Ventas por empleado
-- Función para contar las ventas realizadas por un empleado:

DELIMITER //

CREATE FUNCTION contar_ventas_empleado (empleado_id INT) RETURNS INT
READS SQL DATA
BEGIN
    DECLARE ventas_empleado_count INT;
    
    SELECT COUNT(*) INTO ventas_empleado_count
    FROM VENTA
    WHERE IDEMPLEADO = empleado_id;
    
    RETURN ventas_empleado_count;
END //

DELIMITER ;

