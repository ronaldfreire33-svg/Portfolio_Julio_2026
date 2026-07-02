# Portafolio de Análisis de Datos - SQL

Este repositorio contiene scripts de SQL enfocados en la resolución de problemas de negocio, optimización de consultas y control de calidad de datos. El objetivo es documentar mi proceso de lógica y toma de decisiones técnicas.

## 📁 Contenido del Proyecto

*   **[01_volumen_transacciones_y_escala_datos]:** Análisis de cuentas críticas usando `CASE WHEN` en el `HAVING` para exclusión estricta de datos.
*   **[02_analisis_riesgo_y_auditoria_datos.sql]:** Reporte cruzado de flujo de efectivo por ciudad usando `CASE WHEN` en el `SELECT` para clasificación de columnas.
*   **[03_distribucion_flujo_efectivo_ciudades.sql]:** Consultas de control para validación y auditoría.

## 🛠️ Tecnologías Utilizadas
*   Motor de Base de Datos: PostgreSQL 
*   DBeaver

## 💡 Estructura de Comprensión Lógica (Antes del Código)

La mayor lección de este proyecto no fue aprender sintaxis, sino entrenar la mente para procesar el negocio antes de escribir una sola línea de código. Para garantizar resultados exactos y evitar falsos negativos, consolidé una metodología estricta basada en **3 preguntas clave**:

1. **¿Qué me piden mostrar?**  
   Define la agrupación principal (`GROUP BY`) y los campos que estructuran el reporte en pantalla.
2. **¿Hay algún filtro global o de fila individual?**  
   Determina qué datos se descartan por completo antes de realizar cálculos, mandándolos directo al `WHERE`.
3. **¿Te piden comparar categorías de una misma columna?**  
   * **SÍ:** Si hay competencia entre estados o categorías, la decisión es usar un `CASE WHEN` condicional (dentro del `HAVING` para exclusión estricta, o en el `SELECT` para organizar columnas).
   * **NO:** Si solo se evalúa un umbral numérico básico sobre lo ya filtrado, un `HAVING` simple con funciones de agregación tradicionales es suficiente.

Esta disciplina mental mejoró mi flujo de trabajo. Antes dependía de escribir código buscando patrones y esperando el resultado del terminal para adivinar si mi respuesta era correcta. Ahora, sé exactamente qué debe mostrar la pantalla antes de ejecutar la consulta; dejé de depender de un resultado incorrecto para recién interpretar lo que el negocio me estaba pidiendo.
