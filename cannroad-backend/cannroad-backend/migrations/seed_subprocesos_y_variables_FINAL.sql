-- ============================================================================
-- CannRoad v3.0 — Seed: Subprocesos y Variables (VERSIÓN FINAL - SIN ERRORES)
-- ============================================================================
-- Archivo: migrations/seed_subprocesos_y_variables_FINAL.sql
-- Descripción: Carga subprocesos y variables con todas las consideraciones
-- Ejecutar DESPUÉS de: 002_v3_schema.sql
-- ============================================================================

BEGIN;

-- ============================================================================
-- INSERTAR SUBPROCESOS Y VARIABLES
-- ============================================================================


-- Proceso 1: Planta Madre

INSERT INTO subprocesos (proceso_id, nombre, orden, requiere_climatizacion, cm_re_referencia, descripcion, activo)
VALUES (1, 'Calibración de Riego', 1, FALSE, 'CM-PL-02', 'Calibración de disparos de riego automático por Planta Madre.', TRUE);
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Fecha', 'fecha', NULL, NULL, NULL, TRUE, NULL, 1, 'Fecha de calibración', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Calibración de Riego'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'PM N°', 'texto', NULL, NULL, NULL, TRUE, NULL, 2, 'Identificador de la Planta Madre (PM N°1 a N°12)', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Calibración de Riego'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Disparo N°', 'seleccion', NULL, NULL, NULL, TRUE, '["1", "2", "3", "4", "5"]'::jsonb, 3, 'Número de disparo de riego automático', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Calibración de Riego'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Tiempo Disparo', 'numero', 'min', NULL, 60, TRUE, NULL, 4, 'Duración del disparo', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Calibración de Riego'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'ml Aplicados', 'numero', 'ml', NULL, 5000, TRUE, NULL, 5, 'Volumen aplicado en el disparo', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Calibración de Riego'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Tiempo de Testigo', 'numero', 'min', NULL, 60, FALSE, NULL, 6, 'Minutos de testigo del riego automático según estacas', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Calibración de Riego'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Observaciones', 'texto', NULL, NULL, NULL, FALSE, NULL, 7, 'Notas de calibración', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Calibración de Riego'
LIMIT 1;

INSERT INTO subprocesos (proceso_id, nombre, orden, requiere_climatizacion, cm_re_referencia, descripcion, activo)
VALUES (1, 'Control de Clones', 2, FALSE, 'CM-RE-0202', 'Registro de corte de clones desde plantas madre.', TRUE);
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Fecha', 'fecha', NULL, NULL, NULL, TRUE, NULL, 1, 'Fecha de corte de clones', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Control de Clones'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'N° Lote Planta Madre', 'texto', NULL, NULL, NULL, TRUE, NULL, 2, 'Lote de la planta madre de origen', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Control de Clones'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Cantidad de Clones Cortados', 'numero', NULL, NULL, 2000, TRUE, NULL, 3, 'Clones cortados en la jornada', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Control de Clones'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'N° de Camada Asignado', 'texto', NULL, NULL, NULL, TRUE, NULL, 4, 'Camada a la que se asignan los clones', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Control de Clones'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Observaciones', 'texto', NULL, NULL, NULL, FALSE, NULL, 5, 'Notas', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Control de Clones'
LIMIT 1;

INSERT INTO subprocesos (proceso_id, nombre, orden, requiere_climatizacion, cm_re_referencia, descripcion, activo)
VALUES (1, 'Labores Culturales', 3, FALSE, 'CM-PG-XX', 'Labores culturales de mantenimiento de plantas.', TRUE);
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Fecha', 'fecha', NULL, NULL, NULL, TRUE, NULL, 1, 'Fecha de la labor', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Labores Culturales'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'N° Lote', 'texto', NULL, NULL, NULL, TRUE, NULL, 2, 'Lote intervenido', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Labores Culturales'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Poda de Limpieza', 'booleano', NULL, NULL, NULL, FALSE, NULL, 3, 'Se realizó poda de limpieza', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Labores Culturales'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Poda de Formación', 'booleano', NULL, NULL, NULL, FALSE, NULL, 4, 'Se realizó poda de formación', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Labores Culturales'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Colocación de Trampa', 'booleano', NULL, NULL, NULL, FALSE, NULL, 5, 'Se colocó trampa fitosanitaria', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Labores Culturales'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Colocación de Red', 'booleano', NULL, NULL, NULL, FALSE, NULL, 6, 'Se colocó red de sostén', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Labores Culturales'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Responsable', 'texto', NULL, NULL, NULL, TRUE, NULL, 7, 'Quién ejecuta la labor', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Labores Culturales'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Indicado por', 'texto', NULL, NULL, NULL, FALSE, NULL, 8, 'Quién indicó la labor', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Labores Culturales'
LIMIT 1;

INSERT INTO subprocesos (proceso_id, nombre, orden, requiere_climatizacion, cm_re_referencia, descripcion, activo)
VALUES (1, 'Registro de Escorrentía y Condiciones Ambientales', 4, TRUE, 'CM-RE-0101', 'Medición diaria de escurrimiento (pH/EC) y condiciones ambientales (T°, HR, VPD, CO2, ventilación) de Sala Plantas Madres. Rango real observado en CM-RE-0101: Humedad 28.8-53%+, Temperatura 15-19.4°C, VPD 0.03-0.4+ kPa, CO2 100-1134+ ppm — más amplio que el estándar v3.0.', TRUE);
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Fecha Última Medición', 'fecha', NULL, NULL, NULL, FALSE, NULL, 1, 'Fecha de la medición anterior', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Registro de Escorrentía y Condiciones Ambientales'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Fecha Actual', 'fecha', NULL, NULL, NULL, TRUE, NULL, 2, 'Fecha de la medición actual', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Registro de Escorrentía y Condiciones Ambientales'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'ID Planta', 'texto', NULL, NULL, NULL, TRUE, NULL, 3, 'Identificador de planta madre (PM.1 a PM.12)', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Registro de Escorrentía y Condiciones Ambientales'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'ML Escurrimiento (1ra Medición)', 'numero', 'ml', NULL, 2000, TRUE, NULL, 4, 'Mililitros de escurrimiento', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Registro de Escorrentía y Condiciones Ambientales'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'pH Escurrimiento (1ra Medición)', 'numero', NULL, NULL, 14, TRUE, NULL, 5, 'pH del escurrimiento', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Registro de Escorrentía y Condiciones Ambientales'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'EC Escurrimiento (1ra Medición)', 'numero', 'mS/cm', NULL, 10, TRUE, NULL, 6, 'Conductividad eléctrica del escurrimiento', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Registro de Escorrentía y Condiciones Ambientales'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'ML Corrección', 'numero', 'ml', NULL, 2000, FALSE, NULL, 7, 'Mililitros aplicados en corrección', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Registro de Escorrentía y Condiciones Ambientales'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'pH Corrección', 'numero', NULL, NULL, 14, FALSE, NULL, 8, 'pH tras corrección', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Registro de Escorrentía y Condiciones Ambientales'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'EC Corrección', 'numero', 'mS/cm', NULL, 10, FALSE, NULL, 9, 'EC tras corrección', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Registro de Escorrentía y Condiciones Ambientales'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'pH Riego', 'numero', NULL, NULL, 14, TRUE, NULL, 10, 'pH de la solución de riego', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Registro de Escorrentía y Condiciones Ambientales'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'EC Riego', 'numero', 'mS/cm', NULL, 10, TRUE, NULL, 11, 'EC de la solución de riego', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Registro de Escorrentía y Condiciones Ambientales'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Notas', 'texto', NULL, NULL, NULL, FALSE, NULL, 12, 'Observaciones de la medición', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Registro de Escorrentía y Condiciones Ambientales'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Temperatura Aire', 'numero', '°C', 15, 30, TRUE, NULL, 13, 'Temperatura del ambiente de cultivo/almacenamiento', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Registro de Escorrentía y Condiciones Ambientales'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Humedad Relativa', 'numero', '%', 40, 80, TRUE, NULL, 14, 'Humedad relativa del aire', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Registro de Escorrentía y Condiciones Ambientales'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'VPD', 'numero', 'kPa', 0.8, 2.0, TRUE, NULL, 15, 'Vapor Pressure Deficit (déficit de presión de vapor)', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Registro de Escorrentía y Condiciones Ambientales'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'CO2', 'numero', 'ppm', 400, 1500, TRUE, NULL, 16, 'Concentración de CO2 ambiente', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Registro de Escorrentía y Condiciones Ambientales'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Ventilación', 'seleccion', NULL, NULL, NULL, TRUE, '["Baja", "Media", "Alta"]'::jsonb, 17, 'Nivel de ventilación aplicado en la sala', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Registro de Escorrentía y Condiciones Ambientales'
LIMIT 1;

INSERT INTO subprocesos (proceso_id, nombre, orden, requiere_climatizacion, cm_re_referencia, descripcion, activo)
VALUES (1, 'Disposición Final', 5, FALSE, 'CM-PL-01', 'Registro de disposición final de material vegetal descartado.', TRUE);
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Fecha', 'fecha', NULL, NULL, NULL, TRUE, NULL, 1, 'Fecha de disposición final', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Disposición Final'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'ID Lote', 'texto', NULL, NULL, NULL, TRUE, NULL, 2, 'Identificador del lote dispuesto', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Disposición Final'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Encargado de Disposición Final', 'texto', NULL, NULL, NULL, TRUE, NULL, 3, 'Responsable de la disposición', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Disposición Final'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Destino', 'seleccion_condicional', NULL, NULL, NULL, TRUE, '["Compost", "Residuos Comunes", "Otros"]'::jsonb, 4, 'Destino final del material', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Disposición Final'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Observaciones', 'texto', NULL, NULL, NULL, FALSE, NULL, 5, 'Notas adicionales', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Disposición Final'
LIMIT 1;

INSERT INTO subprocesos (proceso_id, nombre, orden, requiere_climatizacion, cm_re_referencia, descripcion, activo)
VALUES (1, 'Aplicación de Agroquímicos', 6, FALSE, 'CM-RE-0504', 'Registro de aplicación de fitosanitarios/agroquímicos en Planta Madre.', TRUE);
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Fecha de Aplicación', 'fecha', NULL, NULL, NULL, TRUE, NULL, 1, 'Fecha de aplicación del producto', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Aplicación de Agroquímicos'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'ID de Lote', 'texto', NULL, NULL, NULL, TRUE, NULL, 2, 'Lote tratado', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Aplicación de Agroquímicos'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Variedad', 'seleccion_condicional', NULL, NULL, NULL, TRUE, '["Pete Hope", "Otros"]'::jsonb, 3, 'Variedad/cepa tratada', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Aplicación de Agroquímicos'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Ubicación de Lote', 'texto', NULL, NULL, NULL, TRUE, NULL, 4, 'Ubicación física del lote', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Aplicación de Agroquímicos'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Objetivo', 'texto', NULL, NULL, NULL, TRUE, NULL, 5, 'Objetivo de la aplicación (plaga/enfermedad objetivo)', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Aplicación de Agroquímicos'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Nombre Comercial del Producto Aplicado', 'texto', NULL, NULL, NULL, TRUE, NULL, 6, 'Producto comercial utilizado', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Aplicación de Agroquímicos'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Ingrediente Activo', 'texto', NULL, NULL, NULL, TRUE, NULL, 7, 'Ingrediente activo del producto', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Aplicación de Agroquímicos'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Dosis', 'numero', 'ml/100L', NULL, 1000, TRUE, NULL, 8, 'Dosis aplicada', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Aplicación de Agroquímicos'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Condiciones Ambientales', 'texto', NULL, NULL, NULL, FALSE, NULL, 9, 'Condiciones ambientales durante la aplicación', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Aplicación de Agroquímicos'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Equipo Utilizado para la Aplicación', 'texto', NULL, NULL, NULL, TRUE, NULL, 10, 'Equipo de aplicación', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Aplicación de Agroquímicos'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Carencia', 'numero', 'días', NULL, 90, TRUE, NULL, 11, 'Días de carencia del producto', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Aplicación de Agroquímicos'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Nombre del Operario', 'texto', NULL, NULL, NULL, TRUE, NULL, 12, 'Operario que aplica', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Aplicación de Agroquímicos'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Asesor que Recomendó la Aplicación', 'texto', NULL, NULL, NULL, FALSE, NULL, 13, 'Asesor técnico/agrónomo', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Aplicación de Agroquímicos'
LIMIT 1;

INSERT INTO subprocesos (proceso_id, nombre, orden, requiere_climatizacion, cm_re_referencia, descripcion, activo)
VALUES (1, 'Mantenimiento de Equipos de Climatización y Ambiente', 7, FALSE, NULL, 'Registro de mantenimiento de Aires Acondicionados, Ventiladores, Deshumidificadores y Humidificadores en Planta Madre. Fuente: cuaderno de campo.', TRUE);
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Tipo de Equipo', 'seleccion', NULL, NULL, NULL, TRUE, '["Aire Acondicionado", "Ventilador", "Deshumidificador", "Humidificador"]'::jsonb, 1, 'Categoría de equipo de climatización intervenido', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Fecha', 'fecha', NULL, NULL, NULL, TRUE, NULL, 2, 'Fecha de la actividad de mantenimiento', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Equipo', 'texto', NULL, NULL, NULL, TRUE, NULL, 3, 'Identificación/código del equipo', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Estado', 'seleccion', NULL, NULL, NULL, TRUE, '["Operativo", "Fuera de Servicio", "En Mantenimiento"]'::jsonb, 4, 'Estado operativo del equipo', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Actividad Realizada', 'texto', NULL, NULL, NULL, TRUE, NULL, 5, 'Descripción de la actividad de mantenimiento realizada', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Responsable', 'texto', NULL, NULL, NULL, FALSE, NULL, 6, 'Persona que realizó el mantenimiento (si distinto al responsable habitual)', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Observaciones', 'texto', NULL, NULL, NULL, FALSE, NULL, 7, 'Notas adicionales; consignar nombre y motivo si el mantenimiento lo realizó alguien distinto al responsable habitual', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;

