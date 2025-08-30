DROP DATABASE IF EXISTS jardineria;
CREATE DATABASE jardineria;
USE jardineria;

-- Tabla oficina
CREATE TABLE oficina (
  ID_oficina INT AUTO_INCREMENT PRIMARY KEY,
  Descripcion VARCHAR(20) NOT NULL,
  ciudad VARCHAR(50) NOT NULL,
  pais VARCHAR(50) NOT NULL,
  region VARCHAR(50),
  codigo_postal VARCHAR(10) NOT NULL,
  telefono VARCHAR(20) NOT NULL,
  linea_direccion1 VARCHAR(100) NOT NULL,
  linea_direccion2 VARCHAR(100)
);

-- Tabla empleado
CREATE TABLE empleado (
  ID_empleado INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  apellido1 VARCHAR(50) NOT NULL,
  apellido2 VARCHAR(50),
  extension VARCHAR(10) NOT NULL,
  email VARCHAR(100) NOT NULL,
  ID_oficina INT NOT NULL,
  ID_jefe INT,
  puesto VARCHAR(50),
  FOREIGN KEY (ID_oficina) REFERENCES oficina(ID_oficina),
  FOREIGN KEY (ID_jefe) REFERENCES empleado(ID_empleado) ON DELETE SET NULL
);

--  Tabla Categoria_producto
CREATE TABLE Categoria_producto (
  Id_Categoria INT AUTO_INCREMENT PRIMARY KEY,
  Desc_Categoria VARCHAR(50) NOT NULL,
  descripcion_texto TEXT,
  descripcion_html TEXT,
  imagen VARCHAR(256)
);

--  Tabla cliente
CREATE TABLE cliente (
  ID_cliente INT AUTO_INCREMENT PRIMARY KEY,
  nombre_cliente VARCHAR(100) NOT NULL,
  nombre_contacto VARCHAR(50),
  apellido_contacto VARCHAR(50),
  telefono VARCHAR(20) NOT NULL,
  fax VARCHAR(20),
  linea_direccion1 VARCHAR(100) NOT NULL,
  linea_direccion2 VARCHAR(100),
  ciudad VARCHAR(50) NOT NULL,
  region VARCHAR(50),
  pais VARCHAR(50) NOT NULL,
  codigo_postal VARCHAR(10),
  ID_empleado_rep_ventas INT,
  limite_credito DECIMAL(15,2),
  FOREIGN KEY (ID_empleado_rep_ventas) REFERENCES empleado(ID_empleado)
);

--  Tabla pedido
CREATE TABLE pedido (
  ID_pedido INT AUTO_INCREMENT PRIMARY KEY,
  fecha_pedido DATE NOT NULL,
  fecha_esperada DATE NOT NULL,
  fecha_entrega DATE,
  estado ENUM('Entregado', 'Pendiente', 'Rechazado') NOT NULL,
  comentarios TEXT,
  ID_cliente INT NOT NULL,
  FOREIGN KEY (ID_cliente) REFERENCES cliente(ID_cliente)
);

--  Tabla producto
CREATE TABLE producto (
  ID_producto INT AUTO_INCREMENT PRIMARY KEY,
  CodigoProducto VARCHAR(15) NOT NULL,
  nombre VARCHAR(70) NOT NULL,
  Categoria INT NOT NULL,
  dimensiones VARCHAR(25),
  proveedor VARCHAR(50),
  descripcion TEXT,
  cantidad_en_stock SMALLINT NOT NULL,
  precio_venta DECIMAL(15,2) NOT NULL,
  precio_proveedor DECIMAL(15,2),
  FOREIGN KEY (Categoria) REFERENCES Categoria_producto(Id_Categoria)
);

--  Tabla detalle_pedido
CREATE TABLE detalle_pedido (
  ID_detalle_pedido INT AUTO_INCREMENT PRIMARY KEY,
  ID_pedido INT NOT NULL,
  ID_producto INT NOT NULL,
  cantidad INT NOT NULL,
  precio_unidad DECIMAL(15,2) NOT NULL,
  numero_linea SMALLINT NOT NULL,
  FOREIGN KEY (ID_pedido) REFERENCES pedido(ID_pedido),
  FOREIGN KEY (ID_producto) REFERENCES producto(ID_producto)
);

--  Tabla pago
CREATE TABLE pago (
  ID_pago INT AUTO_INCREMENT PRIMARY KEY,
  ID_cliente INT NOT NULL,
  forma_pago VARCHAR(40) NOT NULL,
  id_transaccion VARCHAR(50) NOT NULL,
  fecha_pago DATE NOT NULL,
  total DECIMAL(15,2) NOT NULL,
  FOREIGN KEY (ID_cliente) REFERENCES cliente(ID_cliente)
);

