# <center>Entrega final SQL</center>

Federico Fernández Mardaráz

Comisión 53175

Tutor: Nancy Villena Reines

Docente: Anderson Torres

---
### **Contenido:**

- La base de datos contiene:
    *  10 tablas.
    *  4 vistas.
    *  4 stored procedure.
    *  2  trigger.
    *  3 funciones
---

### **Temática:**

Estamos trabajando en un sistema de gestión de ventas para una librería, debemos diseñar una base
de datos que maneje todas las operaciones de venta, a la vez que registre pagos, clientes y empleados involucrados en cada venta.
Nuestro objetivo es diseñar e implementar una base de datos relacional que satisfaga todas las necesidades de gestión
de ventas para nuestro sistema de gestión de librerías.

### **Descripción:**

1. Gestión de Clientes y Empleados:
Necesitamos una base de datos que nos permita registrar la información de los clientes que realizan
compras así como de los empleados involucrados en el proceso de atención al cliente.
2. Gestión de Tipos de Venta y Pagos:
Es importante poder clasificar las ventas según su tipo, ya sea en firme o consignada. A la vez, poder
registrar los pagos según su tipo. Esto nos
ayudará a organizar mejor el trabajo y adaptar nuestros servicios según las necesidades del cliente.
Los empleados podrán ser ubicados en sucursales con un gerente definido.
4. Gestión de Libros y Disponibilidad:
La base de datos debe permitirnos registrar la disponibilidad de libros en cada sucursal para poder
gestionar su reposición identificando a qué proveedor pertenecen.
5. Registro de Ventas:
Necesitamos un sistema que pueda registrar cada venta realizada, incluyendo la fecha de la venta, el
cliente que la realizó, el libro vendido, el empleado que atendió la venta, si se trata de una venta en
firme o consignada, en qué sucursal se vendió. A la vez, necesitamos el detalle de cantidad vendida y
precio total.

### **Diagrama entidad relación (DER):**


<center>
<img src="https://res.cloudinary.com/dixw5lxaq/image/upload/v1714939142/DER_venta_libros_wiqhbc.jpg" style="width: 100% ; aspect-ratio:16/9">
</center>

## Listado de tablas y descripcion

| Tabla         | Columna           | Tipo de Datos                         |
| ------------- | ----------------- |                                  ---: |
| VENTA         | IDVENTA           | INT                                   |
|               | IDCLIENTE         | INT                                   |
|               | IDLIBRO           | INT                                   |
|               | IDEMPLEADO        | INT                                   |
|               | IDTIPOVENTA       | INT                                   |
|               | FECHA             | DATETIME                              |


| Tabla         | Columna           | Tipo de Datos                         |
| ------------- | ----------------- |                                  ---: |
| CLIENTE       | IDCLIENTE         | INT                                   |
|               | NOMBRE            | VARCHAR(100) DEFAULT 'USUARIO_UNKNOW' |
|               | TELEFONO          | VARCHAR(20) NOT NULL                  |
|               | CORREO            | VARCHAR(100) UNIQUE NOT NULL          |
|               | FECHA_ALTA        | DATETIME                              |
|               | STATUS            | BOOLEAN DEFAULT TRUE                  |


| Tabla         | Columna           | Tipo de Datos                         |
| ------------- | ----------------- |                                  ---: |
| EMPLEADO      | IDEMPLEADO        | INT                                   |
|               | NOMBRE            | VARCHAR(100)                          |
|               | TELEFONO          | VARCHAR(20)                           |
|               | CORREO            | VARCHAR(100)                          |
|               | IDSUCURSAL        | INT                                   |


| Tabla         | Columna           | Tipo de Datos                         |
| ------------- | ----------------- |                                  ---: |
| GERENTE       | IDGERENTE         | INT                                   |
|               | NOMBRE            | VARCHAR(100)                          |
|               | TELEFONO          | VARCHAR(20)                           |
|               | CORREO            | VARCHAR(100)                          |


| Tabla         | Columna           | Tipo de Datos                         |
| ------------- | ----------------- |                                  ---: |
| TIPOVENTA     | IDTIPOVENTA       | INT                                   |
|               | TIPO              | VARCHAR(50)                           |


| Tabla         | Columna           | Tipo de Datos                         |
| ------------- | ----------------- |                                  ---: |
| SUCURSAL      | IDSUCURSAL        | INT                                   |
|               | NOMBRE            | VARCHAR(100)                          |
|               | DIRECCION         | VARCHAR(255)                          |
|               | TELEFONO          | VARCHAR(20)                           |
|               | IDGERENTE         | INT                                   |


| Tabla         | Columna           | Tipo de Datos                         |
| ------------- | ----------------- |                                  ---: |
| LIBRO         | IDLIBRO           | INT                                   |
|               | IDSUCURSAL        | INT                                   |
|               | IDPROVEEDOR       | INT                                   |
|               | TITULO            | VARCHAR(100)                          |
|               | PRECIO_UNITARIO   | INT                                   |
|               | DISPONIBLE        | BOOLEAN                               |