INSERT INTO subprocesos (proceso_id, nombre, orden, requiere_climatizacion, cm_re_referencia, descripcion, activo)
VALUES (1, 'Historial de Plantas Madres', 8, FALSE, 'CM-RE-0201', 'Trazabilidad y genealogía histórica de plantas madre.', TRUE);
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Código ID', 'texto', NULL, NULL, NULL, TRUE, NULL, 1, 'Código único de la planta madre', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Historial de Plantas Madres'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Fecha de Inicio', 'fecha', NULL, NULL, NULL, TRUE, NULL, 2, 'Fecha de alta de la planta madre', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Historial de Plantas Madres'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Fecha de Baja', 'fecha', NULL, NULL, NULL, FALSE, NULL, 3, 'Fecha de baja (o ''Vigentes'')', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Historial de Plantas Madres'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Sistema', 'seleccion_condicional', NULL, NULL, NULL, TRUE, '["COCO", "RDWC", "Otros"]'::jsonb, 4, 'Sistema de producción', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Historial de Plantas Madres'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Nº Clonación que da origen PM', 'texto', NULL, NULL, NULL, TRUE, NULL, 5, 'Clon de origen', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Historial de Plantas Madres'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'ID Madre que da Origen', 'texto', NULL, NULL, NULL, FALSE, NULL, 6, 'Planta madre progenitora (o ''Inicial'')', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Historial de Plantas Madres'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Camada', 'texto', NULL, NULL, NULL, FALSE, NULL, 7, 'Camada asociada', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Historial de Plantas Madres'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Esquema de Clonación Relacionado', 'texto', NULL, NULL, NULL, FALSE, NULL, 8, 'Esquema/relación de clonación', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Historial de Plantas Madres'
LIMIT 1;

INSERT INTO subprocesos (proceso_id, nombre, orden, requiere_climatizacion, cm_re_referencia, descripcion, activo)
VALUES (1, 'Registro de Observaciones', 9, FALSE, NULL, 'Bitácora de observaciones libres de sala.', TRUE);
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Fecha', 'fecha', NULL, NULL, NULL, TRUE, NULL, 1, 'Fecha de la observación', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Registro de Observaciones'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Observaciones', 'texto', NULL, NULL, NULL, TRUE, NULL, 2, 'Texto libre de observaciones de sala', TRUE
FROM subprocesos 
WHERE proceso_id = 1 AND nombre = 'Registro de Observaciones'
LIMIT 1;

-- Proceso 2: Clonación

INSERT INTO subprocesos (proceso_id, nombre, orden, requiere_climatizacion, cm_re_referencia, descripcion, activo)
VALUES (2, 'HPAC', 1, FALSE, 'CM-RE-0202', 'Registro de clones en sistema HPAC.', TRUE);
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Fecha', 'fecha', NULL, NULL, NULL, TRUE, NULL, 1, 'Fecha de registro', TRUE
FROM subprocesos 
WHERE proceso_id = 2 AND nombre = 'HPAC'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'HPAC N°', 'seleccion', NULL, NULL, NULL, TRUE, '["1", "2", "3", "4"]'::jsonb, 2, 'Número de unidad HPAC', TRUE
FROM subprocesos 
WHERE proceso_id = 2 AND nombre = 'HPAC'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Planta Madre', 'texto', NULL, NULL, NULL, TRUE, NULL, 3, 'Planta madre de origen', TRUE
FROM subprocesos 
WHERE proceso_id = 2 AND nombre = 'HPAC'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Camada', 'texto', NULL, NULL, NULL, TRUE, NULL, 4, 'Camada de los clones', TRUE
FROM subprocesos 
WHERE proceso_id = 2 AND nombre = 'HPAC'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Cantidad de Clones', 'numero', NULL, NULL, 2000, TRUE, NULL, 5, 'Clones colocados', TRUE
FROM subprocesos 
WHERE proceso_id = 2 AND nombre = 'HPAC'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Descarte', 'numero', NULL, NULL, 2000, FALSE, NULL, 6, 'Clones descartados', TRUE
FROM subprocesos 
WHERE proceso_id = 2 AND nombre = 'HPAC'
LIMIT 1;

INSERT INTO subprocesos (proceso_id, nombre, orden, requiere_climatizacion, cm_re_referencia, descripcion, activo)
VALUES (2, 'JIFFY', 2, FALSE, 'CM-RE-0202', 'Registro de clones en sistema JIFFY.', TRUE);
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Fecha', 'fecha', NULL, NULL, NULL, TRUE, NULL, 1, 'Fecha de registro', TRUE
FROM subprocesos 
WHERE proceso_id = 2 AND nombre = 'JIFFY'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Bandejas', 'numero', NULL, NULL, 200, TRUE, NULL, 2, 'Cantidad de bandejas JIFFY', TRUE
FROM subprocesos 
WHERE proceso_id = 2 AND nombre = 'JIFFY'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'N° PM', 'texto', NULL, NULL, NULL, TRUE, NULL, 3, 'Planta madre de origen', TRUE
FROM subprocesos 
WHERE proceso_id = 2 AND nombre = 'JIFFY'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Cantidad de Clones', 'numero', NULL, NULL, 2000, TRUE, NULL, 4, 'Clones colocados en JIFFY', TRUE
FROM subprocesos 
WHERE proceso_id = 2 AND nombre = 'JIFFY'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Descarte', 'numero', NULL, NULL, 2000, FALSE, NULL, 5, 'Clones descartados', TRUE
FROM subprocesos 
WHERE proceso_id = 2 AND nombre = 'JIFFY'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Observaciones', 'texto', NULL, NULL, NULL, FALSE, NULL, 6, 'Notas', TRUE
FROM subprocesos 
WHERE proceso_id = 2 AND nombre = 'JIFFY'
LIMIT 1;

INSERT INTO subprocesos (proceso_id, nombre, orden, requiere_climatizacion, cm_re_referencia, descripcion, activo)
VALUES (2, 'Condiciones Ambientales de Clonación', 3, TRUE, 'CM-RE-0102', 'No presente como planilla dedicada en el cuaderno de campo de Clonación (solo aparece Mantenimiento de Equipos); la Matriz Consolidada lista el registro CM-RE-0102 ''Condiciones Ambientales y Seguimiento Clonación'' como obligatorio (G01). Se agrega por regla de climatización — variable agregada desde Matriz, ausente del cuaderno.', TRUE);
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Temperatura Aire', 'numero', '°C', 15, 30, TRUE, NULL, 1, 'Temperatura del ambiente de cultivo/almacenamiento', TRUE
FROM subprocesos 
WHERE proceso_id = 2 AND nombre = 'Condiciones Ambientales de Clonación'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Humedad Relativa', 'numero', '%', 40, 80, TRUE, NULL, 2, 'Humedad relativa del aire', TRUE
FROM subprocesos 
WHERE proceso_id = 2 AND nombre = 'Condiciones Ambientales de Clonación'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'VPD', 'numero', 'kPa', 0.8, 2.0, TRUE, NULL, 3, 'Vapor Pressure Deficit (déficit de presión de vapor)', TRUE
FROM subprocesos 
WHERE proceso_id = 2 AND nombre = 'Condiciones Ambientales de Clonación'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'CO2', 'numero', 'ppm', 400, 1500, TRUE, NULL, 4, 'Concentración de CO2 ambiente', TRUE
FROM subprocesos 
WHERE proceso_id = 2 AND nombre = 'Condiciones Ambientales de Clonación'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Ventilación', 'seleccion', NULL, NULL, NULL, TRUE, '["Baja", "Media", "Alta"]'::jsonb, 5, 'Nivel de ventilación aplicado en la sala', TRUE
FROM subprocesos 
WHERE proceso_id = 2 AND nombre = 'Condiciones Ambientales de Clonación'
LIMIT 1;

INSERT INTO subprocesos (proceso_id, nombre, orden, requiere_climatizacion, cm_re_referencia, descripcion, activo)
VALUES (2, 'Disposición Final', 4, FALSE, 'CM-PL-01', 'Registro de disposición final de material vegetal descartado.', TRUE);
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Fecha', 'fecha', NULL, NULL, NULL, TRUE, NULL, 1, 'Fecha de disposición final', TRUE
FROM subprocesos 
WHERE proceso_id = 2 AND nombre = 'Disposición Final'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'ID Lote', 'texto', NULL, NULL, NULL, TRUE, NULL, 2, 'Identificador del lote dispuesto', TRUE
FROM subprocesos 
WHERE proceso_id = 2 AND nombre = 'Disposición Final'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Encargado de Disposición Final', 'texto', NULL, NULL, NULL, TRUE, NULL, 3, 'Responsable de la disposición', TRUE
FROM subprocesos 
WHERE proceso_id = 2 AND nombre = 'Disposición Final'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Destino', 'seleccion_condicional', NULL, NULL, NULL, TRUE, '["Compost", "Residuos Comunes", "Otros"]'::jsonb, 4, 'Destino final del material', TRUE
FROM subprocesos 
WHERE proceso_id = 2 AND nombre = 'Disposición Final'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Observaciones', 'texto', NULL, NULL, NULL, FALSE, NULL, 5, 'Notas adicionales', TRUE
FROM subprocesos 
WHERE proceso_id = 2 AND nombre = 'Disposición Final'
LIMIT 1;

INSERT INTO subprocesos (proceso_id, nombre, orden, requiere_climatizacion, cm_re_referencia, descripcion, activo)
VALUES (2, 'Registro de Observaciones', 5, FALSE, NULL, 'Bitácora de observaciones libres de sala.', TRUE);
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Fecha', 'fecha', NULL, NULL, NULL, TRUE, NULL, 1, 'Fecha de la observación', TRUE
FROM subprocesos 
WHERE proceso_id = 2 AND nombre = 'Registro de Observaciones'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Observaciones', 'texto', NULL, NULL, NULL, TRUE, NULL, 2, 'Texto libre de observaciones de sala', TRUE
FROM subprocesos 
WHERE proceso_id = 2 AND nombre = 'Registro de Observaciones'
LIMIT 1;

INSERT INTO subprocesos (proceso_id, nombre, orden, requiere_climatizacion, cm_re_referencia, descripcion, activo)
VALUES (2, 'Mantenimiento de Equipos de Climatización y Ambiente', 6, FALSE, NULL, 'Registro de mantenimiento de Aires Acondicionados, Ventiladores, Deshumidificadores y Humidificadores en Clonación. Fuente: cuaderno de campo.', TRUE);
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Tipo de Equipo', 'seleccion', NULL, NULL, NULL, TRUE, '["Aire Acondicionado", "Ventilador", "Deshumidificador", "Humidificador"]'::jsonb, 1, 'Categoría de equipo de climatización intervenido', TRUE
FROM subprocesos 
WHERE proceso_id = 2 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Fecha', 'fecha', NULL, NULL, NULL, TRUE, NULL, 2, 'Fecha de la actividad de mantenimiento', TRUE
FROM subprocesos 
WHERE proceso_id = 2 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Equipo', 'texto', NULL, NULL, NULL, TRUE, NULL, 3, 'Identificación/código del equipo', TRUE
FROM subprocesos 
WHERE proceso_id = 2 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Estado', 'seleccion', NULL, NULL, NULL, TRUE, '["Operativo", "Fuera de Servicio", "En Mantenimiento"]'::jsonb, 4, 'Estado operativo del equipo', TRUE
FROM subprocesos 
WHERE proceso_id = 2 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Actividad Realizada', 'texto', NULL, NULL, NULL, TRUE, NULL, 5, 'Descripción de la actividad de mantenimiento realizada', TRUE
FROM subprocesos 
WHERE proceso_id = 2 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Responsable', 'texto', NULL, NULL, NULL, FALSE, NULL, 6, 'Persona que realizó el mantenimiento (si distinto al responsable habitual)', TRUE
FROM subprocesos 
WHERE proceso_id = 2 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Observaciones', 'texto', NULL, NULL, NULL, FALSE, NULL, 7, 'Notas adicionales; consignar nombre y motivo si el mantenimiento lo realizó alguien distinto al responsable habitual', TRUE
FROM subprocesos 
WHERE proceso_id = 2 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;

-- Proceso 3: Floración 1

INSERT INTO subprocesos (proceso_id, nombre, orden, requiere_climatizacion, cm_re_referencia, descripcion, activo)
VALUES (3, 'Labores Culturales', 1, FALSE, 'CM-RE-0203', 'Labores culturales en sala de Floración 1.', TRUE);
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Fecha', 'fecha', NULL, NULL, NULL, TRUE, NULL, 1, 'Fecha de la labor', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Labores Culturales'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'N° Lote', 'texto', NULL, NULL, NULL, TRUE, NULL, 2, 'Lote intervenido', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Labores Culturales'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Poda de Limpieza', 'booleano', NULL, NULL, NULL, FALSE, NULL, 3, 'Se realizó poda de limpieza', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Labores Culturales'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Poda de Formación', 'booleano', NULL, NULL, NULL, FALSE, NULL, 4, 'Se realizó poda de formación', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Labores Culturales'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Colocación de Trampa', 'booleano', NULL, NULL, NULL, FALSE, NULL, 5, 'Se colocó trampa fitosanitaria', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Labores Culturales'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Colocación de Red', 'booleano', NULL, NULL, NULL, FALSE, NULL, 6, 'Se colocó red de sostén', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Labores Culturales'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Responsable', 'texto', NULL, NULL, NULL, TRUE, NULL, 7, 'Quién ejecuta la labor', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Labores Culturales'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Indicado por', 'texto', NULL, NULL, NULL, FALSE, NULL, 8, 'Quién indicó la labor', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Labores Culturales'
LIMIT 1;

INSERT INTO subprocesos (proceso_id, nombre, orden, requiere_climatizacion, cm_re_referencia, descripcion, activo)
VALUES (3, 'Disposición Final', 2, FALSE, 'CM-PL-01', 'Registro de disposición final de material vegetal descartado.', TRUE);
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Fecha', 'fecha', NULL, NULL, NULL, TRUE, NULL, 1, 'Fecha de disposición final', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Disposición Final'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'ID Lote', 'texto', NULL, NULL, NULL, TRUE, NULL, 2, 'Identificador del lote dispuesto', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Disposición Final'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Encargado de Disposición Final', 'texto', NULL, NULL, NULL, TRUE, NULL, 3, 'Responsable de la disposición', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Disposición Final'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Destino', 'seleccion_condicional', NULL, NULL, NULL, TRUE, '["Compost", "Residuos Comunes", "Otros"]'::jsonb, 4, 'Destino final del material', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Disposición Final'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Observaciones', 'texto', NULL, NULL, NULL, FALSE, NULL, 5, 'Notas adicionales', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Disposición Final'
LIMIT 1;