-- Datos: oficina
INSERT INTO oficina (Descripcion, ciudad, pais, region, codigo_postal, telefono, linea_direccion1, linea_direccion2)
VALUES
('Central', 'Medellín', 'Colombia', 'Antioquia', '050001', '6041234567', 'Cra 45 #32-10', NULL),
('Sucursal', 'Bogotá', 'Colombia', 'Cundinamarca', '110111', '6017654321', 'Av 68 #22-45', NULL),
('Norte', 'Barranquilla', 'Colombia', 'Atlántico', '080001', '6059876543', 'Calle 72 #45-20', NULL),
('Sur', 'Cali', 'Colombia', 'Valle', '760001', '6024567890', 'Av Roosevelt #30-15', NULL),
('Este', 'Bucaramanga', 'Colombia', 'Santander', '680001', '6073214567', 'Calle 36 #27-50', NULL),
('Oeste', 'Pereira', 'Colombia', 'Risaralda', '660001', '6066543210', 'Cra 8 #20-40', NULL);

--  Datos: empleado
INSERT INTO empleado (nombre, apellido1, apellido2, extension, email, ID_oficina, ID_jefe, puesto)
VALUES
('Juan', 'Pérez', NULL, '101', 'juan.perez@jardineria.com', 1, NULL, 'Gerente General'),
('Ana', 'Gómez', NULL, '102', 'ana.gomez@jardineria.com', 2, 1, 'Supervisora'),
('Luis', 'Ramírez', 'Torres', '103', 'luis.ramirez@jardineria.com', 3, 1, 'Vendedor'),
('María', 'Fernández', NULL, '104', 'maria.fernandez@jardineria.com', 4, 2, 'Vendedora'),
('Carlos', 'López', NULL, '105', 'carlos.lopez@jardineria.com', 5, 2, 'Logística'),
('Sofía', 'Torres', NULL, '106', 'sofia.torres@jardineria.com', 6, 1, 'Atención al cliente');

-- Datos: Categoria_producto
INSERT INTO Categoria_producto (Desc_Categoria, descripcion_texto, descripcion_html, imagen)
VALUES
('Herramientas', 'Herramientas para jardinería', '<p>Herramientas para jardinería</p>', 'herramientas.jpg'),
('Plantas', 'Plantas ornamentales y frutales', '<p>Plantas ornamentales y frutales</p>', 'plantas.jpg'),
('Macetas', 'Macetas de barro, plástico y cerámica', '<p>Macetas variadas</p>', 'macetas.jpg'),
('Fertilizantes', 'Fertilizantes orgánicos e industriales', '<p>Fertilizantes</p>', 'fertilizantes.jpg'),
('Riego', 'Sistemas de riego manual y automático', '<p>Riego eficiente</p>', 'riego.jpg'),
('Decoración', 'Elementos decorativos para jardines', '<p>Decoración de jardines</p>', 'decoracion.jpg');

--  Datos: cliente
INSERT INTO cliente (
  nombre_cliente, nombre_contacto, apellido_contacto, telefono, fax,
  linea_direccion1, linea_direccion2, ciudad, region, pais,
  codigo_postal, ID_empleado_rep_ventas, limite_credito
) VALUES
('Vivero Bello', 'Carlos', 'López', '6049876543', '6049876544', 'Calle 10 #20-30', NULL, 'Bello', 'Antioquia', 'Colombia', '051050', 1, 500000),
('Jardines del Sur', 'María', 'Rodríguez', '6011234567', '6011234568', 'Calle 80 #15-20', NULL, 'Bogotá', 'Cundinamarca', 'Colombia', '110221', 2, 300000),
('Flores y Más', 'Luis', 'Ramírez', '6054567890', '6054567891', 'Av 30 #45-60', NULL, 'Barranquilla', 'Atlántico', 'Colombia', '080020', 3, 200000),
('Naturaleza Viva', 'Sofía', 'Torres', '6023214567', '6023214568', 'Cra 50 #10-25', NULL, 'Cali', 'Valle', 'Colombia', '760010', 4, 400000),
('Verde Hogar', 'Juan', 'Pérez', '6076543210', '6076543211', 'Calle 36 #27-50', NULL, 'Bucaramanga', 'Santander', 'Colombia', '680010', 5, 350000),
('Eco Jardín', 'Ana', 'Gómez', '6061234567', '6061234568', 'Cra 8 #20-40', NULL, 'Pereira', 'Risaralda', 'Colombia', '660110', 6 ,2890000);

INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, ID_cliente)
VALUES
('2025-08-20', '2025-08-25', '2025-08-24', 'Entregado', 'Entrega puntual', 1),
('2025-08-22', '2025-08-28', NULL, 'Pendiente', 'Esperando confirmación de stock', 2),
('2025-08-23', '2025-08-30', '2025-08-29', 'Entregado', 'Cliente satisfecho con el embalaje', 3),
('2025-08-24', '2025-08-31', NULL, 'Pendiente', 'Pedido en preparación', 4),
('2025-08-25', '2025-09-01', '2025-09-02', 'Entregado', 'Entrega con 1 día de retraso', 5),
('2025-08-26', '2025-09-02', NULL, 'Rechazado', 'Cliente canceló por demora', 6);

INSERT INTO producto (CodigoProducto, nombre, Categoria, dimensiones, proveedor, descripcion, cantidad_en_stock, precio_venta, precio_proveedor)
VALUES
('H001', 'Pala de jardín', 1, '30x10cm', 'Herragro', 'Pala metálica con mango de madera', 50, 25000, 18000),
('H002', 'Tijeras de podar', 1, '20cm', 'Truper', 'Tijeras con hoja de acero inoxidable', 100, 30000, 22000),
('P001', 'Rosa roja', 2, '40cm', 'FloraCo', 'Planta ornamental en maceta', 200, 15000, 10000),
('P002', 'Helecho', 2, '60cm', 'VerdeVida', 'Planta decorativa para sombra', 150, 18000, 12000),
('M001', 'Maceta cerámica', 3, '25x25cm', 'Cerámicas del Sur', 'Maceta decorativa blanca', 80, 22000, 16000),
('F001', 'Fertilizante orgánico', 4, '1kg', 'AgroBio', 'Fertilizante natural para plantas', 120, 28000, 20000);

INSERT INTO detalle_pedido (ID_pedido, ID_producto, cantidad, precio_unidad, numero_linea)
VALUES
(1, 1, 2, 25000, 1),
(1, 3, 5, 15000, 2),
(2, 2, 1, 30000, 1),
(3, 4, 3, 18000, 1),
(4, 5, 2, 22000, 1),
(5, 6, 4, 28000, 1);

INSERT INTO pago (ID_cliente, forma_pago, id_transaccion, fecha_pago, total)
VALUES
(1, 'Transferencia', 'TX123456', '2025-08-24', 125000),
(2, 'Efectivo', 'TX654321', '2025-08-25', 30000),
(3, 'Tarjeta crédito', 'TX789012', '2025-08-29', 54000),
(4, 'Transferencia', 'TX345678', '2025-08-30', 22000),
(5, 'Efectivo', 'TX901234', '2025-09-02', 112000),
(6, 'Tarjeta débito', 'TX567890', '2025-08-26', 0);

-- Dimensión Producto
CREATE TABLE dim_producto (
  id_producto INT PRIMARY KEY,
  nombre VARCHAR(100),
  dimensiones VARCHAR(50),
  proveedor VARCHAR(100),
  descripcion TEXT
);

-- Dimensión Categoría
CREATE TABLE dim_categoria (
  id_categoria INT PRIMARY KEY,
  nombre_categoria VARCHAR(100)
);

-- Dimensión Tiempo
CREATE TABLE dim_tiempo (
  fecha_venta DATE PRIMARY KEY,
  año INT,
  mes INT,
  trimestre INT
);

-- Dimensión Cliente
CREATE TABLE dim_cliente (
  id_cliente INT PRIMARY KEY,
  nombre VARCHAR(100),
  ciudad VARCHAR(100),
  país VARCHAR(100)
);

-- Tabla de Hechos: Ventas
CREATE TABLE hechos_ventas (
  id_venta INT PRIMARY KEY,
  id_producto INT,
  id_categoria INT,
  id_cliente INT,
  fecha_venta DATE,
  cantidad INT,
  precio_unitario DECIMAL(10,2),
  total_venta DECIMAL(10,2),
  FOREIGN KEY (id_producto) REFERENCES dim_producto(id_producto),
  FOREIGN KEY (id_categoria) REFERENCES dim_categoria(id_categoria),
  FOREIGN KEY (id_cliente) REFERENCES dim_cliente(id_cliente),
  FOREIGN KEY (fecha_venta) REFERENCES dim_tiempo(fecha_venta)
);

