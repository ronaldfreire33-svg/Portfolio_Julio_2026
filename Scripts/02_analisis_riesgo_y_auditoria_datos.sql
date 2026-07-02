-- ============================================================
-- Requerimiento:
-- "El equipo de riesgo quiere saber qué tipos de cuenta muestran más 
-- transacciones rechazadas que aprobadas, considerando solo el año 2025."
--
-- Regla 1 — ¿Qué me piden mostrar?
-- Tipos de cuenta. Como los usuarios están agrupados por su tipo de cuenta 
-- y cada uno tiene muchos movimientos, agrupamos por esta columna para consolidar.
--
-- Regla 2 — ¿Hay un filtro global?
-- Sí, el año. Solo nos interesan las transacciones del 2025. Como aplica a todas 
-- las filas antes de contar, va directo en el WHERE.
--
-- Regla 3 — ¿Comparo categorías de una misma columna?
-- Sí. El enunciado pide enfrentar dos estados ("Rechazada" contra "Aprobada") 
-- de la columna estado. Para ver cuál es mayor, usamos un CASE WHEN con COUNT 
-- dentro del HAVING para que compare ambos conteos en cada grupo.
--
-- Conclusión de negocio:
-- Al correr la consulta la terminal quedó totalmente vacía. No fue un error de 
-- código, sino la realidad de los datos: en ningún tipo de cuenta hubo más 
-- rechazos que aprobaciones durante 2025. El filtro del HAVING funcionó bien 
-- y eliminó las filas que no cumplían.
--
-- Nota de aprendizaje:
-- Ver la pantalla vacía hace pensar que la consulta está mal escrita. Para sacarnos 
-- la duda, armamos una segunda consulta moviendo el CASE WHEN al SELECT para ver 
-- los números reales de cada cuenta. Ahí confirmamos que Ahorros (228 vs 708), 
-- Corriente (135 vs 448) y Empresarial (113 vs 127) tenían más aprobadas que 
-- rechazadas. El código original siempre estuvo bien, la base de datos simplemente 
-- no tenía ninguna cuenta en números rojos.
-- ============================================================

-- Código 1: Consulta principal (Resultado vacío)
SELECT u.tipo_cuenta
FROM usuarios u
INNER JOIN transacciones t ON u.id_usuario = t.id_usuario
WHERE t.fecha_transaccion LIKE '2025%'
GROUP BY u.tipo_cuenta
HAVING COUNT(CASE WHEN t.estado = 'Rechazada' THEN 1 END) > 
       COUNT(CASE WHEN t.estado = 'Aprobada' THEN 1 END);

-- Resultado:
-- (Empty set)

-- ------------------------------------------------------------
-- Código 2: Consulta de control para verificar los números
-- ------------------------------------------------------------
SELECT 
    u.tipo_cuenta,
    COUNT(CASE WHEN t.estado = 'Rechazada' THEN 1 END) AS rechazadas,
    COUNT(CASE WHEN t.estado = 'Aprobada' THEN 1 END) AS aprobadas
FROM usuarios u
INNER JOIN transacciones t ON u.id_usuario = t.id_usuario
WHERE t.fecha_transaccion LIKE '2025%'
GROUP BY u.tipo_cuenta;

-- Resultado de verificación:
-- tipo_cuenta | rechazadas | aprobadas |
-- ------------+------------+-----------+
-- Ahorros     |        228 |       708 |
-- Corriente   |        135 |       448 |
-- Empresarial |        113 |       127 |