INSERT INTO subprocesos (proceso_id, nombre, orden, requiere_climatizacion, cm_re_referencia, descripcion, activo)
VALUES (3, 'Registro de Escorrentía', 3, TRUE, 'CM-RE-0104', 'Medición de escurrimiento y condiciones ambientales en Floración 1.', TRUE);
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Fecha Última Medición', 'fecha', NULL, NULL, NULL, FALSE, NULL, 1, 'Fecha de la medición anterior', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Registro de Escorrentía'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Fecha Actual', 'fecha', NULL, NULL, NULL, TRUE, NULL, 2, 'Fecha de la medición actual', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Registro de Escorrentía'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'ID Planta', 'texto', NULL, NULL, NULL, TRUE, NULL, 3, 'Identificador de planta (PM.1 a PM.12)', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Registro de Escorrentía'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'ML Escurrimiento (1ra Medición)', 'numero', 'ml', NULL, 2000, TRUE, NULL, 4, 'Mililitros de escurrimiento', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Registro de Escorrentía'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'pH Escurrimiento (1ra Medición)', 'numero', NULL, NULL, 14, TRUE, NULL, 5, 'pH del escurrimiento', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Registro de Escorrentía'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'EC Escurrimiento (1ra Medición)', 'numero', 'mS/cm', NULL, 10, TRUE, NULL, 6, 'EC del escurrimiento', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Registro de Escorrentía'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'ML Corrección', 'numero', 'ml', NULL, 2000, FALSE, NULL, 7, 'Mililitros aplicados en corrección', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Registro de Escorrentía'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'pH Corrección', 'numero', NULL, NULL, 14, FALSE, NULL, 8, 'pH tras corrección', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Registro de Escorrentía'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'EC Corrección', 'numero', 'mS/cm', NULL, 10, FALSE, NULL, 9, 'EC tras corrección', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Registro de Escorrentía'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'pH Riego', 'numero', NULL, NULL, 14, TRUE, NULL, 10, 'pH de la solución de riego', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Registro de Escorrentía'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'EC Riego', 'numero', 'mS/cm', NULL, 10, TRUE, NULL, 11, 'EC de la solución de riego', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Registro de Escorrentía'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Notas', 'texto', NULL, NULL, NULL, FALSE, NULL, 12, 'Observaciones de la medición', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Registro de Escorrentía'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Temperatura Aire', 'numero', '°C', 15, 30, TRUE, NULL, 13, 'Temperatura del ambiente de cultivo/almacenamiento', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Registro de Escorrentía'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Humedad Relativa', 'numero', '%', 40, 80, TRUE, NULL, 14, 'Humedad relativa del aire', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Registro de Escorrentía'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'VPD', 'numero', 'kPa', 0.8, 2.0, TRUE, NULL, 15, 'Vapor Pressure Deficit (déficit de presión de vapor)', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Registro de Escorrentía'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'CO2', 'numero', 'ppm', 400, 1500, TRUE, NULL, 16, 'Concentración de CO2 ambiente', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Registro de Escorrentía'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Ventilación', 'seleccion', NULL, NULL, NULL, TRUE, '["Baja", "Media", "Alta"]'::jsonb, 17, 'Nivel de ventilación aplicado en la sala', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Registro de Escorrentía'
LIMIT 1;

INSERT INTO subprocesos (proceso_id, nombre, orden, requiere_climatizacion, cm_re_referencia, descripcion, activo)
VALUES (3, 'Calibración de Riego', 4, FALSE, 'CM-PL-02', 'Calibración de disparos de riego automático en Floración 1.', TRUE);
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Fecha', 'fecha', NULL, NULL, NULL, TRUE, NULL, 1, 'Fecha de calibración', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Calibración de Riego'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'PM N°', 'texto', NULL, NULL, NULL, TRUE, NULL, 2, 'Identificador de planta/lote (PM N°1 a N°12)', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Calibración de Riego'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Disparo N°', 'seleccion', NULL, NULL, NULL, TRUE, '["1", "2", "3", "4", "5"]'::jsonb, 3, 'Número de disparo de riego automático', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Calibración de Riego'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Tiempo Disparo', 'numero', 'min', NULL, 60, TRUE, NULL, 4, 'Duración del disparo', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Calibración de Riego'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'ml Aplicados', 'numero', 'ml', NULL, 5000, TRUE, NULL, 5, 'Volumen aplicado', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Calibración de Riego'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Tiempo de Testigo', 'numero', 'min', NULL, 60, FALSE, NULL, 6, 'Minutos de testigo de riego automático', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Calibración de Riego'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Observaciones', 'texto', NULL, NULL, NULL, FALSE, NULL, 7, 'Notas de calibración', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Calibración de Riego'
LIMIT 1;

INSERT INTO subprocesos (proceso_id, nombre, orden, requiere_climatizacion, cm_re_referencia, descripcion, activo)
VALUES (3, 'Mantenimiento de Equipos de Climatización y Ambiente', 5, FALSE, NULL, 'Registro de mantenimiento de Aires Acondicionados, Ventiladores, Deshumidificadores y Humidificadores en Floración 1. Fuente: cuaderno de campo.', TRUE);
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Tipo de Equipo', 'seleccion', NULL, NULL, NULL, TRUE, '["Aire Acondicionado", "Ventilador", "Deshumidificador", "Humidificador"]'::jsonb, 1, 'Categoría de equipo de climatización intervenido', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Fecha', 'fecha', NULL, NULL, NULL, TRUE, NULL, 2, 'Fecha de la actividad de mantenimiento', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Equipo', 'texto', NULL, NULL, NULL, TRUE, NULL, 3, 'Identificación/código del equipo', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Estado', 'seleccion', NULL, NULL, NULL, TRUE, '["Operativo", "Fuera de Servicio", "En Mantenimiento"]'::jsonb, 4, 'Estado operativo del equipo', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Actividad Realizada', 'texto', NULL, NULL, NULL, TRUE, NULL, 5, 'Descripción de la actividad de mantenimiento realizada', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Responsable', 'texto', NULL, NULL, NULL, FALSE, NULL, 6, 'Persona que realizó el mantenimiento (si distinto al responsable habitual)', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Observaciones', 'texto', NULL, NULL, NULL, FALSE, NULL, 7, 'Notas adicionales; consignar nombre y motivo si el mantenimiento lo realizó alguien distinto al responsable habitual', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;

INSERT INTO subprocesos (proceso_id, nombre, orden, requiere_climatizacion, cm_re_referencia, descripcion, activo)
VALUES (3, 'Aplicación de Fitosanitarios', 6, FALSE, 'CM-RE-0504', 'Aplicación de fitosanitarios en Floración 1.', TRUE);
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Fecha de Aplicación', 'fecha', NULL, NULL, NULL, TRUE, NULL, 1, 'Fecha de aplicación del fitosanitario', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Aplicación de Fitosanitarios'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'ID Lote', 'texto', NULL, NULL, NULL, TRUE, NULL, 2, 'Lote tratado', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Aplicación de Fitosanitarios'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Ubicación Lote', 'texto', NULL, NULL, NULL, TRUE, NULL, 3, 'Ubicación física del lote', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Aplicación de Fitosanitarios'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Objetivo', 'texto', NULL, NULL, NULL, TRUE, NULL, 4, 'Objetivo de la aplicación', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Aplicación de Fitosanitarios'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Variedad', 'seleccion_condicional', NULL, NULL, NULL, TRUE, '["Pete Hope", "Otros"]'::jsonb, 5, 'Variedad tratada', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Aplicación de Fitosanitarios'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Nombre Comercial Producto Aplicado', 'texto', NULL, NULL, NULL, TRUE, NULL, 6, 'Producto comercial', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Aplicación de Fitosanitarios'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Ingrediente Activo Producto Aplicado', 'texto', NULL, NULL, NULL, TRUE, NULL, 7, 'Ingrediente activo', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Aplicación de Fitosanitarios'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Dosis', 'numero', 'ml/100L', NULL, 1000, TRUE, NULL, 8, 'Dosis aplicada', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Aplicación de Fitosanitarios'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Condiciones Ambientales', 'texto', NULL, NULL, NULL, FALSE, NULL, 9, 'Condiciones durante la aplicación', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Aplicación de Fitosanitarios'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Equipo Utilizado para la Aplicación', 'texto', NULL, NULL, NULL, TRUE, NULL, 10, 'Equipo de aplicación', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Aplicación de Fitosanitarios'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Carencia', 'numero', 'días', NULL, 90, TRUE, NULL, 11, 'Días de carencia', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Aplicación de Fitosanitarios'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Nombre del Operario', 'texto', NULL, NULL, NULL, TRUE, NULL, 12, 'Operario que aplica', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Aplicación de Fitosanitarios'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Asesor que Recomendó la Aplicación', 'texto', NULL, NULL, NULL, FALSE, NULL, 13, 'Asesor técnico', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Aplicación de Fitosanitarios'
LIMIT 1;

INSERT INTO subprocesos (proceso_id, nombre, orden, requiere_climatizacion, cm_re_referencia, descripcion, activo)
VALUES (3, 'Condiciones Ambientales Etapa Vegetativa', 7, TRUE, 'CM-RE-0105', 'No presente como planilla propia en los cuadernos de Floración 1/2; la Matriz Consolidada define el registro CM-RE-0105 ''Condiciones Ambientales – Etapa Vegetativa'' (G01, obligatorio). Se agrega por regla de climatización — gap identificado entre Matriz y cuadernos. Datos reales en hoja CM-RE-0105 incluyen Sistema (COCO/RDWC), ID Lote, Presencia de Insectos y Presencia de Hongos (booleanos) que deberían incorporarse.', TRUE);
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Temperatura Aire', 'numero', '°C', 15, 30, TRUE, NULL, 1, 'Temperatura del ambiente de cultivo/almacenamiento', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Condiciones Ambientales Etapa Vegetativa'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Humedad Relativa', 'numero', '%', 40, 80, TRUE, NULL, 2, 'Humedad relativa del aire', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Condiciones Ambientales Etapa Vegetativa'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'VPD', 'numero', 'kPa', 0.8, 2.0, TRUE, NULL, 3, 'Vapor Pressure Deficit (déficit de presión de vapor)', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Condiciones Ambientales Etapa Vegetativa'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'CO2', 'numero', 'ppm', 400, 1500, TRUE, NULL, 4, 'Concentración de CO2 ambiente', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Condiciones Ambientales Etapa Vegetativa'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Ventilación', 'seleccion', NULL, NULL, NULL, TRUE, '["Baja", "Media", "Alta"]'::jsonb, 5, 'Nivel de ventilación aplicado en la sala', TRUE
FROM subprocesos 
WHERE proceso_id = 3 AND nombre = 'Condiciones Ambientales Etapa Vegetativa'
LIMIT 1;

-- Proceso 4: Floración 2

INSERT INTO subprocesos (proceso_id, nombre, orden, requiere_climatizacion, cm_re_referencia, descripcion, activo)
VALUES (4, 'Labores Culturales', 1, FALSE, 'CM-RE-0203', 'Labores culturales en sala de Floración 2.', TRUE);
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Fecha', 'fecha', NULL, NULL, NULL, TRUE, NULL, 1, 'Fecha de la labor', TRUE
FROM subprocesos 
WHERE proceso_id = 4 AND nombre = 'Labores Culturales'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'N° Lote', 'texto', NULL, NULL, NULL, TRUE, NULL, 2, 'Lote intervenido', TRUE
FROM subprocesos 
WHERE proceso_id = 4 AND nombre = 'Labores Culturales'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Poda de Limpieza', 'booleano', NULL, NULL, NULL, FALSE, NULL, 3, 'Se realizó poda de limpieza', TRUE
FROM subprocesos 
WHERE proceso_id = 4 AND nombre = 'Labores Culturales'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Poda de Formación', 'booleano', NULL, NULL, NULL, FALSE, NULL, 4, 'Se realizó poda de formación', TRUE
FROM subprocesos 
WHERE proceso_id = 4 AND nombre = 'Labores Culturales'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Colocación de Trampa', 'booleano', NULL, NULL, NULL, FALSE, NULL, 5, 'Se colocó trampa fitosanitaria', TRUE
FROM subprocesos 
WHERE proceso_id = 4 AND nombre = 'Labores Culturales'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Colocación de Red', 'booleano', NULL, NULL, NULL, FALSE, NULL, 6, 'Se colocó red de sostén', TRUE
FROM subprocesos 
WHERE proceso_id = 4 AND nombre = 'Labores Culturales'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Responsable', 'texto', NULL, NULL, NULL, TRUE, NULL, 7, 'Quién ejecuta la labor', TRUE
FROM subprocesos 
WHERE proceso_id = 4 AND nombre = 'Labores Culturales'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Indicado por', 'texto', NULL, NULL, NULL, FALSE, NULL, 8, 'Quién indicó la labor', TRUE
FROM subprocesos 
WHERE proceso_id = 4 AND nombre = 'Labores Culturales'
LIMIT 1;

INSERT INTO subprocesos (proceso_id, nombre, orden, requiere_climatizacion, cm_re_referencia, descripcion, activo)
VALUES (4, 'Disposición Final', 2, FALSE, 'CM-PL-01', 'Registro de disposición final de material vegetal descartado.', TRUE);
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Fecha', 'fecha', NULL, NULL, NULL, TRUE, NULL, 1, 'Fecha de disposición final', TRUE
FROM subprocesos 
WHERE proceso_id = 4 AND nombre = 'Disposición Final'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'ID Lote', 'texto', NULL, NULL, NULL, TRUE, NULL, 2, 'Identificador del lote dispuesto', TRUE
FROM subprocesos 
WHERE proceso_id = 4 AND nombre = 'Disposición Final'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Encargado de Disposición Final', 'texto', NULL, NULL, NULL, TRUE, NULL, 3, 'Responsable de la disposición', TRUE
FROM subprocesos 
WHERE proceso_id = 4 AND nombre = 'Disposición Final'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Destino', 'seleccion_condicional', NULL, NULL, NULL, TRUE, '["Compost", "Residuos Comunes", "Otros"]'::jsonb, 4, 'Destino final del material', TRUE
FROM subprocesos 
WHERE proceso_id = 4 AND nombre = 'Disposición Final'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Observaciones', 'texto', NULL, NULL, NULL, FALSE, NULL, 5, 'Notas adicionales', TRUE
FROM subprocesos 
WHERE proceso_id = 4 AND nombre = 'Disposición Final'
LIMIT 1;

