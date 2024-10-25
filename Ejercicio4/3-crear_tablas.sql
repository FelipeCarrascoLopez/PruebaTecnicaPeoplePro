-- Crear la tabla sucursal
CREATE TABLE sucursal (
    id_sucursal SERIAL PRIMARY KEY,
    nombre_sucursal VARCHAR(100) NOT NULL,
    ciudad VARCHAR(50) NOT NULL,
    pais VARCHAR(50) NOT NULL,
    jefe_sucursal VARCHAR(100) NOT NULL
);

-- Crear la tabla vendedor
CREATE TABLE vendedor (
    id_vendedor SERIAL PRIMARY KEY,
    nombre_vendedor VARCHAR(100) NOT NULL,
    telefono_vendedor VARCHAR(15) NOT NULL
);

-- Crear la tabla producto
CREATE TABLE producto (
    id_producto SERIAL PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL,
    categoria_producto VARCHAR(50) NOT NULL,
    marca VARCHAR(50) NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL
);

-- Crear la tabla venta
CREATE TABLE venta (
    id_venta SERIAL PRIMARY KEY,
    id_vendedor INT REFERENCES vendedor(id_vendedor),
    id_sucursal INT REFERENCES sucursal(id_sucursal),
    id_producto INT REFERENCES producto(id_producto),
    unidades_vendidas INT NOT NULL,
    fecha_venta DATE NOT NULL
);