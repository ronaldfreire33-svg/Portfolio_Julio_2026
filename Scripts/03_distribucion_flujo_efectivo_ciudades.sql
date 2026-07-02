-- ============================================================
-- Requerimiento:
-- "El departamento de operaciones comerciales necesita un reporte con el 
-- total acumulado en dinero de las transacciones del año 2025 por cada ciudad. 
-- Específicamente, quieren ver el monto separado en dos columnas: una para 
-- transacciones de la categoría 'Retiro' y otra para la categoría 'Compra'."
--
-- Regla 1 — ¿Qué me piden mostrar?
-- Ciudades y la plata total dividida por categoría. Como los usuarios están 
-- repartidos en distintas ciudades y hay que agruparlos para consolidar los 
-- números, metemos un GROUP BY por ciudad.
--
-- Regla 2 — ¿Hay un filtro global?
-- Sí, el año. Solo importan los movimientos del 2025. Como esto borra las filas 
-- que no sirven antes de hacer cualquier cuenta, va directo en el WHERE.
--
-- Regla 3 — ¿Por qué el CASE WHEN va en el SELECT y no en el HAVING?
-- Porque acá no quiero esconder ni filtrar ciudades (eso lo haría el HAVING). 
-- El objetivo real es acomodar y MOSTRAR la información ordenada en columnas 
-- distintas para cada ciudad que se movió en 2025. El SELECT arma la estructura 
-- de la pantalla, así que el CASE WHEN va ahí para mandar cada monto a la 
-- columna que le toca.

-- ============================================================

SELECT 
    u.ciudad,
    SUM(CASE WHEN t.categoria = 'Retiro' THEN t.monto ELSE 0 END) AS total_retiros,
    SUM(CASE WHEN t.categoria = 'Compra' THEN t.monto ELSE 0 END) AS total_compras
FROM usuarios u
INNER JOIN transacciones t ON u.id_usuario = t.id_usuario
WHERE t.fecha_transaccion LIKE '2025%'
GROUP BY u.ciudad
ORDER BY u.ciudad ASC;

-- ============================================================

ciudad   |total_retiros|total_compras|
---------+-------------+-------------+
Ambato   |     15538.31|     27407.82|
Cuenca   |     35214.21|     66467.31|
Guayaquil|     18747.11|     34562.54|
Loja     |     20666.34|     61145.05|
Machala  |     17699.72|     28468.36|
Manta    |      21417.2|     38998.28|
Quito    |     26929.58|     56327.98|