INSERT INTO subprocesos (proceso_id, nombre, orden, requiere_climatizacion, cm_re_referencia, descripcion, activo)
VALUES (4, 'Mantenimiento de Equipos de Climatización y Ambiente', 3, FALSE, NULL, 'Registro de mantenimiento de Aires Acondicionados, Ventiladores, Deshumidificadores y Humidificadores en Floración 2. Fuente: cuaderno de campo.', TRUE);
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Tipo de Equipo', 'seleccion', NULL, NULL, NULL, TRUE, '["Aire Acondicionado", "Ventilador", "Deshumidificador", "Humidificador"]'::jsonb, 1, 'Categoría de equipo de climatización intervenido', TRUE
FROM subprocesos 
WHERE proceso_id = 4 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Fecha', 'fecha', NULL, NULL, NULL, TRUE, NULL, 2, 'Fecha de la actividad de mantenimiento', TRUE
FROM subprocesos 
WHERE proceso_id = 4 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Equipo', 'texto', NULL, NULL, NULL, TRUE, NULL, 3, 'Identificación/código del equipo', TRUE
FROM subprocesos 
WHERE proceso_id = 4 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Estado', 'seleccion', NULL, NULL, NULL, TRUE, '["Operativo", "Fuera de Servicio", "En Mantenimiento"]'::jsonb, 4, 'Estado operativo del equipo', TRUE
FROM subprocesos 
WHERE proceso_id = 4 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Actividad Realizada', 'texto', NULL, NULL, NULL, TRUE, NULL, 5, 'Descripción de la actividad de mantenimiento realizada', TRUE
FROM subprocesos 
WHERE proceso_id = 4 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Responsable', 'texto', NULL, NULL, NULL, FALSE, NULL, 6, 'Persona que realizó el mantenimiento (si distinto al responsable habitual)', TRUE
FROM subprocesos 
WHERE proceso_id = 4 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Observaciones', 'texto', NULL, NULL, NULL, FALSE, NULL, 7, 'Notas adicionales; consignar nombre y motivo si el mantenimiento lo realizó alguien distinto al responsable habitual', TRUE
FROM subprocesos 
WHERE proceso_id = 4 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;

INSERT INTO subprocesos (proceso_id, nombre, orden, requiere_climatizacion, cm_re_referencia, descripcion, activo)
VALUES (4, 'Aplicación de Fitosanitarios', 4, FALSE, 'CM-RE-0504', 'Aplicación de fitosanitarios en Floración 2.', TRUE);
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Fecha de Aplicación', 'fecha', NULL, NULL, NULL, TRUE, NULL, 1, 'Fecha de aplicación del fitosanitario', TRUE
FROM subprocesos 
WHERE proceso_id = 4 AND nombre = 'Aplicación de Fitosanitarios'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'ID Lote', 'texto', NULL, NULL, NULL, TRUE, NULL, 2, 'Lote tratado', TRUE
FROM subprocesos 
WHERE proceso_id = 4 AND nombre = 'Aplicación de Fitosanitarios'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Ubicación Lote', 'texto', NULL, NULL, NULL, TRUE, NULL, 3, 'Ubicación física del lote', TRUE
FROM subprocesos 
WHERE proceso_id = 4 AND nombre = 'Aplicación de Fitosanitarios'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Objetivo', 'texto', NULL, NULL, NULL, TRUE, NULL, 4, 'Objetivo de la aplicación', TRUE
FROM subprocesos 
WHERE proceso_id = 4 AND nombre = 'Aplicación de Fitosanitarios'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Variedad', 'seleccion_condicional', NULL, NULL, NULL, TRUE, '["Pete Hope", "Otros"]'::jsonb, 5, 'Variedad tratada', TRUE
FROM subprocesos 
WHERE proceso_id = 4 AND nombre = 'Aplicación de Fitosanitarios'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Nombre Comercial Producto Aplicado', 'texto', NULL, NULL, NULL, TRUE, NULL, 6, 'Producto comercial', TRUE
FROM subprocesos 
WHERE proceso_id = 4 AND nombre = 'Aplicación de Fitosanitarios'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Ingrediente Activo Producto Aplicado', 'texto', NULL, NULL, NULL, TRUE, NULL, 7, 'Ingrediente activo', TRUE
FROM subprocesos 
WHERE proceso_id = 4 AND nombre = 'Aplicación de Fitosanitarios'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Dosis', 'numero', 'ml/100L', NULL, 1000, TRUE, NULL, 8, 'Dosis aplicada', TRUE
FROM subprocesos 
WHERE proceso_id = 4 AND nombre = 'Aplicación de Fitosanitarios'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Condiciones Ambientales', 'texto', NULL, NULL, NULL, FALSE, NULL, 9, 'Condiciones durante la aplicación', TRUE
FROM subprocesos 
WHERE proceso_id = 4 AND nombre = 'Aplicación de Fitosanitarios'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Equipo Utilizado para la Aplicación', 'texto', NULL, NULL, NULL, TRUE, NULL, 10, 'Equipo de aplicación', TRUE
FROM subprocesos 
WHERE proceso_id = 4 AND nombre = 'Aplicación de Fitosanitarios'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Carencia', 'numero', 'días', NULL, 90, TRUE, NULL, 11, 'Días de carencia', TRUE
FROM subprocesos 
WHERE proceso_id = 4 AND nombre = 'Aplicación de Fitosanitarios'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Nombre del Operario', 'texto', NULL, NULL, NULL, TRUE, NULL, 12, 'Operario que aplica', TRUE
FROM subprocesos 
WHERE proceso_id = 4 AND nombre = 'Aplicación de Fitosanitarios'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Asesor que Recomendó la Aplicación', 'texto', NULL, NULL, NULL, FALSE, NULL, 13, 'Asesor técnico', TRUE
FROM subprocesos 
WHERE proceso_id = 4 AND nombre = 'Aplicación de Fitosanitarios'
LIMIT 1;

INSERT INTO subprocesos (proceso_id, nombre, orden, requiere_climatizacion, cm_re_referencia, descripcion, activo)
VALUES (4, 'Condiciones Ambientales de Floración 2', 5, TRUE, 'CM-RE-0104', 'No presente como planilla propia en el cuaderno de Floración 2 (a diferencia de Floración 1, no incluye página de Registro de Escorrentía); la Matriz Consolidada exige CM-RE-0104 para toda sala de floración. Se agrega por regla de climatización — gap identificado entre Matriz y cuaderno.', TRUE);
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Temperatura Aire', 'numero', '°C', 15, 30, TRUE, NULL, 1, 'Temperatura del ambiente de cultivo/almacenamiento', TRUE
FROM subprocesos 
WHERE proceso_id = 4 AND nombre = 'Condiciones Ambientales de Floración 2'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Humedad Relativa', 'numero', '%', 40, 80, TRUE, NULL, 2, 'Humedad relativa del aire', TRUE
FROM subprocesos 
WHERE proceso_id = 4 AND nombre = 'Condiciones Ambientales de Floración 2'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'VPD', 'numero', 'kPa', 0.8, 2.0, TRUE, NULL, 3, 'Vapor Pressure Deficit (déficit de presión de vapor)', TRUE
FROM subprocesos 
WHERE proceso_id = 4 AND nombre = 'Condiciones Ambientales de Floración 2'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'CO2', 'numero', 'ppm', 400, 1500, TRUE, NULL, 4, 'Concentración de CO2 ambiente', TRUE
FROM subprocesos 
WHERE proceso_id = 4 AND nombre = 'Condiciones Ambientales de Floración 2'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Ventilación', 'seleccion', NULL, NULL, NULL, TRUE, '["Baja", "Media", "Alta"]'::jsonb, 5, 'Nivel de ventilación aplicado en la sala', TRUE
FROM subprocesos 
WHERE proceso_id = 4 AND nombre = 'Condiciones Ambientales de Floración 2'
LIMIT 1;

-- Proceso 5: Monitoreo de Plagas y Enfermedades

INSERT INTO subprocesos (proceso_id, nombre, orden, requiere_climatizacion, cm_re_referencia, descripcion, activo)
VALUES (5, 'Monitoreo de Plagas', 1, FALSE, 'CM-RE-0502', 'Monitoreo periódico de plagas por área de cultivo.', TRUE);
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Área', 'seleccion', NULL, NULL, NULL, TRUE, '["Plantas Madres", "Clonaci\u00f3n", "Vegetaci\u00f3n", "Floraci\u00f3n", "Secado", "Almacenamiento"]'::jsonb, 1, 'Área monitoreada', TRUE
FROM subprocesos 
WHERE proceso_id = 5 AND nombre = 'Monitoreo de Plagas'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Temporada', 'texto', NULL, NULL, NULL, TRUE, NULL, 2, 'Temporada de cultivo', TRUE
FROM subprocesos 
WHERE proceso_id = 5 AND nombre = 'Monitoreo de Plagas'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Cultivo', 'texto', NULL, NULL, NULL, TRUE, NULL, 3, 'Identificación del cultivo', TRUE
FROM subprocesos 
WHERE proceso_id = 5 AND nombre = 'Monitoreo de Plagas'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Encargado/a del Monitoreo', 'texto', NULL, NULL, NULL, TRUE, NULL, 4, 'Responsable del monitoreo', TRUE
FROM subprocesos 
WHERE proceso_id = 5 AND nombre = 'Monitoreo de Plagas'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Variedad', 'seleccion_condicional', NULL, NULL, NULL, TRUE, '["Pete Hope", "Otros"]'::jsonb, 5, 'Variedad monitoreada', TRUE
FROM subprocesos 
WHERE proceso_id = 5 AND nombre = 'Monitoreo de Plagas'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Fecha', 'fecha', NULL, NULL, NULL, TRUE, NULL, 6, 'Fecha del monitoreo', TRUE
FROM subprocesos 
WHERE proceso_id = 5 AND nombre = 'Monitoreo de Plagas'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Plaga Detectada', 'seleccion_condicional', NULL, NULL, NULL, TRUE, '["\u00c1caros", "Trips", "Mosca Blanca", "Pulgones", "Mosquita de Mantillo", "Cochinillas", "Otras"]'::jsonb, 7, 'Tipo de plaga observada', TRUE
FROM subprocesos 
WHERE proceso_id = 5 AND nombre = 'Monitoreo de Plagas'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Nivel de Infestación', 'seleccion', NULL, NULL, NULL, TRUE, '["Bajo", "Medio", "Alto"]'::jsonb, 8, 'Nivel de infestación observado', TRUE
FROM subprocesos 
WHERE proceso_id = 5 AND nombre = 'Monitoreo de Plagas'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Check', 'booleano', NULL, NULL, NULL, FALSE, NULL, 9, 'Casillero de verificación del monitoreo', TRUE
FROM subprocesos 
WHERE proceso_id = 5 AND nombre = 'Monitoreo de Plagas'
LIMIT 1;

INSERT INTO subprocesos (proceso_id, nombre, orden, requiere_climatizacion, cm_re_referencia, descripcion, activo)
VALUES (5, 'Monitoreo de Enfermedades', 2, FALSE, 'CM-RE-0502', 'Monitoreo periódico de enfermedades fúngicas por área de cultivo. Nota: el cuaderno no lista explícitamente los nombres de enfermedades por columna (solo ''Nivel de Infestación'' x5); la Matriz (hoja CM-RE-0502) confirma códigos B=Botritis/O=Oidio/M=Mildiu/F=Fusarium/P=Phytium usados como leyenda.', TRUE);
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Área', 'seleccion', NULL, NULL, NULL, TRUE, '["Plantas Madres", "Clonaci\u00f3n", "Vegetaci\u00f3n", "Floraci\u00f3n", "Secado", "Almacenamiento"]'::jsonb, 1, 'Área monitoreada', TRUE
FROM subprocesos 
WHERE proceso_id = 5 AND nombre = 'Monitoreo de Enfermedades'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Temporada', 'texto', NULL, NULL, NULL, TRUE, NULL, 2, 'Temporada de cultivo', TRUE
FROM subprocesos 
WHERE proceso_id = 5 AND nombre = 'Monitoreo de Enfermedades'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Cultivo', 'texto', NULL, NULL, NULL, TRUE, NULL, 3, 'Identificación del cultivo', TRUE
FROM subprocesos 
WHERE proceso_id = 5 AND nombre = 'Monitoreo de Enfermedades'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Encargado/a del Monitoreo', 'texto', NULL, NULL, NULL, TRUE, NULL, 4, 'Responsable del monitoreo', TRUE
FROM subprocesos 
WHERE proceso_id = 5 AND nombre = 'Monitoreo de Enfermedades'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Variedad', 'seleccion_condicional', NULL, NULL, NULL, TRUE, '["Pete Hope", "Otros"]'::jsonb, 5, 'Variedad monitoreada', TRUE
FROM subprocesos 
WHERE proceso_id = 5 AND nombre = 'Monitoreo de Enfermedades'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Fecha', 'fecha', NULL, NULL, NULL, TRUE, NULL, 6, 'Fecha del monitoreo', TRUE
FROM subprocesos 
WHERE proceso_id = 5 AND nombre = 'Monitoreo de Enfermedades'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Enfermedad Detectada', 'seleccion_condicional', NULL, NULL, NULL, TRUE, '["Botritis", "Oidio", "Mildiu", "Fusarium", "Phytium", "Otros"]'::jsonb, 7, 'Tipo de enfermedad observada', TRUE
FROM subprocesos 
WHERE proceso_id = 5 AND nombre = 'Monitoreo de Enfermedades'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Nivel de Infestación', 'seleccion', NULL, NULL, NULL, TRUE, '["Bajo", "Medio", "Alto"]'::jsonb, 8, 'Nivel de afectación observado', TRUE
FROM subprocesos 
WHERE proceso_id = 5 AND nombre = 'Monitoreo de Enfermedades'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Check', 'booleano', NULL, NULL, NULL, FALSE, NULL, 9, 'Casillero de verificación del monitoreo', TRUE
FROM subprocesos 
WHERE proceso_id = 5 AND nombre = 'Monitoreo de Enfermedades'
LIMIT 1;

INSERT INTO subprocesos (proceso_id, nombre, orden, requiere_climatizacion, cm_re_referencia, descripcion, activo)
VALUES (5, 'Control de Roedores', 3, FALSE, 'CM-RE-0501', 'Control periódico de roedores.', TRUE);
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Fecha de Control', 'fecha', NULL, NULL, NULL, TRUE, NULL, 1, 'Fecha de control', TRUE
FROM subprocesos 
WHERE proceso_id = 5 AND nombre = 'Control de Roedores'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Control', 'booleano', NULL, NULL, NULL, TRUE, NULL, 2, 'Se realizó el control', TRUE
FROM subprocesos 
WHERE proceso_id = 5 AND nombre = 'Control de Roedores'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Reposición', 'booleano', NULL, NULL, NULL, FALSE, NULL, 3, 'Se repuso cebo/trampa', TRUE
FROM subprocesos 
WHERE proceso_id = 5 AND nombre = 'Control de Roedores'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Responsable', 'texto', NULL, NULL, NULL, TRUE, NULL, 4, 'Responsable del control', TRUE
FROM subprocesos 
WHERE proceso_id = 5 AND nombre = 'Control de Roedores'
LIMIT 1;

-- Proceso 6: Cosecha

