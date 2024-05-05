USE venta_libros;
-- Before Insert Cliente
-- El trigger avisa si el nombre de un cliente ya está en uso.

DELIMITER //

CREATE TRIGGER before_insert_cliente_trigger
BEFORE INSERT ON CLIENTE
FOR EACH ROW
BEGIN
    DECLARE nombre_count INT;
    
    SELECT COUNT(*) INTO nombre_count
        FROM CLIENTE
    WHERE NOMBRE = NEW.NOMBRE;
    
    IF nombre_count > 0 THEN
        SIGNAL SQLSTATE '11665' SET MESSAGE_TEXT = 'El nombre del cliente ya está en uso.';
    END IF;
END //

DELIMITER ;

-- Trigger para verificar si ya se realizó una venta idéntica al cliente.

DELIMITER //

CREATE TRIGGER before_insert_venta_trigger
BEFORE INSERT ON VENTA
FOR EACH ROW
BEGIN
    DECLARE venta_count INT;
    
    SELECT COUNT(*) INTO venta_count
        FROM VENTA
    WHERE IDCLIENTE = NEW.IDCLIENTE
        AND IDLIBRO = NEW.IDLIBRO
        AND FECHA = NEW.FECHA;
        
    IF venta_count > 0 THEN
        SIGNAL SQLSTATE '11654' SET MESSAGE_TEXT = 'El cliente realizó una compra identica, consultar si desea repetirla y cambiar la fecha para poder procesarla.';
    END IF;
END //

DELIMITER ;