USE venta_libros;

DROP PROCEDURE IF EXISTS crear_cliente;
DROP PROCEDURE IF EXISTS crear_empleado;
DROP PROCEDURE IF EXISTS registrar_detalle_venta;
DROP PROCEDURE IF EXISTS registrar_pago;

-- Crear Cliente
-- Este procedimiento crea un nuevo cliente en la base de datos

DELIMITER //

CREATE PROCEDURE crear_cliente(
    IN p_nombre VARCHAR(100),
    IN p_telefono VARCHAR(20),
    IN p_correo VARCHAR(100),
    IN p_fecha_alta DATETIME,
    IN p_status BOOLEAN
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT ">> error_message: Cliente no insertado correctamente se hace un Rollback" AS Message;
    END;

    START TRANSACTION;

    INSERT INTO venta_libros.CLIENTE 
        (NOMBRE, TELEFONO, CORREO, FECHA_ALTA, STATUS)
    VALUES 
        (p_nombre, p_telefono, p_correo, p_fecha_alta, p_status);
    
    COMMIT;
    SELECT "Cliente insertado exitosamente" AS Message;

END //

DELIMITER ;

-- Crear Empleado
-- Este procedimiento crea un nuevo empleado en la base de datos, verificando si existe la sucursal especificada.

DELIMITER //

CREATE PROCEDURE crear_empleado(
    IN p_nombre VARCHAR(100),
    IN p_telefono VARCHAR(20),
    IN p_correo VARCHAR(100),
    IN p_id_sucursal INT
)
BEGIN
    DECLARE sucursal_count INT;
    
    -- Verificar si la sucursal existe
    SELECT COUNT(*) INTO sucursal_count
    FROM SUCURSAL
    WHERE IDSUCURSAL = p_id_sucursal;
    
    -- Si la sucursal existe, insertar el empleado
    IF sucursal_count > 0 THEN
        INSERT INTO EMPLEADO (NOMBRE, TELEFONO, CORREO, IDSUCURSAL)
        VALUES (p_nombre, p_telefono, p_correo, p_id_sucursal);
        
        SELECT 'Empleado creado exitosamente.';
    ELSE
        SELECT 'La sucursal especificada no existe. No se puede crear el empleado.';
    END IF;
END //

DELIMITER ;

-- Registrar detalle de venta
-- Este procedimiento genera el registro del detalle de una venta

DELIMITER //

CREATE PROCEDURE registrar_detalle_venta(
    IN p_cantidad INT,
    IN p_precio_total INT,
    IN p_id_venta INT,
    IN p_id_libro INT
)
BEGIN
    -- Insertar los datos en la tabla de detalle_venta
    INSERT INTO DETALLE_VENTA (CANTIDAD, PRECIO_TOTAL, IDVENTA, IDLIBRO)
    VALUES (p_cantidad, p_precio_total, p_id_venta, p_id_libro);
    
    SELECT 'Se ha registrado el detalle de venta del libro ', p_id_libro, 'por un total de ', p_cantidad, 'ejemplares y un valor de ', p_precio_total, 'pesos';

END//

DELIMITER ;

-- Registrar Pago
-- Este procedimiento registra un nuevo pago en la base de datos

DELIMITER //

CREATE PROCEDURE registrar_pago(
	IN p_id_cliente INT,
    IN p_fecha_pago DATETIME,
    IN p_typo INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT ">> error_message: Pago no registrado correctamente" AS Message;
    END;

    START TRANSACTION;

    INSERT INTO venta_libros.PAGOS 
        (IDCLIENTE, FECHA, TYPO)
    VALUES 
        (p_id_cliente, p_fecha_pago, p_typo);
    
    COMMIT;
    SELECT "Pago registrado exitosamente" AS Message;

END //

DELIMITER ;