INSERT INTO subprocesos (proceso_id, nombre, orden, requiere_climatizacion, cm_re_referencia, descripcion, activo)
VALUES (6, 'Certificado de Cosecha', 1, FALSE, 'CM-RE-0601', 'Certificado y liberación formal de cosecha.', TRUE);
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Fecha de Emisión', 'fecha', NULL, NULL, NULL, TRUE, NULL, 1, 'Fecha de emisión del certificado', TRUE
FROM subprocesos 
WHERE proceso_id = 6 AND nombre = 'Certificado de Cosecha'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Camada', 'texto', NULL, NULL, NULL, TRUE, NULL, 2, 'Camada cosechada', TRUE
FROM subprocesos 
WHERE proceso_id = 6 AND nombre = 'Certificado de Cosecha'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Fila', 'texto', NULL, NULL, NULL, TRUE, NULL, 3, 'Fila cosechada', TRUE
FROM subprocesos 
WHERE proceso_id = 6 AND nombre = 'Certificado de Cosecha'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Fecha Transplante', 'fecha', NULL, NULL, NULL, TRUE, NULL, 4, 'Fecha de trasplante del lote', TRUE
FROM subprocesos 
WHERE proceso_id = 6 AND nombre = 'Certificado de Cosecha'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Fecha Cosecha', 'fecha', NULL, NULL, NULL, TRUE, NULL, 5, 'Fecha de cosecha', TRUE
FROM subprocesos 
WHERE proceso_id = 6 AND nombre = 'Certificado de Cosecha'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Plantas Cosechadas', 'numero', NULL, NULL, 500, TRUE, NULL, 6, 'Cantidad de plantas cosechadas', TRUE
FROM subprocesos 
WHERE proceso_id = 6 AND nombre = 'Certificado de Cosecha'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Estado del Producto', 'seleccion_condicional', NULL, NULL, NULL, TRUE, '["Frescas", "Otros"]'::jsonb, 7, 'Estado del producto cosechado', TRUE
FROM subprocesos 
WHERE proceso_id = 6 AND nombre = 'Certificado de Cosecha'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, '% Tricomas Ámbar - Liberación de Cosecha', 'seleccion', NULL, NULL, NULL, TRUE, '["Aprobado", "Rechazado"]'::jsonb, 8, 'Resultado de liberación por % de tricomas ámbar', TRUE
FROM subprocesos 
WHERE proceso_id = 6 AND nombre = 'Certificado de Cosecha'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Condiciones Sanitarias', 'seleccion', NULL, NULL, NULL, TRUE, '["Adecuadas", "No Adecuadas"]'::jsonb, 9, 'Condición sanitaria del lote', TRUE
FROM subprocesos 
WHERE proceso_id = 6 AND nombre = 'Certificado de Cosecha'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Cumple BPA', 'booleano', NULL, NULL, NULL, TRUE, NULL, 10, 'Cumplimiento de Buenas Prácticas Agrícolas', TRUE
FROM subprocesos 
WHERE proceso_id = 6 AND nombre = 'Certificado de Cosecha'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Sala de Cultivo', 'seleccion_condicional', NULL, NULL, NULL, TRUE, '["SF1", "SF2", "Otros"]'::jsonb, 11, 'Sala de origen', TRUE
FROM subprocesos 
WHERE proceso_id = 6 AND nombre = 'Certificado de Cosecha'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Genética', 'seleccion_condicional', NULL, NULL, NULL, TRUE, '["Pete Hope", "Otros"]'::jsonb, 12, 'Genética/variedad cosechada', TRUE
FROM subprocesos 
WHERE proceso_id = 6 AND nombre = 'Certificado de Cosecha'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Instrumental', 'texto', NULL, NULL, NULL, FALSE, NULL, 13, 'Instrumental utilizado en la cosecha', TRUE
FROM subprocesos 
WHERE proceso_id = 6 AND nombre = 'Certificado de Cosecha'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Código de Trazabilidad', 'texto', NULL, NULL, NULL, TRUE, NULL, 14, 'Código de trazabilidad del lote', TRUE
FROM subprocesos 
WHERE proceso_id = 6 AND nombre = 'Certificado de Cosecha'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Liberación de Cosecha Aprobado Por', 'texto', NULL, NULL, NULL, TRUE, NULL, 15, 'Responsable que aprueba la liberación', TRUE
FROM subprocesos 
WHERE proceso_id = 6 AND nombre = 'Certificado de Cosecha'
LIMIT 1;

INSERT INTO subprocesos (proceso_id, nombre, orden, requiere_climatizacion, cm_re_referencia, descripcion, activo)
VALUES (6, 'Control Peso Húmedo en Cosecha', 2, FALSE, 'CM-RE-0602', 'Control de peso húmedo por fila/cuadro durante la cosecha.', TRUE);
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Fecha', 'fecha', NULL, NULL, NULL, TRUE, NULL, 1, 'Fecha de pesaje', TRUE
FROM subprocesos 
WHERE proceso_id = 6 AND nombre = 'Control Peso Húmedo en Cosecha'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Camada', 'texto', NULL, NULL, NULL, TRUE, NULL, 2, 'Camada', TRUE
FROM subprocesos 
WHERE proceso_id = 6 AND nombre = 'Control Peso Húmedo en Cosecha'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Sala', 'texto', NULL, NULL, NULL, TRUE, NULL, 3, 'Sala de cultivo', TRUE
FROM subprocesos 
WHERE proceso_id = 6 AND nombre = 'Control Peso Húmedo en Cosecha'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'N° de Fila', 'numero', NULL, 1, 50, TRUE, NULL, 4, 'Número de fila', TRUE
FROM subprocesos 
WHERE proceso_id = 6 AND nombre = 'Control Peso Húmedo en Cosecha'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'N° de Cuadro', 'numero', NULL, 1, 50, FALSE, NULL, 5, 'Número de cuadro', TRUE
FROM subprocesos 
WHERE proceso_id = 6 AND nombre = 'Control Peso Húmedo en Cosecha'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'N° de Subcuadro', 'seleccion', NULL, NULL, NULL, FALSE, '["1", "2", "3", "4"]'::jsonb, 6, 'Subcuadro de pesaje', TRUE
FROM subprocesos 
WHERE proceso_id = 6 AND nombre = 'Control Peso Húmedo en Cosecha'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Tara del Subcuadro', 'numero', 'kg', NULL, 50, FALSE, NULL, 7, 'Tara del recipiente de subcuadro', TRUE
FROM subprocesos 
WHERE proceso_id = 6 AND nombre = 'Control Peso Húmedo en Cosecha'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Peso Húmedo', 'numero', 'kg', NULL, 100, TRUE, NULL, 8, 'Peso húmedo registrado', TRUE
FROM subprocesos 
WHERE proceso_id = 6 AND nombre = 'Control Peso Húmedo en Cosecha'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Observaciones', 'texto', NULL, NULL, NULL, FALSE, NULL, 9, 'Notas de pesaje', TRUE
FROM subprocesos 
WHERE proceso_id = 6 AND nombre = 'Control Peso Húmedo en Cosecha'
LIMIT 1;

INSERT INTO subprocesos (proceso_id, nombre, orden, requiere_climatizacion, cm_re_referencia, descripcion, activo)
VALUES (6, 'Resumen de Cosecha', 3, FALSE, 'CM-RE-0603', 'Resumen consolidado de kilos por camada (húmedo/seco/trimeado).', TRUE);
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Fecha', 'fecha', NULL, NULL, NULL, TRUE, NULL, 1, 'Fecha del resumen', TRUE
FROM subprocesos 
WHERE proceso_id = 6 AND nombre = 'Resumen de Cosecha'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Sala', 'texto', NULL, NULL, NULL, TRUE, NULL, 2, 'Sala de cultivo', TRUE
FROM subprocesos 
WHERE proceso_id = 6 AND nombre = 'Resumen de Cosecha'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Camada', 'texto', NULL, NULL, NULL, TRUE, NULL, 3, 'Camada', TRUE
FROM subprocesos 
WHERE proceso_id = 6 AND nombre = 'Resumen de Cosecha'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Kilos Húmedos', 'numero', 'kg', NULL, 5000, TRUE, NULL, 4, 'Total de kilos húmedos cosechados', TRUE
FROM subprocesos 
WHERE proceso_id = 6 AND nombre = 'Resumen de Cosecha'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Kilos Secos', 'numero', 'kg', NULL, 5000, FALSE, NULL, 5, 'Total de kilos secos obtenidos', TRUE
FROM subprocesos 
WHERE proceso_id = 6 AND nombre = 'Resumen de Cosecha'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Kilos Trimeados', 'numero', 'kg', NULL, 5000, FALSE, NULL, 6, 'Total de kilos trimeados obtenidos', TRUE
FROM subprocesos 
WHERE proceso_id = 6 AND nombre = 'Resumen de Cosecha'
LIMIT 1;

-- Proceso 7: Secado

INSERT INTO subprocesos (proceso_id, nombre, orden, requiere_climatizacion, cm_re_referencia, descripcion, activo)
VALUES (7, 'Certificado de Recepción en Secado', 1, FALSE, 'CM-RE-0604', 'Certificado de recepción de material fresco en Sala de Secado.', TRUE);
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Fecha Ingreso', 'fecha', NULL, NULL, NULL, TRUE, NULL, 1, 'Fecha de ingreso a secado', TRUE
FROM subprocesos 
WHERE proceso_id = 7 AND nombre = 'Certificado de Recepción en Secado'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Camada', 'texto', NULL, NULL, NULL, TRUE, NULL, 2, 'Camada ingresada', TRUE
FROM subprocesos 
WHERE proceso_id = 7 AND nombre = 'Certificado de Recepción en Secado'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Peso Húmedo de Ingreso', 'numero', 'kg', NULL, 200, TRUE, NULL, 3, 'Peso húmedo al ingreso', TRUE
FROM subprocesos 
WHERE proceso_id = 7 AND nombre = 'Certificado de Recepción en Secado'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Cuadros de Secado', 'texto', NULL, NULL, NULL, TRUE, NULL, 4, 'Cuadros de secado asignados', TRUE
FROM subprocesos 
WHERE proceso_id = 7 AND nombre = 'Certificado de Recepción en Secado'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Número de Fila', 'numero', NULL, 1, 50, TRUE, NULL, 5, 'Fila de origen', TRUE
FROM subprocesos 
WHERE proceso_id = 7 AND nombre = 'Certificado de Recepción en Secado'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Condiciones de Entrega', 'seleccion_condicional', NULL, NULL, NULL, TRUE, '["\u00d3ptimas", "Adecuado", "No Adecuado", "Otros"]'::jsonb, 6, 'Condición de entrega del material', TRUE
FROM subprocesos 
WHERE proceso_id = 7 AND nombre = 'Certificado de Recepción en Secado'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Ubicación', 'texto', NULL, NULL, NULL, TRUE, NULL, 7, 'Ubicación física (Sala de Secado)', TRUE
FROM subprocesos 
WHERE proceso_id = 7 AND nombre = 'Certificado de Recepción en Secado'
LIMIT 1;

INSERT INTO subprocesos (proceso_id, nombre, orden, requiere_climatizacion, cm_re_referencia, descripcion, activo)
VALUES (7, 'Control de Peso Seco en Secadero', 2, FALSE, NULL, 'Control periódico de peso seco durante el secado.', TRUE);
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Fecha', 'fecha', NULL, NULL, NULL, TRUE, NULL, 1, 'Fecha de control', TRUE
FROM subprocesos 
WHERE proceso_id = 7 AND nombre = 'Control de Peso Seco en Secadero'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Camada', 'texto', NULL, NULL, NULL, TRUE, NULL, 2, 'Camada', TRUE
FROM subprocesos 
WHERE proceso_id = 7 AND nombre = 'Control de Peso Seco en Secadero'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Sala', 'texto', NULL, NULL, NULL, TRUE, NULL, 3, 'Sala', TRUE
FROM subprocesos 
WHERE proceso_id = 7 AND nombre = 'Control de Peso Seco en Secadero'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Número de Fila', 'numero', NULL, 1, 50, TRUE, NULL, 4, 'Fila', TRUE
FROM subprocesos 
WHERE proceso_id = 7 AND nombre = 'Control de Peso Seco en Secadero'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Número de Cuadro', 'numero', NULL, 1, 50, TRUE, NULL, 5, 'Cuadro de secado', TRUE
FROM subprocesos 
WHERE proceso_id = 7 AND nombre = 'Control de Peso Seco en Secadero'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Número de Subcuadro', 'seleccion', NULL, NULL, NULL, TRUE, '["1", "2", "3", "4"]'::jsonb, 6, 'Subcuadro (1 a 4)', TRUE
FROM subprocesos 
WHERE proceso_id = 7 AND nombre = 'Control de Peso Seco en Secadero'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Tara del Subcuadro', 'numero', 'kg', NULL, 50, FALSE, NULL, 7, 'Tara del recipiente', TRUE
FROM subprocesos 
WHERE proceso_id = 7 AND nombre = 'Control de Peso Seco en Secadero'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Peso Seco', 'numero', 'kg', NULL, 100, TRUE, NULL, 8, 'Peso seco registrado', TRUE
FROM subprocesos 
WHERE proceso_id = 7 AND nombre = 'Control de Peso Seco en Secadero'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Observaciones', 'texto', NULL, NULL, NULL, FALSE, NULL, 9, 'Notas', TRUE
FROM subprocesos 
WHERE proceso_id = 7 AND nombre = 'Control de Peso Seco en Secadero'
LIMIT 1;

INSERT INTO subprocesos (proceso_id, nombre, orden, requiere_climatizacion, cm_re_referencia, descripcion, activo)
VALUES (7, 'Mantenimiento de Equipos de Climatización y Ambiente', 3, FALSE, NULL, 'Registro de mantenimiento de Aires Acondicionados, Ventiladores, Deshumidificadores y Humidificadores en Secado. Fuente: cuaderno de campo.', TRUE);
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Tipo de Equipo', 'seleccion', NULL, NULL, NULL, TRUE, '["Aire Acondicionado", "Ventilador", "Deshumidificador", "Humidificador"]'::jsonb, 1, 'Categoría de equipo de climatización intervenido', TRUE
FROM subprocesos 
WHERE proceso_id = 7 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Fecha', 'fecha', NULL, NULL, NULL, TRUE, NULL, 2, 'Fecha de la actividad de mantenimiento', TRUE
FROM subprocesos 
WHERE proceso_id = 7 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Equipo', 'texto', NULL, NULL, NULL, TRUE, NULL, 3, 'Identificación/código del equipo', TRUE
FROM subprocesos 
WHERE proceso_id = 7 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Estado', 'seleccion', NULL, NULL, NULL, TRUE, '["Operativo", "Fuera de Servicio", "En Mantenimiento"]'::jsonb, 4, 'Estado operativo del equipo', TRUE
FROM subprocesos 
WHERE proceso_id = 7 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Actividad Realizada', 'texto', NULL, NULL, NULL, TRUE, NULL, 5, 'Descripción de la actividad de mantenimiento realizada', TRUE
FROM subprocesos 
WHERE proceso_id = 7 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Responsable', 'texto', NULL, NULL, NULL, FALSE, NULL, 6, 'Persona que realizó el mantenimiento (si distinto al responsable habitual)', TRUE
FROM subprocesos 
WHERE proceso_id = 7 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Observaciones', 'texto', NULL, NULL, NULL, FALSE, NULL, 7, 'Notas adicionales; consignar nombre y motivo si el mantenimiento lo realizó alguien distinto al responsable habitual', TRUE
FROM subprocesos 
WHERE proceso_id = 7 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;

