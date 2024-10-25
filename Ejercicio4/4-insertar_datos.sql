-- Insertar datos en la tabla sucursal
INSERT INTO sucursal (nombre_sucursal, ciudad, pais, jefe_sucursal) VALUES
('Sucursal Centro', 'Santiago', 'Chile', 'Juan Pérez'),
('Sucursal Norte', 'Valparaíso', 'Chile', 'María López'),
('Sucursal Sur', 'Concepción', 'Chile', 'Carlos González');

-- Insertar datos en la tabla vendedor
INSERT INTO vendedor (nombre_vendedor, telefono_vendedor) VALUES
('Ana Torres', '987654321'),
('Luis Herrera', '123456789'),
('María García', '456789123');

-- Insertar datos en la tabla producto
INSERT INTO producto (nombre_producto, categoria_producto, marca, precio_unitario) VALUES
('Laptop', 'Electrónica', 'Dell', 800.00),
('Smartphone', 'Electrónica', 'Samsung', 600.00),
('Televisor', 'Electrodoméstico', 'LG', 1200.00),
('Audífonos', 'Accesorios', 'Sony', 150.00);

-- Insertar datos en la tabla venta
INSERT INTO venta (id_vendedor, id_sucursal, id_producto, unidades_vendidas, fecha_venta) VALUES
(1, 1, 1, 10, '2024-10-05'),
(2, 1, 2, 5, '2024-10-10'),
(1, 2, 3, 8, '2024-10-15'),
(3, 1, 1, 2, '2024-10-20'),
(1, 3, 4, 20, '2024-09-25'),
(2, 2, 2, 15, '2024-09-30'),
(3, 3, 3, 0, '2024-09-15');
