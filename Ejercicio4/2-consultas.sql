--1. Listado de ventas del mes actual

SELECT 
    s.nombre_sucursal,
    v.nombre_vendedor,
    p.marca,
    p.nombre_producto,
    ven.fecha_venta,
    ven.unidades_vendidas,
    p.precio_unitario,
    (ven.unidades_vendidas * p.precio_unitario) AS valor_venta  -- Cálculo del valor de venta
FROM 
    venta ven
JOIN 
    sucursal s ON ven.id_sucursal = s.id_sucursal
JOIN 
    vendedor v ON ven.id_vendedor = v.id_vendedor
JOIN 
    producto p ON ven.id_producto = p.id_producto
WHERE 
    DATE_TRUNC('month', ven.fecha_venta) = DATE_TRUNC('month', CURRENT_DATE);

-- 2. Ventas totales por sucursal, vendedor y marca, incluyendo los vendedores que no tuvieron ventas

SELECT 
    s.nombre_sucursal,
    v.nombre_vendedor,
    p.marca,
    COALESCE(SUM(ven.unidades_vendidas * p.precio_unitario), 0) AS total_venta  -- Cálculo del total de venta
FROM 
    sucursal s
CROSS JOIN 
    vendedor v
LEFT JOIN 
    venta ven ON ven.id_vendedor = v.id_vendedor AND ven.id_sucursal = s.id_sucursal
LEFT JOIN 
    producto p ON ven.id_producto = p.id_producto
GROUP BY 
    s.nombre_sucursal, v.nombre_vendedor, p.marca
ORDER BY 
    s.nombre_sucursal, v.nombre_vendedor, p.marca;

--3. Productos con más de 1000 unidades vendidas en los últimos 2 meses

SELECT 
    p.nombre_producto,
    p.marca,
    SUM(ven.unidades_vendidas) AS unidades_vendidas
FROM 
    venta ven
JOIN 
    producto p ON ven.id_producto = p.id_producto
WHERE 
    ven.fecha_venta >= CURRENT_DATE - INTERVAL '2 months'
GROUP BY 
    p.nombre_producto, p.marca
HAVING 
    SUM(ven.unidades_vendidas) > 1000;

--4. Productos sin ventas en el presente año

SELECT 
    p.nombre_producto,
    p.marca
FROM 
    producto p
LEFT JOIN 
    venta ven ON p.id_producto = ven.id_producto 
    AND EXTRACT(YEAR FROM ven.fecha_venta) = EXTRACT(YEAR FROM CURRENT_DATE)
WHERE 
    ven.id_producto IS NULL;

--5. De los productos sin ventas en el presente año, monto total de ventas en el año anterior

SELECT 
    p.nombre_producto,
    p.marca,
    COALESCE(SUM(ven.unidades_vendidas * p.precio_unitario), 0) AS total_venta  -- Cálculo del total de venta
FROM 
    producto p
LEFT JOIN 
    venta ven ON p.id_producto = ven.id_producto 
    AND EXTRACT(YEAR FROM ven.fecha_venta) = EXTRACT(YEAR FROM CURRENT_DATE) - 1
WHERE 
    p.id_producto NOT IN (
        SELECT id_producto
        FROM venta
        WHERE EXTRACT(YEAR FROM fecha_venta) = EXTRACT(YEAR FROM CURRENT_DATE)
    )
GROUP BY 
    p.nombre_producto, p.marca;
