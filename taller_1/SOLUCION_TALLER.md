#  Procesamiento paralelo de datos en un sistema de reservas aéreas

## Introducción

Las aerolíneas modernas operan en entornos altamente demandantes donde miles o incluso millones de usuarios realizan búsquedas y 
reservas de vuelos de manera simultánea. Esto exige sistemas altamente eficientes, escalables y confiables. Para lograrlo, se 
emplean técnicas de computación paralela y distribuida que permiten procesar grandes volúmenes de datos, mejorar los tiempos de 
respuesta y evitar inconsistencias en la información.

El presente ensayo analiza un sistema de reservas aéreas que debe calcular tarifas dinámicas mediante algoritmos recursivos, 
procesar millones de reservas en paralelo y evitar errores cuando múltiples usuarios intentan reservar el último asiento disponible. 
Se abordarán tres conceptos fundamentales: memorización, streams paralelos en Java y manejo de condiciones de carrera.

---

## Definición del Problema

Una aerolínea internacional necesita desarrollar un sistema de reservas capaz de:

- Calcular tarifas dinámicas rápidamente

- Procesar millones de reservas simultáneamente

- Evitar conflictos cuando múltiples usuarios intentan reservar el mismo asiento

Este tipo de sistemas enfrenta varios retos técnicos importantes:

1. Alto volumen de solicitudes simultáneas

2. Necesidad de cálculos complejos en tiempo real

3. Garantizar consistencia de datos

4. Minimizar tiempos de respuesta

5. Escalabilidad del sistema

Para resolver estos desafíos, se propone el uso de técnicas de programación paralela y concurrente que permitan mejorar el 
rendimiento y la confiabilidad del sistema.

---

## Memorización para Optimizar el Cálculo de Tarifas Dinámicas

La memorización (memoization) es una técnica de optimización que consiste en almacenar los resultados de cálculos costosos para 
reutilizarlos posteriormente sin tener que recalcularlos. Esta técnica es especialmente útil cuando se utilizan algoritmos recursivos, 
ya que evita cálculos repetitivos.

### Aplicación en el Sistema de Reservas

En un sistema de reservas aéreas, el cálculo de tarifas dinámicas puede depender de múltiples factores:

- Demanda del vuelo

- Disponibilidad de asiento

- Temporada

- Anticipación de la compra

- Ruta del vuelo

Estos cálculos suelen repetirse constantemente. Por ejemplo, miles de usuarios pueden consultar el mismo vuelo dentro de un corto 
período de tiempo. Sin memorización, el sistema recalcularía la tarifa cada vez, aumentando el consumo de recursos.

### Solución con Memorización

Se puede implementar una caché que almacene los resultados previamente calculados:

Ejemplo conceptual:

*Entrada:* Ruta + Fecha + Clase + Demanda

*Salida:* Tarifa calculada

Cuando el sistema recibe una solicitud:

1. Verifica si la tarifa ya fue calculada

2. Si existe en caché, retorna el valor

3. Si no existe, calcula la tarifa y la guarda

### Ventajas

Reducción significativa del tiempo de cálculo

- Menor consumo de CPU

- Mejor rendimiento del sistema

- Mayor escalabilidad

### Riesgos

- Consumo adicional de memoria

- Necesidad de invalidar caché cuando cambian las condiciones

- Complejidad en la sincronización en entornos concurrentes

---

## Streams Paralelos de Java en el Procesamiento de Reservas

Los Streams paralelos en Java permiten procesar colecciones de datos utilizando múltiples núcleos del procesador. Esto permite dividir
el trabajo en múltiples tareas que se ejecutan simultáneamente.

### Aplicación en el Sistema

Los streams paralelos pueden utilizarse en:

Búsqueda de vuelos

- Procesamiento de reservas

- Cálculo de tarifas masivas

- Análisis de disponibilidad


Ejemplo conceptual:

- Procesar millones de vuelos disponibles:

- Filtrar vuelos disponibles

- Calcular tarifas

- Ordenar resultados


Todo esto puede realizarse en paralelo utilizando streams paralelos.

## Ventajas

- Aprovechamiento de múltiples núcleos

- Mejor rendimiento

- Código más limpio y legible

- Escalabilidad automática

## Riesgos

- Sobrecarga si los datos son pequeños

- Problemas de concurrencia

- Mayor consumo de memoria

- Operaciones no deterministas si no se manejan correctamente

---

## Condiciones de Carrera en el Sistema de Reservas

Una condición de carrera ocurre cuando múltiples hilos acceden a un recurso compartido y el resultado depende del orden de ejecución.

Escenario Posible

Dos usuarios intentan reservar el último asiento disponible:

1. Usuario A verifica disponibilidad (1 asiento)


2. Usuario B verifica disponibilidad (1 asiento)


3. Usuario A reserva el asiento


4. Usuario B también reserva el asiento

Resultado: Sobreventa del vuelo

### Estrategias para Mantener el Determinismo

1. Bloqueo (Locks)

Se puede bloquear el acceso al asiento mientras se procesa la reserva.

Ventajas:

- Garantiza consistencia

- Evita sobreventas


Desventajas:

- Reduce rendimiento

- Posible bloqueo del sistema


2. Sincronización

Uso de métodos sincronizados o estructuras concurrentes.

- Ejemplos:

- synchronized

- ReentrantLock

AtomicInteger

3. Control Optimista

Se utiliza versionado de datos:

- Leer versión

- Intentar actualizar

- Si cambió, repetir

Ventajas:

Mayor rendimiento

Mejor escalabilidad

4. Base de Datos con Transacciones

Uso de:

Transacciones ACID

Bloqueos a nivel de fila

Esta es la solución más utilizada en sistemas reales.

---

## Propuesta de Solución

Se propone una arquitectura híbrida:

### Componentes

1. Memorización para tarifas dinámicas


2. Streams paralelos para procesamiento masivo


3. Control de concurrencia para reservas


4. Base de datos transaccional


### Flujo del Sistema

1. Usuario busca vuelo


2. Sistema calcula tarifa usando memorización


3. Streams paralelos procesan resultados


4. Usuario selecciona asiento


5. Sistema aplica control de concurrencia


6. Reserva confirmada

### Ventajas

Alto rendimiento

Escalabilidad

Consistencia de datos

Mejor experiencia del usuario

### Riesgos

Complejidad de implementación

Costos de infraestructura

Posibles problemas de sincronización

---

## Comparación con Sistemas Reales

Los sistemas reales de reservas aéreas utilizan arquitecturas distribuidas altamente optimizadas.

### Amadeus

Arquitectura distribuida

Procesamiento paralelo

Alta disponibilidad


### Sabre

Manejo de millones de transacciones

Control de concurrencia avanzado

Escalabilidad global


### Despegar

Microservicios

Procesamiento paralelo

Cache distribuido


Estos sistemas implementan técnicas similares a las propuestas:

Uso de caché

Procesamiento paralelo

Control de concurrencia

Sistemas distribuidos

---

## Conclusión

El procesamiento paralelo es fundamental para sistemas de reservas aéreas modernos. El uso de memorización permite optimizar cálculos 
repetitivos, mientras que los streams paralelos mejoran el rendimiento en el procesamiento masivo de datos. Además, el manejo 
adecuado de condiciones de carrera garantiza la consistencia y confiabilidad del sistema.

La combinación de estas técnicas permite desarrollar sistemas escalables, eficientes y seguros. Los sistemas reales como Amadeus, 
Sabre y Despegar ya implementan estas estrategias, lo que demuestra la importancia de la computación paralela y distribuida en
aplicaciones empresariales de gran escala.