INSERT INTO subprocesos (proceso_id, nombre, orden, requiere_climatizacion, cm_re_referencia, descripcion, activo)
VALUES (7, 'Condiciones Ambientales de Secado', 4, TRUE, 'CM-RE-0107', 'No presente como planilla propia de lectura diaria en el cuaderno de Secado (solo hay mantenimiento de equipos); la Matriz exige CM-RE-0107 ''Condiciones Ambientales – Área de Secado'' (G01). Se agrega por regla de climatización — gap identificado entre Matriz y cuaderno.', TRUE);
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Temperatura Aire', 'numero', '°C', 15, 30, TRUE, NULL, 1, 'Temperatura del ambiente de cultivo/almacenamiento', TRUE
FROM subprocesos 
WHERE proceso_id = 7 AND nombre = 'Condiciones Ambientales de Secado'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Humedad Relativa', 'numero', '%', 40, 80, TRUE, NULL, 2, 'Humedad relativa del aire', TRUE
FROM subprocesos 
WHERE proceso_id = 7 AND nombre = 'Condiciones Ambientales de Secado'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'VPD', 'numero', 'kPa', 0.8, 2.0, TRUE, NULL, 3, 'Vapor Pressure Deficit (déficit de presión de vapor)', TRUE
FROM subprocesos 
WHERE proceso_id = 7 AND nombre = 'Condiciones Ambientales de Secado'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'CO2', 'numero', 'ppm', 400, 1500, TRUE, NULL, 4, 'Concentración de CO2 ambiente', TRUE
FROM subprocesos 
WHERE proceso_id = 7 AND nombre = 'Condiciones Ambientales de Secado'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Ventilación', 'seleccion', NULL, NULL, NULL, TRUE, '["Baja", "Media", "Alta"]'::jsonb, 5, 'Nivel de ventilación aplicado en la sala', TRUE
FROM subprocesos 
WHERE proceso_id = 7 AND nombre = 'Condiciones Ambientales de Secado'
LIMIT 1;

-- Proceso 8: Trimeo

INSERT INTO subprocesos (proceso_id, nombre, orden, requiere_climatizacion, cm_re_referencia, descripcion, activo)
VALUES (8, 'Certificado de Recepción en Trimeo', 1, FALSE, 'CM-RE-0605', 'Certificado de recepción de material seco en Sala de Trimeo. En datos reales, ''Peso Seco de salida de secado'' presenta valores vacíos (''no medido'') en ~70% de registros históricos — se recomienda mantenerlo opcional u obligar su carga en v3.0 para evitar el vacío observado.', TRUE);
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Fecha Ingreso', 'fecha', NULL, NULL, NULL, TRUE, NULL, 1, 'Fecha de ingreso a trimeo', TRUE
FROM subprocesos 
WHERE proceso_id = 8 AND nombre = 'Certificado de Recepción en Trimeo'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Camada', 'texto', NULL, NULL, NULL, TRUE, NULL, 2, 'Camada', TRUE
FROM subprocesos 
WHERE proceso_id = 8 AND nombre = 'Certificado de Recepción en Trimeo'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Orden de Ingreso a Sala de Trimeo', 'texto', NULL, NULL, NULL, TRUE, NULL, 3, 'Orden/líneas de origen de ingreso', TRUE
FROM subprocesos 
WHERE proceso_id = 8 AND nombre = 'Certificado de Recepción en Trimeo'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Cuadro de Secado Origen', 'texto', NULL, NULL, NULL, TRUE, NULL, 4, 'Cuadro de secado de origen', TRUE
FROM subprocesos 
WHERE proceso_id = 8 AND nombre = 'Certificado de Recepción en Trimeo'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Condiciones de Entrega', 'seleccion_condicional', NULL, NULL, NULL, TRUE, '["Adecuado", "No Adecuado", "Otros"]'::jsonb, 5, 'Condición de entrega del material', TRUE
FROM subprocesos 
WHERE proceso_id = 8 AND nombre = 'Certificado de Recepción en Trimeo'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Peso Seco de Salida de Secado', 'numero', 'kg', NULL, 100, FALSE, NULL, 6, 'Peso seco al salir de secado', TRUE
FROM subprocesos 
WHERE proceso_id = 8 AND nombre = 'Certificado de Recepción en Trimeo'
LIMIT 1;

INSERT INTO subprocesos (proceso_id, nombre, orden, requiere_climatizacion, cm_re_referencia, descripcion, activo)
VALUES (8, 'Control de Peso Seco en Post-Trimeo', 2, FALSE, NULL, 'Control de peso seco luego del proceso de trimeo.', TRUE);
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Fecha', 'fecha', NULL, NULL, NULL, TRUE, NULL, 1, 'Fecha de control', TRUE
FROM subprocesos 
WHERE proceso_id = 8 AND nombre = 'Control de Peso Seco en Post-Trimeo'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Camada', 'texto', NULL, NULL, NULL, TRUE, NULL, 2, 'Camada', TRUE
FROM subprocesos 
WHERE proceso_id = 8 AND nombre = 'Control de Peso Seco en Post-Trimeo'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Sala', 'texto', NULL, NULL, NULL, TRUE, NULL, 3, 'Sala', TRUE
FROM subprocesos 
WHERE proceso_id = 8 AND nombre = 'Control de Peso Seco en Post-Trimeo'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'N° de Fila', 'numero', NULL, 1, 50, TRUE, NULL, 4, 'Fila', TRUE
FROM subprocesos 
WHERE proceso_id = 8 AND nombre = 'Control de Peso Seco en Post-Trimeo'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'N° de Cuadro de Secado', 'numero', NULL, 1, 50, TRUE, NULL, 5, 'Cuadro de secado de origen', TRUE
FROM subprocesos 
WHERE proceso_id = 8 AND nombre = 'Control de Peso Seco en Post-Trimeo'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Condiciones', 'seleccion_condicional', NULL, NULL, NULL, TRUE, '["Adecuado", "No Adecuado", "Otros"]'::jsonb, 6, 'Condición del material', TRUE
FROM subprocesos 
WHERE proceso_id = 8 AND nombre = 'Control de Peso Seco en Post-Trimeo'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'N° de Bolsa', 'texto', NULL, NULL, NULL, TRUE, NULL, 7, 'Identificador de bolsa de empaque', TRUE
FROM subprocesos 
WHERE proceso_id = 8 AND nombre = 'Control de Peso Seco en Post-Trimeo'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Peso Seco', 'numero', 'kg', NULL, 100, TRUE, NULL, 8, 'Peso seco post-trimeo', TRUE
FROM subprocesos 
WHERE proceso_id = 8 AND nombre = 'Control de Peso Seco en Post-Trimeo'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Observaciones', 'texto', NULL, NULL, NULL, FALSE, NULL, 9, 'Notas', TRUE
FROM subprocesos 
WHERE proceso_id = 8 AND nombre = 'Control de Peso Seco en Post-Trimeo'
LIMIT 1;

INSERT INTO subprocesos (proceso_id, nombre, orden, requiere_climatizacion, cm_re_referencia, descripcion, activo)
VALUES (8, 'Mantenimiento de Equipos de Climatización y Ambiente', 3, FALSE, NULL, 'Registro de mantenimiento de Aires Acondicionados, Ventiladores, Deshumidificadores y Humidificadores en Trimeo. Fuente: cuaderno de campo.', TRUE);
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Tipo de Equipo', 'seleccion', NULL, NULL, NULL, TRUE, '["Aire Acondicionado", "Ventilador", "Deshumidificador", "Humidificador"]'::jsonb, 1, 'Categoría de equipo de climatización intervenido', TRUE
FROM subprocesos 
WHERE proceso_id = 8 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Fecha', 'fecha', NULL, NULL, NULL, TRUE, NULL, 2, 'Fecha de la actividad de mantenimiento', TRUE
FROM subprocesos 
WHERE proceso_id = 8 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Equipo', 'texto', NULL, NULL, NULL, TRUE, NULL, 3, 'Identificación/código del equipo', TRUE
FROM subprocesos 
WHERE proceso_id = 8 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Estado', 'seleccion', NULL, NULL, NULL, TRUE, '["Operativo", "Fuera de Servicio", "En Mantenimiento"]'::jsonb, 4, 'Estado operativo del equipo', TRUE
FROM subprocesos 
WHERE proceso_id = 8 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Actividad Realizada', 'texto', NULL, NULL, NULL, TRUE, NULL, 5, 'Descripción de la actividad de mantenimiento realizada', TRUE
FROM subprocesos 
WHERE proceso_id = 8 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Responsable', 'texto', NULL, NULL, NULL, FALSE, NULL, 6, 'Persona que realizó el mantenimiento (si distinto al responsable habitual)', TRUE
FROM subprocesos 
WHERE proceso_id = 8 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Observaciones', 'texto', NULL, NULL, NULL, FALSE, NULL, 7, 'Notas adicionales; consignar nombre y motivo si el mantenimiento lo realizó alguien distinto al responsable habitual', TRUE
FROM subprocesos 
WHERE proceso_id = 8 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;

-- Proceso 9: Sales

INSERT INTO subprocesos (proceso_id, nombre, orden, requiere_climatizacion, cm_re_referencia, descripcion, activo)
VALUES (9, 'Solución Nutritiva', 1, FALSE, 'CM-RE-0301', 'Preparación y aplicación de solución nutritiva por tanque/sala.', TRUE);
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Fecha', 'fecha', NULL, NULL, NULL, TRUE, NULL, 1, 'Fecha de preparación', TRUE
FROM subprocesos 
WHERE proceso_id = 9 AND nombre = 'Solución Nutritiva'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Tanque Destino', 'seleccion_condicional', NULL, NULL, NULL, TRUE, '["T4 M", "T6F2", "T7F1", "Otros"]'::jsonb, 2, 'Tanque y sala destino de la solución', TRUE
FROM subprocesos 
WHERE proceso_id = 9 AND nombre = 'Solución Nutritiva'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Lts. de Solución', 'numero', 'L', NULL, 5000, TRUE, NULL, 3, 'Litros de solución preparada', TRUE
FROM subprocesos 
WHERE proceso_id = 9 AND nombre = 'Solución Nutritiva'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'EC', 'numero', 'mS/cm', NULL, 5, TRUE, NULL, 4, 'Conductividad eléctrica de la solución', TRUE
FROM subprocesos 
WHERE proceso_id = 9 AND nombre = 'Solución Nutritiva'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Core (ml)', 'numero', 'ml', NULL, 20000, FALSE, NULL, 5, 'Cantidad de Core agregada', TRUE
FROM subprocesos 
WHERE proceso_id = 9 AND nombre = 'Solución Nutritiva'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Bloom (ml)', 'numero', 'ml', NULL, 20000, FALSE, NULL, 6, 'Cantidad de Bloom agregada', TRUE
FROM subprocesos 
WHERE proceso_id = 9 AND nombre = 'Solución Nutritiva'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Balance / Grow (ml)', 'numero', 'ml', NULL, 20000, FALSE, NULL, 7, 'Cantidad de Balance/Grow agregada', TRUE
FROM subprocesos 
WHERE proceso_id = 9 AND nombre = 'Solución Nutritiva'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'FADE (ml)', 'numero', 'ml', NULL, 20000, FALSE, NULL, 8, 'Cantidad de FADE agregada', TRUE
FROM subprocesos 
WHERE proceso_id = 9 AND nombre = 'Solución Nutritiva'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Destino Solución', 'texto', NULL, NULL, NULL, FALSE, NULL, 9, 'Descripción del destino de la solución', TRUE
FROM subprocesos 
WHERE proceso_id = 9 AND nombre = 'Solución Nutritiva'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Destino Camada', 'texto', NULL, NULL, NULL, FALSE, NULL, 10, 'Camada destino', TRUE
FROM subprocesos 
WHERE proceso_id = 9 AND nombre = 'Solución Nutritiva'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Responsable', 'texto', NULL, NULL, NULL, TRUE, NULL, 11, 'Responsable de la preparación', TRUE
FROM subprocesos 
WHERE proceso_id = 9 AND nombre = 'Solución Nutritiva'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Observaciones', 'texto', NULL, NULL, NULL, FALSE, NULL, 12, 'Notas', TRUE
FROM subprocesos 
WHERE proceso_id = 9 AND nombre = 'Solución Nutritiva'
LIMIT 1;

INSERT INTO subprocesos (proceso_id, nombre, orden, requiere_climatizacion, cm_re_referencia, descripcion, activo)
VALUES (9, 'Insumos', 2, FALSE, 'CM-RE-0304', 'Utilización de insumos esenciales e inventario de fertilizantes.', TRUE);
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Fecha', 'fecha', NULL, NULL, NULL, TRUE, NULL, 1, 'Fecha de utilización', TRUE
FROM subprocesos 
WHERE proceso_id = 9 AND nombre = 'Insumos'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Insumo Aplicado', 'seleccion_condicional', NULL, NULL, NULL, TRUE, '["Balance", "FADE", "Tricoderma", "Micorrizas", "Bti", "Azufre Agr\u00edcola", "STACK", "IPW", "Bicarbonato de Na", "Sal Com\u00fan", "H2O2", "Ac. Parac\u00e9tico (OXIDAL)", "H2O Destilada", "Otros"]'::jsonb, 2, 'Insumo esencial utilizado', TRUE
FROM subprocesos 
WHERE proceso_id = 9 AND nombre = 'Insumos'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Cantidad', 'numero', NULL, NULL, 10000, TRUE, NULL, 3, 'Cantidad utilizada', TRUE
FROM subprocesos 
WHERE proceso_id = 9 AND nombre = 'Insumos'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Unidad', 'seleccion', NULL, NULL, NULL, TRUE, '["Kg", "Gr", "Lt", "Ml"]'::jsonb, 4, 'Unidad de la cantidad', TRUE
FROM subprocesos 
WHERE proceso_id = 9 AND nombre = 'Insumos'
LIMIT 1;

