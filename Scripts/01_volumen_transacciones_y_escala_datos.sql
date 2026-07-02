-- ============================================================
-- Requerimiento:
-- "Necesitamos identificar las ciudades donde tenemos más de 80
-- transacciones aprobadas durante 2024 y 2025 combinados."
--
-- Regla 1 — ¿Qué me piden mostrar?
-- Ciudades. Como cada ciudad agrupa a varios usuarios y cada
-- usuario a su vez tiene muchas transacciones, necesito agrupar
-- por ciudad para consolidar el conteo por ciudad.
--
-- Regla 2 — ¿Hay un filtro global?
-- Sí, dos: que la transacción esté 'Aprobada' y que la fecha caiga
-- dentro del rango 2024-2025. Ambas condiciones aplican por igual
-- a todas las filas antes de agrupar, así que van en el WHERE.
--
-- Regla 3 — ¿Comparo categorías de una misma columna?
-- No. El enunciado no pide enfrentar 'Aprobada' contra otro estado;
-- solo pide contar cuántas aprobadas superan un umbral. Al no haber
-- competencia entre categorías, no hace falta CASE WHEN: un HAVING
-- simple con COUNT(*) sobre lo que ya filtró el WHERE es suficiente.
--
-- Conclusión de negocio:
-- Con el umbral literal del enunciado (80), la query devolvía las
-- 7 ciudades sin excepción -- resultado que a primera vista parece
-- un error. No lo era: la base tiene ~2600 transacciones aprobadas
-- repartidas en solo 7 ciudades, así que incluso la ciudad con menos
-- volumen (Ambato, 214) superaba el umbral por mucho. El "80" tenía
-- sentido como ejemplo didáctico sobre una base de 15 filas, pero
-- se vuelve un filtro inútil sobre una base de escala real.
-- Ajustando el umbral a uno proporcional al volumen real (400),
-- el filtro sí discrimina: Cuenca, Loja y Quito concentran la mayor
-- actividad aprobada del período, mientras que el resto de ciudades
-- queda por debajo.
--
-- Nota de aprendizaje:
-- Venir de ejercicios con datasets de 10-15 filas entrena el ojo
-- para detectar errores mirando el resultado completo de un vistazo.
-- Con una base real, esa referencia visual desaparece y cualquier
-- resultado "grande" (como que salgan todas las ciudades) se siente
-- sospechoso, aunque la consulta esté bien escrita. La lección no es
-- de sintaxis sino de criterio: antes de fijar un umbral en el HAVING,
-- primero hay que dimensionar el volumen total de datos (¿cuántas
-- filas sobrevivieron al WHERE en total?, ¿cómo se reparten entre
-- categorías?) y recién ahí decidir si el número tiene sentido, en
-- vez de confiar en que un número "se ve razonable" a simple vista.
-- ============================================================

SELECT u.ciudad, COUNT(*) AS total_aprobadas
FROM usuarios u
INNER JOIN transacciones t ON u.id_usuario = t.id_usuario
WHERE t.estado = 'Aprobada'
  AND t.fecha_transaccion BETWEEN '2024-01-01' AND '2025-12-31'
GROUP BY u.ciudad
HAVING COUNT(*) > 400
ORDER BY total_aprobadas DESC;

-- Resultado:
-- Cuenca    | 557
-- Loja      | 507
-- Quito     | 451