| Tabla         | Columna           | Tipo de Datos                         |
| ------------- | ----------------- |                                  ---: |
| PROVEEDOR     | IDPROVEEDOR       | INT                                   |
|               | NOMBRE            | VARCHAR(100)                          |
|               | TELEFONO          | VARCHAR(20)                           |
|               | CORREO            | VARCHAR(100)                          |


| Tabla         | Columna           | Tipo de Datos                         |
| ------------- | ----------------- |                                  ---: |
| DETALLE_VENTA | CANTIDAD          | INT                                   |
|               | PRECIO_TOTAL      | INT                                   |
|               | IDVENTA           | INT                                   |
|               | IDLIBRO           | INT                                   |


| Tabla         | Columna           | Tipo de Datos                         |
| ------------- | ----------------- |                                  ---: |
| PAGOS         | IDPAGO            | INT                                   |
|               | IDCLIENTE         | INT                                   |
|               | FECHA             | DATETIME                              |
|               | TYPO              | ENUM                                  |

## **Estructura e ingesta de datos:**
* Se realiza por medio del archivo `insercion_datos.sql`:
Tablas CLIENTE, GERENTE, TIPOVENTA, SUCURSAL, EMPLEADO, PROVEEDOR, LIBRO y PAGOS.
* La carga de las tablas VENTA y DETALLE_VENTA se realiza por medio de dos csv colocados en el directorio ./structure/data_csv
Son insertados mediante Table Data Import Wizard disponible en MySQL Workbench en el área schemas. Allí se selecciona los archivos csv generados mediante Mockaroo que se adjuntan a la presentación bajo los nombres ‘VENTA SQL’ y ‘DETALLE_VENTA SQL’.

`IMPORTANTE: cargar primero el archivo VENTA SQL y luego el archivo DETALLE_VENTA SQL`

## Objetos de la base de datos
A continuación se detalla la documentación de Vistas, Funciones, Triggers y Procedimientos almacenados presentados en distintos scripts.

* ### Documentacion de Vistas

### Vista: VentasPorFecha

**Descripción:** Esta vista muestra las ventas realizadas en diferentes fechas.

**Columnas:**

* **Fecha:** Fecha de la venta (formato YYYY-MM-DD)
* **TotalVentas:** Número total de ventas realizadas en la fecha indicada

**Ejemplo de consulta:**

```sql
SELECT * FROM VentasPorFecha
WHERE Fecha BETWEEN '2010-12-01' AND '2023-12-31'
ORDER BY Fecha ASC;
```

### Vista: VentasPorLibro

**Descripción:** Esta vista muestra la cantidad de ventas realizadas para cada libro, así como la disponibilidad del libro.

**Columnas:**

* **IDLibro:** Identificador único del libro
* **Disponible:** Indica sí el libro se encuentra o no disponible
* **TotalVentas:** Número total de ventas realizadas para el libro

**Ejemplo de consulta:**

```sql
SELECT * FROM VentasPorLibro
ORDER BY TotalVentas DESC;
```


### Vista: DetalleVentas

**Descripción:** Esta vista muestra el detalle de ventas realizadas indicando la venta, el libro, la cantidad de libros vendidos y su precio total.

**Columnas:**

* **Cantidad:** Indica la cantidad de libros vendidos en la venta
* **Precio_Total:** Indica el valor final de la venta
* **IdVenta:** Indica el número identificador de la venta
* **IdLibro:** indica el número identificador del libro

**Ejemplo de consulta:**

```sql
SELECT * FROM DetalleVentas;
```

### Vista: VentasPorTipo

**Descripción:** Esta vista muestra la cantidad de ventas realizadas para cada tipo de venta.

**Columnas:**

* **IdTipoVenta:** Indica el tipo de venta 1 (Venta en consignación) o el tipo de venta 2 (Venta en firme)
* **TotalVentas:** indica el total de ventas para cada tipo de venta

**Ejemplo de consulta:**

```sql
SELECT * FROM VentasPorTipo
ORDER BY TotalVentas DESC;
```

* ### Documentación de Funciones

### Función: contar_ventas_cliente

**Descripción:** Función para contar las ventas realizadas a un cliente en un intervalo de tiempo.

**Parámetros:**

* **cliente_id:** Identificador único del cliente
* **fecha_inicio:** Fecha de inicio del intervalo (formato YYYY-MM-DD)
* **fecha_fin:** Fecha de fin del intervalo (formato YYYY-MM-DD)

**Retorno:**

Número total de ventas realizadas al cliente en el intervalo de tiempo especificado.

**Ejemplo de uso:**

```sql
SELECT contar_ventas_cliente(5, '2020-12-01', '2023-12-31');
```

### Función: cantidad_libros_por_sucursal

**Descripción:** Función para obtener la cantidad de libros por cada sucursal.

**Parámetros:**

* **sucursal_id:** Identificador único de la sucursal

**Retorno:**

Cantidad de libros existentes en la sucursal solicitada.

**Ejemplo de uso:**

```sql
SELECT cantidad_libros_por_sucursal(5);
```

### Función: contar_ventas_empleado

**Descripción:** Función para contar las ventas realizadas por un empleado.

**Parámetros:**

* **empleado_id:** Identificador único del empleado