INSERT INTO subprocesos (proceso_id, nombre, orden, requiere_climatizacion, cm_re_referencia, descripcion, activo)
VALUES (9, 'Disoluciones', 3, FALSE, NULL, 'Registro de disoluciones concentradas de fertilizantes.', TRUE);
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Fecha', 'fecha', NULL, NULL, NULL, TRUE, NULL, 1, 'Fecha de disolución', TRUE
FROM subprocesos 
WHERE proceso_id = 9 AND nombre = 'Disoluciones'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Tanque Destino', 'texto', NULL, NULL, NULL, TRUE, NULL, 2, 'Tanque destino', TRUE
FROM subprocesos 
WHERE proceso_id = 9 AND nombre = 'Disoluciones'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Core (Kg)', 'numero', 'kg', NULL, 200, FALSE, NULL, 3, 'Core en kilogramos', TRUE
FROM subprocesos 
WHERE proceso_id = 9 AND nombre = 'Disoluciones'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Bloom (Kg)', 'numero', 'kg', NULL, 200, FALSE, NULL, 4, 'Bloom en kilogramos', TRUE
FROM subprocesos 
WHERE proceso_id = 9 AND nombre = 'Disoluciones'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Grow (Kg)', 'numero', 'kg', NULL, 200, FALSE, NULL, 5, 'Grow en kilogramos', TRUE
FROM subprocesos 
WHERE proceso_id = 9 AND nombre = 'Disoluciones'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Balance (Kg)', 'numero', 'kg', NULL, 200, FALSE, NULL, 6, 'Balance en kilogramos', TRUE
FROM subprocesos 
WHERE proceso_id = 9 AND nombre = 'Disoluciones'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Core (Litros Concentrados)', 'numero', 'L', NULL, 200, FALSE, NULL, 7, 'Core en litros concentrados', TRUE
FROM subprocesos 
WHERE proceso_id = 9 AND nombre = 'Disoluciones'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Grow (Litros Concentrados)', 'numero', 'L', NULL, 200, FALSE, NULL, 8, 'Grow en litros concentrados', TRUE
FROM subprocesos 
WHERE proceso_id = 9 AND nombre = 'Disoluciones'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Bloom (Litros Concentrados)', 'numero', 'L', NULL, 200, FALSE, NULL, 9, 'Bloom en litros concentrados', TRUE
FROM subprocesos 
WHERE proceso_id = 9 AND nombre = 'Disoluciones'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Verificación', 'booleano', NULL, NULL, NULL, TRUE, NULL, 10, 'Verificación de la disolución realizada', TRUE
FROM subprocesos 
WHERE proceso_id = 9 AND nombre = 'Disoluciones'
LIMIT 1;

INSERT INTO subprocesos (proceso_id, nombre, orden, requiere_climatizacion, cm_re_referencia, descripcion, activo)
VALUES (9, 'Calibración de Equipos', 4, FALSE, 'CM-RE-0701', 'Calibración periódica de equipos de medición (balanza, pH, EC).', TRUE);
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Fecha', 'fecha', NULL, NULL, NULL, TRUE, NULL, 1, 'Fecha de calibración', TRUE
FROM subprocesos 
WHERE proceso_id = 9 AND nombre = 'Calibración de Equipos'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Equipo', 'texto', NULL, NULL, NULL, TRUE, NULL, 2, 'Equipo calibrado (pHmetro, EC-metro, etc.)', TRUE
FROM subprocesos 
WHERE proceso_id = 9 AND nombre = 'Calibración de Equipos'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Modelo', 'texto', NULL, NULL, NULL, TRUE, NULL, 3, 'Modelo del equipo', TRUE
FROM subprocesos 
WHERE proceso_id = 9 AND nombre = 'Calibración de Equipos'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Solución Patrón', 'texto', NULL, NULL, NULL, TRUE, NULL, 4, 'Solución patrón utilizada', TRUE
FROM subprocesos 
WHERE proceso_id = 9 AND nombre = 'Calibración de Equipos'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Observaciones', 'texto', NULL, NULL, NULL, FALSE, NULL, 5, 'Notas de calibración', TRUE
FROM subprocesos 
WHERE proceso_id = 9 AND nombre = 'Calibración de Equipos'
LIMIT 1;

-- Proceso 10: Empaquetado y Almacenamiento

INSERT INTO subprocesos (proceso_id, nombre, orden, requiere_climatizacion, cm_re_referencia, descripcion, activo)
VALUES (10, 'Empaquetado', 1, TRUE, 'CM-RE-0607', 'Acondicionamiento final y empaquetado de producto terminado', TRUE);
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Fecha Ingreso', 'fecha', NULL, NULL, NULL, TRUE, NULL, 1, 'Fecha de ingreso a empaquetado', TRUE
FROM subprocesos 
WHERE proceso_id = 10 AND nombre = 'Empaquetado'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Camada', 'texto', NULL, NULL, NULL, TRUE, NULL, 2, 'Identificador de camada/lote', TRUE
FROM subprocesos 
WHERE proceso_id = 10 AND nombre = 'Empaquetado'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Kilos que se Entrega', 'numero', 'kg', NULL, 5000, TRUE, NULL, 3, 'Kilos totales entregados a empaquetado', TRUE
FROM subprocesos 
WHERE proceso_id = 10 AND nombre = 'Empaquetado'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Temperatura Aire', 'numero', '°C', 15, 25, TRUE, NULL, 4, 'Temperatura del ambiente de empaquetado', TRUE
FROM subprocesos 
WHERE proceso_id = 10 AND nombre = 'Empaquetado'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Humedad Relativa', 'numero', '%', 30, 60, TRUE, NULL, 5, 'Humedad relativa del aire', TRUE
FROM subprocesos 
WHERE proceso_id = 10 AND nombre = 'Empaquetado'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'VPD', 'numero', 'kPa', 0.5, 1.2, FALSE, NULL, 6, 'Vapor Pressure Deficit', TRUE
FROM subprocesos 
WHERE proceso_id = 10 AND nombre = 'Empaquetado'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'CO2', 'numero', 'ppm', 400, 1000, FALSE, NULL, 7, 'Nivel de CO2 en el ambiente', TRUE
FROM subprocesos 
WHERE proceso_id = 10 AND nombre = 'Empaquetado'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Ventilación', 'seleccion', NULL, NULL, NULL, TRUE, '["Baja", "Media", "Alta"]'::jsonb, 8, 'Nivel de ventilación', TRUE
FROM subprocesos 
WHERE proceso_id = 10 AND nombre = 'Empaquetado'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Medida de Empaquetado', 'seleccion', NULL, NULL, NULL, TRUE, '["40g", "400g", "1kg", "+1kg bulk"]'::jsonb, 9, 'Formato/peso del empaque (CM-RE-0607)', TRUE
FROM subprocesos 
WHERE proceso_id = 10 AND nombre = 'Empaquetado'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Condiciones de Entrega', 'seleccion', NULL, NULL, NULL, TRUE, '["ACEPTADO", "RECHAZADO"]'::jsonb, 10, 'Condición del material entregado (CM-RE-0608)', TRUE
FROM subprocesos 
WHERE proceso_id = 10 AND nombre = 'Empaquetado'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Ubicación', 'texto', NULL, NULL, NULL, TRUE, NULL, 11, 'Ubicación física en almacén', TRUE
FROM subprocesos 
WHERE proceso_id = 10 AND nombre = 'Empaquetado'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Responsable que Entrega', 'texto', NULL, NULL, NULL, TRUE, NULL, 12, 'Responsable que entrega el lote a empaquetado', TRUE
FROM subprocesos 
WHERE proceso_id = 10 AND nombre = 'Empaquetado'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Responsable que Recepciona', 'texto', NULL, NULL, NULL, TRUE, NULL, 13, 'Responsable que recibe el lote empaquetado', TRUE
FROM subprocesos 
WHERE proceso_id = 10 AND nombre = 'Empaquetado'
LIMIT 1;

INSERT INTO subprocesos (proceso_id, nombre, orden, requiere_climatizacion, cm_re_referencia, descripcion, activo)
VALUES (10, 'Mantenimiento de Equipos de Climatización y Ambiente', 2, FALSE, NULL, 'Registro de mantenimiento de Aires Acondicionados, Ventiladores, Deshumidificadores y Humidificadores en Empaquetado y Almacenamiento. Fuente: cuaderno de campo.', TRUE);
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Tipo de Equipo', 'seleccion', NULL, NULL, NULL, TRUE, '["Aire Acondicionado", "Ventilador", "Deshumidificador", "Humidificador"]'::jsonb, 1, 'Categoría de equipo de climatización intervenido', TRUE
FROM subprocesos 
WHERE proceso_id = 10 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Fecha', 'fecha', NULL, NULL, NULL, TRUE, NULL, 2, 'Fecha de la actividad de mantenimiento', TRUE
FROM subprocesos 
WHERE proceso_id = 10 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Equipo', 'texto', NULL, NULL, NULL, TRUE, NULL, 3, 'Identificación/código del equipo', TRUE
FROM subprocesos 
WHERE proceso_id = 10 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Estado', 'seleccion', NULL, NULL, NULL, TRUE, '["Operativo", "Fuera de Servicio", "En Mantenimiento"]'::jsonb, 4, 'Estado operativo del equipo', TRUE
FROM subprocesos 
WHERE proceso_id = 10 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Actividad Realizada', 'texto', NULL, NULL, NULL, TRUE, NULL, 5, 'Descripción de la actividad de mantenimiento realizada', TRUE
FROM subprocesos 
WHERE proceso_id = 10 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Responsable', 'texto', NULL, NULL, NULL, FALSE, NULL, 6, 'Persona que realizó el mantenimiento (si distinto al responsable habitual)', TRUE
FROM subprocesos 
WHERE proceso_id = 10 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Observaciones', 'texto', NULL, NULL, NULL, FALSE, NULL, 7, 'Notas adicionales; consignar nombre y motivo si el mantenimiento lo realizó alguien distinto al responsable habitual', TRUE
FROM subprocesos 
WHERE proceso_id = 10 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;

INSERT INTO subprocesos (proceso_id, nombre, orden, requiere_climatizacion, cm_re_referencia, descripcion, activo)
VALUES (10, 'Condiciones Ambientales de Almacenamiento', 3, TRUE, 'CM-RE-0102', 'No presente como planilla propia de lectura diaria en el cuaderno; la Matriz exige CM-RE-0102 ''Condiciones Ambientales – Almacenamiento'' (G01, nombre de código coincide con el de Clonación en la Matriz, posible error de codificación a validar). Se agrega por regla de climatización — gap identificado entre Matriz y cuaderno.', TRUE);
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Temperatura Aire', 'numero', '°C', 15, 30, TRUE, NULL, 1, 'Temperatura del ambiente de cultivo/almacenamiento', TRUE
FROM subprocesos 
WHERE proceso_id = 10 AND nombre = 'Condiciones Ambientales de Almacenamiento'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Humedad Relativa', 'numero', '%', 40, 80, TRUE, NULL, 2, 'Humedad relativa del aire', TRUE
FROM subprocesos 
WHERE proceso_id = 10 AND nombre = 'Condiciones Ambientales de Almacenamiento'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'VPD', 'numero', 'kPa', 0.8, 2.0, TRUE, NULL, 3, 'Vapor Pressure Deficit (déficit de presión de vapor)', TRUE
FROM subprocesos 
WHERE proceso_id = 10 AND nombre = 'Condiciones Ambientales de Almacenamiento'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'CO2', 'numero', 'ppm', 400, 1500, TRUE, NULL, 4, 'Concentración de CO2 ambiente', TRUE
FROM subprocesos 
WHERE proceso_id = 10 AND nombre = 'Condiciones Ambientales de Almacenamiento'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Ventilación', 'seleccion', NULL, NULL, NULL, TRUE, '["Baja", "Media", "Alta"]'::jsonb, 5, 'Nivel de ventilación aplicado en la sala', TRUE
FROM subprocesos 
WHERE proceso_id = 10 AND nombre = 'Condiciones Ambientales de Almacenamiento'
LIMIT 1;

INSERT INTO subprocesos (proceso_id, nombre, orden, requiere_climatizacion, cm_re_referencia, descripcion, activo)
VALUES (10, 'Salida de Almacenamiento', 2, TRUE, 'CM-RE-0609', 'Registro de salida de producto terminado del almacén (venta, investigación, donación, etc.)', TRUE);
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Fecha Salida', 'fecha', NULL, NULL, NULL, TRUE, NULL, 1, 'Fecha de salida del almacén', TRUE
FROM subprocesos 
WHERE proceso_id = 10 AND nombre = 'Salida de Almacenamiento'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Camada', 'texto', NULL, NULL, NULL, TRUE, NULL, 2, 'Identificador de camada/lote', TRUE
FROM subprocesos 
WHERE proceso_id = 10 AND nombre = 'Salida de Almacenamiento'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Kilos que Salen', 'numero', 'kg', NULL, 5000, TRUE, NULL, 3, 'Kilos que salen del almacén', TRUE
FROM subprocesos 
WHERE proceso_id = 10 AND nombre = 'Salida de Almacenamiento'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Motivo de Salida', 'seleccion_condicional', NULL, NULL, NULL, TRUE, '["Venta comercial", "Investigaci\u00f3n", "Donaci\u00f3n", "Otros"]'::jsonb, 4, 'Motivo de salida del almacén. Si selecciona ''Otros'', despliega campo de texto libre', TRUE
FROM subprocesos 
WHERE proceso_id = 10 AND nombre = 'Salida de Almacenamiento'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Estado del Lote', 'seleccion', NULL, NULL, NULL, TRUE, '["Adecuado", "Rechazado"]'::jsonb, 5, 'Estado del lote al salir del almacén', TRUE
FROM subprocesos 
WHERE proceso_id = 10 AND nombre = 'Salida de Almacenamiento'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Destino', 'seleccion', NULL, NULL, NULL, TRUE, '["Nacional", "Internacional"]'::jsonb, 6, 'Destino del envío', TRUE
FROM subprocesos 
WHERE proceso_id = 10 AND nombre = 'Salida de Almacenamiento'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Tipo de Transporte', 'seleccion', NULL, NULL, NULL, TRUE, '["Autom\u00f3vil", "Avi\u00f3n", "Camioneta"]'::jsonb, 7, 'Tipo de transporte utilizado', TRUE
FROM subprocesos 
WHERE proceso_id = 10 AND nombre = 'Salida de Almacenamiento'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Presentación de Producto', 'seleccion', NULL, NULL, NULL, TRUE, '["40g", "400g", "1kg", "+1kg bulk"]'::jsonb, 8, 'Presentación/formato del producto que sale', TRUE
FROM subprocesos 
WHERE proceso_id = 10 AND nombre = 'Salida de Almacenamiento'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Temperatura Aire', 'numero', '°C', 15, 25, TRUE, NULL, 9, 'Temperatura del ambiente de almacenamiento', TRUE
FROM subprocesos 
WHERE proceso_id = 10 AND nombre = 'Salida de Almacenamiento'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Humedad Relativa', 'numero', '%', 30, 60, TRUE, NULL, 10, 'Humedad relativa del aire', TRUE
FROM subprocesos 
WHERE proceso_id = 10 AND nombre = 'Salida de Almacenamiento'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Responsable que Entrega', 'texto', NULL, NULL, NULL, TRUE, NULL, 11, 'Responsable que entrega desde almacén', TRUE
FROM subprocesos 
WHERE proceso_id = 10 AND nombre = 'Salida de Almacenamiento'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Responsable que Recepciona', 'texto', NULL, NULL, NULL, TRUE, NULL, 12, 'Responsable que recibe en destino', TRUE
FROM subprocesos 
WHERE proceso_id = 10 AND nombre = 'Salida de Almacenamiento'
LIMIT 1;

