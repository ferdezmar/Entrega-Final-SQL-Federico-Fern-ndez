USE venta_libros;

-- Ventas por fecha
-- Esta vista muestra las ventas realizadas en diferentes fechas.

CREATE VIEW
    VentasPorFecha AS
SELECT
    DATE (FECHA) AS Fecha,
    COUNT(*) AS TotalVentas
FROM
    VENTA
GROUP BY
    DATE (FECHA);

-- Ventas por libro
-- Esta vista muestra la cantidad de ventas realizadas para cada libro, así como la disponibilidad del libro.

CREATE VIEW
    VentasPorLibro AS
SELECT
    LIBRO.IDLIBRO,
    LIBRO.DISPONIBLE,
    COUNT(VENTA.IDVENTA) AS TotalVentas
FROM
    LIBRO
    LEFT JOIN VENTA ON LIBRO.IDLIBRO = VENTA.IDLIBRO
GROUP BY
    LIBRO.IDLIBRO;
    

-- Detalle Ventas
-- Esta vista muestra el detalle de ventas realizadas indicando la venta, el libro, la cantidad de libros vendidos y su precio total

CREATE VIEW
    DetalleVentas AS
SELECT *
FROM DETALLE_VENTA
ORDER BY IDLIBRO;

-- Ventas por tipo
-- Esta vista muestra la cantidad de ventas realizadas para cada tipo de venta.
CREATE VIEW
	VentasPorTipo AS
SELECT
	TIPOVENTA.IDTIPOVENTA,
    COUNT(VENTA.IDVENTA) AS TotalVentas
FROM
	TIPOVENTA
    LEFT JOIN VENTA ON TIPOVENTA.IDTIPOVENTA = VENTA.IDTIPOVENTA
GROUP BY
	TIPOVENTA.IDTIPOVENTA;