**Retorno:** 

Cantidad de ventas realizadas por el empleado

**Ejemplo de uso:**

```sql
SELECT contar_ventas_empleado (6);
```

* ### Documentación de Triggers

### Trigger: before_insert_cliente_trigger

**Descripción:** El trigger avisa si el nombre de un cliente ya está en uso.

**Detalles:**

* **Tabla afectada:** CLIENTE
* **Acción:** INSERT
* **Validación:** Nombre único

**Ejemplo:**
Se intenta insertar un nuevo cliente con un nombre ya existente.
El trigger genera un error, indica el mensaje “El nombre del cliente ya está en uso” y la inserción no se realiza.

### Trigger: before_insert_venta_trigger

**Descripción:** Trigger para verificar si ya se realizó una venta idéntica al cliente.

**Detalles:**

* **Tabla afectada:** VENTA
* **Acción:** INSERT
* **Validación:** Se registra una repetición del cliente, del libro y de la fecha en la venta, se genera un aviso para constatar que no se esté repitiendo la venta por error.

**Ejemplo:**
Se intenta generar la venta de un libro para un cliente que ya tiene una compra por el mismo libro.
El trigger genera un error, emite un mensaje indicando que ese cliente realizó una compra idéntica y que debe modificar la fecha y la venta no se realiza.

* ### Documentación de Procedimientos Almacenados

### Procedimiento: crear_cliente

**Descripción:** Este procedimiento es para crear un nuevo cliente en la base de datos, cuenta con una transacción que realiza un rollback en caso de existir un error y realiza un commit en caso de carga correcta.

**Parámetros:**

* **p_nombre:** Nombre del cliente
* **p_telefono:** Teléfono del cliente
* **p_correo:** Correo electrónico del cliente
* **p_fecha_alta:** Fecha de creación del cliente
* **p_status:** Estado de cliente

**Retorno:**

Mensaje de éxito (‘Cliente insertado exitosamente’) o error ('>> error_message: Cliente no insertado correctamente se hace un Rollback').

**Ejemplo de uso:**

```sql
CALL crear_cliente('Lydia Gomez','1212121212', 'lydia@gmail.com', '2020-03-10', 1);
```

### Procedimiento: crear_empleado

**Descripción:** Este procedimiento es para crear un nuevo empleado en la base de datos verificando la existencia de la sucursal especificada.

**Parámetros:**

* **p_nombre:** Nombre del empleado
* **p_telefono:** Teléfono del empleado
* **p_correo:** Correo electrónico del empleado
* **p_id_sucursal:** Identificador de la sucursal a la que pertenece el empleado

**Retorno:**

Mensaje de éxito (‘Empleado creado exitosamente’) o error (‘La sucursal especificada no existe. No se puede crear el empleado’).

**Ejemplo de uso:**

```sql
CALL crear_empleado('María Perez','13659464', 'lydia@gmail.com',  6);
```

### Procedimiento: registrar_detalle_venta

**Descripción:** Este procedimiento genera el registro del detalle de una venta

**Parámetros:**

* **p_cantidad:** Cantidad de ejemplares en la venta
* **p_precio_total:** Precio total de la venta
* **p_id_venta:** identificador de la venta
* **p_id_libro:** identificador del libro

**Retorno:**

Mensaje de éxito: 'Se ha registrado el detalle de venta del libro ___ por un total de ___ ejemplares y un valor de ___ pesos'.

**Ejemplo de uso:**

```sql
CALL registrar_detalle_venta('7', '21000', '20', '69');
```

### Procedimiento: registrar_pago

**Descripción:** Este procedimiento genera el registro de un pago, cuenta con una transacción que realiza un rollback en caso de existir un error y realiza un commit en caso de carga correcta.

**Parámetros:**

* **p_id_cliente:** identificador del cliente
* **p_fecha_pago:** Fecha de realización del pago
* **p_typo:** tipo de pago realizado

**Retorno:**

Mensaje de éxito ('Pago registrado exitosamente') o error ('>> error_message: Pago no registrado correctamente').

**Ejemplo de uso:**

```sql
CALL registrar_pago (4, '2020-08-12', 3);
SELECT * FROM PAGOS;
```

## Roles y permisos

`./objects/roles_users.sql`

Se generan dos roles:

1. `role_select_vistas`: Este rol tiene permisos solo para SELECT en las vistas.
2. `role_crud_sucursales`: Este rol tiene permisos para generar CRUD en las tablas relacionadas con sucursales.

Además, crea un usuario para cada rol: Además, `empleado@%` para SELECT en vistas y `gerente@%` para generar CRUD.

## Back up de la base de datos

`./backup/backup_venta_libros.sql`

El archivo sql contiene la estructura de la base de datos, los objetos creados y los datos insertados. Se puede importar desde `MySQL Workbench / DataImport / 'Import from self-contained file'`

## Herramientas usadas

* MySQL (Motor de bases de datos `version: latest`)
* MySQL Workbench (Interfaz grafica)
* Mockaroo (para otorgar datos ficticios)

## Info para levantar proyecto

* **env:** Archivo con contraseñas y data secretas