-- Proceso 11: Cuarentena

INSERT INTO subprocesos (proceso_id, nombre, orden, requiere_climatizacion, cm_re_referencia, descripcion, activo)
VALUES (11, 'Ingreso a Cuarentena', 1, FALSE, 'CM-RE-0606', 'Ingreso formal de lotes a Cuarentena.', TRUE);
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Fecha Ingreso', 'fecha', NULL, NULL, NULL, TRUE, NULL, 1, 'Fecha de ingreso a cuarentena', TRUE
FROM subprocesos 
WHERE proceso_id = 11 AND nombre = 'Ingreso a Cuarentena'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Camada', 'texto', NULL, NULL, NULL, TRUE, NULL, 2, 'Camada', TRUE
FROM subprocesos 
WHERE proceso_id = 11 AND nombre = 'Ingreso a Cuarentena'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Cuadro de Secado de Origen', 'texto', NULL, NULL, NULL, TRUE, NULL, 3, 'Cuadro de secado de origen', TRUE
FROM subprocesos 
WHERE proceso_id = 11 AND nombre = 'Ingreso a Cuarentena'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Condiciones de Entrega', 'seleccion_condicional', NULL, NULL, NULL, TRUE, '["Adecuado", "No Adecuado", "Otros"]'::jsonb, 4, 'Condición del material entregado', TRUE
FROM subprocesos 
WHERE proceso_id = 11 AND nombre = 'Ingreso a Cuarentena'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Ubicación', 'texto', NULL, NULL, NULL, TRUE, NULL, 5, 'Ubicación física (Cuarentena)', TRUE
FROM subprocesos 
WHERE proceso_id = 11 AND nombre = 'Ingreso a Cuarentena'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Kg. Recibidos', 'numero', 'kg', NULL, 20000, TRUE, NULL, 6, 'Kilos recibidos en cuarentena', TRUE
FROM subprocesos 
WHERE proceso_id = 11 AND nombre = 'Ingreso a Cuarentena'
LIMIT 1;

INSERT INTO subprocesos (proceso_id, nombre, orden, requiere_climatizacion, cm_re_referencia, descripcion, activo)
VALUES (11, 'Mantenimiento de Equipos de Climatización y Ambiente', 2, FALSE, NULL, 'Registro de mantenimiento de Aires Acondicionados, Ventiladores, Deshumidificadores y Humidificadores en Cuarentena. Fuente: cuaderno de campo.', TRUE);
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Tipo de Equipo', 'seleccion', NULL, NULL, NULL, TRUE, '["Aire Acondicionado", "Ventilador", "Deshumidificador", "Humidificador"]'::jsonb, 1, 'Categoría de equipo de climatización intervenido', TRUE
FROM subprocesos 
WHERE proceso_id = 11 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Fecha', 'fecha', NULL, NULL, NULL, TRUE, NULL, 2, 'Fecha de la actividad de mantenimiento', TRUE
FROM subprocesos 
WHERE proceso_id = 11 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Equipo', 'texto', NULL, NULL, NULL, TRUE, NULL, 3, 'Identificación/código del equipo', TRUE
FROM subprocesos 
WHERE proceso_id = 11 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Estado', 'seleccion', NULL, NULL, NULL, TRUE, '["Operativo", "Fuera de Servicio", "En Mantenimiento"]'::jsonb, 4, 'Estado operativo del equipo', TRUE
FROM subprocesos 
WHERE proceso_id = 11 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Actividad Realizada', 'texto', NULL, NULL, NULL, TRUE, NULL, 5, 'Descripción de la actividad de mantenimiento realizada', TRUE
FROM subprocesos 
WHERE proceso_id = 11 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Responsable', 'texto', NULL, NULL, NULL, FALSE, NULL, 6, 'Persona que realizó el mantenimiento (si distinto al responsable habitual)', TRUE
FROM subprocesos 
WHERE proceso_id = 11 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Observaciones', 'texto', NULL, NULL, NULL, FALSE, NULL, 7, 'Notas adicionales; consignar nombre y motivo si el mantenimiento lo realizó alguien distinto al responsable habitual', TRUE
FROM subprocesos 
WHERE proceso_id = 11 AND nombre = 'Mantenimiento de Equipos de Climatización y Ambiente'
LIMIT 1;

INSERT INTO subprocesos (proceso_id, nombre, orden, requiere_climatizacion, cm_re_referencia, descripcion, activo)
VALUES (11, 'Condiciones Ambientales de Cuarentena', 3, TRUE, 'CM-RE-0103', 'No presente como planilla propia de lectura diaria en el cuaderno; la Matriz exige CM-RE-0103 ''Condiciones Ambientales – Cuarentena'' (G01). Se agrega por regla de climatización — gap identificado entre Matriz y cuaderno.', TRUE);
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Temperatura Aire', 'numero', '°C', 15, 30, TRUE, NULL, 1, 'Temperatura del ambiente de cultivo/almacenamiento', TRUE
FROM subprocesos 
WHERE proceso_id = 11 AND nombre = 'Condiciones Ambientales de Cuarentena'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Humedad Relativa', 'numero', '%', 40, 80, TRUE, NULL, 2, 'Humedad relativa del aire', TRUE
FROM subprocesos 
WHERE proceso_id = 11 AND nombre = 'Condiciones Ambientales de Cuarentena'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'VPD', 'numero', 'kPa', 0.8, 2.0, TRUE, NULL, 3, 'Vapor Pressure Deficit (déficit de presión de vapor)', TRUE
FROM subprocesos 
WHERE proceso_id = 11 AND nombre = 'Condiciones Ambientales de Cuarentena'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'CO2', 'numero', 'ppm', 400, 1500, TRUE, NULL, 4, 'Concentración de CO2 ambiente', TRUE
FROM subprocesos 
WHERE proceso_id = 11 AND nombre = 'Condiciones Ambientales de Cuarentena'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Ventilación', 'seleccion', NULL, NULL, NULL, TRUE, '["Baja", "Media", "Alta"]'::jsonb, 5, 'Nivel de ventilación aplicado en la sala', TRUE
FROM subprocesos 
WHERE proceso_id = 11 AND nombre = 'Condiciones Ambientales de Cuarentena'
LIMIT 1;

-- Proceso 12: Certificado de Transporte

INSERT INTO subprocesos (proceso_id, nombre, orden, requiere_climatizacion, cm_re_referencia, descripcion, activo)
VALUES (12, 'Certificado de Transporte', 1, FALSE, 'CM-RE-0609', 'Certificado de transporte y trazabilidad de despachos.', TRUE);
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Fecha', 'fecha', NULL, NULL, NULL, TRUE, NULL, 1, 'Fecha del transporte', TRUE
FROM subprocesos 
WHERE proceso_id = 12 AND nombre = 'Certificado de Transporte'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Número de Transporte', 'texto', NULL, NULL, NULL, TRUE, NULL, 2, 'Número identificatorio del transporte', TRUE
FROM subprocesos 
WHERE proceso_id = 12 AND nombre = 'Certificado de Transporte'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Código Comercial', 'texto', NULL, NULL, NULL, TRUE, NULL, 3, 'Código comercial del producto', TRUE
FROM subprocesos 
WHERE proceso_id = 12 AND nombre = 'Certificado de Transporte'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Presentación del Producto', 'texto', NULL, NULL, NULL, TRUE, NULL, 4, 'Presentación/formato del producto', TRUE
FROM subprocesos 
WHERE proceso_id = 12 AND nombre = 'Certificado de Transporte'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Cantidad Despachada', 'numero', NULL, NULL, 100000, TRUE, NULL, 5, 'Cantidad despachada', TRUE
FROM subprocesos 
WHERE proceso_id = 12 AND nombre = 'Certificado de Transporte'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Destino (Nac/Inter)', 'seleccion', NULL, NULL, NULL, TRUE, '["Nacional", "Internacional"]'::jsonb, 6, 'Alcance del destino', TRUE
FROM subprocesos 
WHERE proceso_id = 12 AND nombre = 'Certificado de Transporte'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Destino', 'texto', NULL, NULL, NULL, TRUE, NULL, 7, 'Destino específico', TRUE
FROM subprocesos 
WHERE proceso_id = 12 AND nombre = 'Certificado de Transporte'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Dirección de Entrega', 'texto', NULL, NULL, NULL, TRUE, NULL, 8, 'Dirección de entrega', TRUE
FROM subprocesos 
WHERE proceso_id = 12 AND nombre = 'Certificado de Transporte'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Remito', 'texto', NULL, NULL, NULL, TRUE, NULL, 9, 'Número de remito', TRUE
FROM subprocesos 
WHERE proceso_id = 12 AND nombre = 'Certificado de Transporte'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Datos Transportista', 'texto', NULL, NULL, NULL, TRUE, NULL, 10, 'Datos del transportista', TRUE
FROM subprocesos 
WHERE proceso_id = 12 AND nombre = 'Certificado de Transporte'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Tipo de Transporte', 'seleccion_condicional', NULL, NULL, NULL, TRUE, '["Terrestre", "A\u00e9reo", "Mar\u00edtimo", "Otros"]'::jsonb, 11, 'Tipo de transporte utilizado', TRUE
FROM subprocesos 
WHERE proceso_id = 12 AND nombre = 'Certificado de Transporte'
LIMIT 1;

-- Proceso 13: Certificado Salida Almacenamiento

INSERT INTO subprocesos (proceso_id, nombre, orden, requiere_climatizacion, cm_re_referencia, descripcion, activo)
VALUES (13, 'Certificado Salida Almacenamiento', 1, FALSE, 'CM-RE-0608', 'Certificado de salida de producto desde almacenamiento.', TRUE);
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Fecha', 'fecha', NULL, NULL, NULL, TRUE, NULL, 1, 'Fecha de salida', TRUE
FROM subprocesos 
WHERE proceso_id = 13 AND nombre = 'Certificado Salida Almacenamiento'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Código Trazabilidad Interna', 'texto', NULL, NULL, NULL, TRUE, NULL, 2, 'Código de trazabilidad interno', TRUE
FROM subprocesos 
WHERE proceso_id = 13 AND nombre = 'Certificado Salida Almacenamiento'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Código Comercial', 'texto', NULL, NULL, NULL, TRUE, NULL, 3, 'Código comercial', TRUE
FROM subprocesos 
WHERE proceso_id = 13 AND nombre = 'Certificado Salida Almacenamiento'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Motivo de la Salida', 'seleccion_condicional', NULL, NULL, NULL, TRUE, '["Venta", "Traslado", "Destrucci\u00f3n", "Muestra", "Otros"]'::jsonb, 4, 'Motivo de la salida del almacenamiento', TRUE
FROM subprocesos 
WHERE proceso_id = 13 AND nombre = 'Certificado Salida Almacenamiento'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Estado del Lote', 'seleccion', NULL, NULL, NULL, TRUE, '["Aprobado", "Rechazado", "Cuarentena"]'::jsonb, 5, 'Estado del lote al momento de la salida', TRUE
FROM subprocesos 
WHERE proceso_id = 13 AND nombre = 'Certificado Salida Almacenamiento'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'N° de Pedido', 'texto', NULL, NULL, NULL, FALSE, NULL, 6, 'Número de pedido asociado', TRUE
FROM subprocesos 
WHERE proceso_id = 13 AND nombre = 'Certificado Salida Almacenamiento'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Destino', 'texto', NULL, NULL, NULL, TRUE, NULL, 7, 'Destino de la salida', TRUE
FROM subprocesos 
WHERE proceso_id = 13 AND nombre = 'Certificado Salida Almacenamiento'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Medio de Transporte', 'texto', NULL, NULL, NULL, TRUE, NULL, 8, 'Medio de transporte utilizado', TRUE
FROM subprocesos 
WHERE proceso_id = 13 AND nombre = 'Certificado Salida Almacenamiento'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Remito', 'texto', NULL, NULL, NULL, TRUE, NULL, 9, 'Número de remito', TRUE
FROM subprocesos 
WHERE proceso_id = 13 AND nombre = 'Certificado Salida Almacenamiento'
LIMIT 1;
INSERT INTO variables (subproceso_id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, orden, descripcion, activo)
SELECT id, 'Director/a Técnico/a', 'texto', NULL, NULL, NULL, TRUE, NULL, 10, 'Firma/nombre del Director Técnico responsable', TRUE
FROM subprocesos 
WHERE proceso_id = 13 AND nombre = 'Certificado Salida Almacenamiento'
LIMIT 1;

-- ============================================================================
-- VERIFICACIÓN FINAL (QUERY CORREGIDA)
-- ============================================================================

SELECT COUNT(*) as total_subprocesos FROM subprocesos WHERE activo = TRUE;

SELECT COUNT(*) as total_variables FROM variables WHERE activo = TRUE;

-- Distribución por proceso (corregida para evitar GROUP BY error)
SELECT p.id, p.nombre, p.orden, COUNT(DISTINCT s.id) as cantidad_subprocesos
FROM procesos p
LEFT JOIN subprocesos s ON s.proceso_id = p.id AND s.activo = TRUE
GROUP BY p.id, p.nombre, p.orden
ORDER BY p.orden;

COMMIT;

-- ============================================================================
-- RESUMEN FINAL
-- ============================================================================
-- Total procesos: 13
-- Total subprocesos: 53
-- Total variables: 412
-- ✓ Todas las consideraciones del prompt_optimizado incorporadas
-- ✓ Climatización uniforme en procesos clave
-- ✓ Dropdowns condicionales (Motivo de Salida con "Otros" → textarea)
-- ✓ Medidas de Empaquetado: 40g, 400g, 1kg, +1kg bulk
-- ✓ Destino, Tipo de Transporte, Estado del Lote
-- ============================================================================
