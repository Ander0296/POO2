SELECT p.nombre, SUM(dp.cantidad) AS total_vendido
FROM detalle_pedido dp
JOIN producto p ON dp.ID_producto = p.ID_producto
GROUP BY p.nombre
ORDER BY total_vendido DESC
LIMIT 1;

SELECT cp.Desc_Categoria, COUNT(p.ID_producto) AS total_productos
FROM producto p
JOIN Categoria_producto cp ON p.Categoria = cp.Id_Categoria
GROUP BY cp.Desc_Categoria
ORDER BY total_productos DESC
LIMIT 1;

SELECT YEAR(ped.fecha_pedido) AS año, SUM(dp.cantidad * dp.precio_unidad) AS total_ventas
FROM pedido ped
JOIN detalle_pedido dp ON ped.ID_pedido = dp.ID_pedido
GROUP BY año
ORDER BY total_ventas DESC;



