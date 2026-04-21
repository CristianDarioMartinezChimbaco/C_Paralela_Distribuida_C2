# Solucion 
## 1. ¿Cómo se podría paralelizar el procesamiento de los píxeles usando bucles paralelos?

El procesamiento puede paralelizarse dividiendo la imagen en bloques o filas y asignando cada parte a diferentes 
hilos de ejecución.

Cada píxel puede procesarse de forma independiente, lo que hace este problema ideal para paralelización.

Ejemplo conceptual:

Opción 1 — Paralelizar por filas

Se le van asignando filas a cada hilo, para qule los hilos no trabajen sobre filas ya trabajadas sele asigna un rango 
de filas

Hilo 1 → filas 0–2499

Hilo 2 → filas 2500–4999

Hilo 3 → filas 5000–7499

Hilo 4 → filas 7500–9999

Tambien se podria por columnas o incluso seciones de filas y columnas


Esto permite que múltiples núcleos procesen simultáneamente.


---

## 2. ¿Qué esquema de distribución sería más eficiente?

Si algunas áreas requieren más cómputo, entonces la mejor opción es:

Distribución dinámica

Porque:

Balancea la carga automáticamente

Evita que algunos hilos queden inactivos

Mejora el rendimiento general

### Comparación

| Tipo 		| Ventaja	Desventaja 							|
|-----------|-----------------------------------------------|
| Estático 	| Menor overhead	Puede desbalancear carga 	|
| Dinámico 	| Mejor balance	Mayor overhead 					|


Para este caso, dinámico es mejor

---

## 3. Riesgos de condiciones de carrera

Si varios hilos actualizan una variable global podrían ocurrir, resultados incorrectos, pérdida de datos, 
comportamiento no determinista


Ejemplo del problema:

Hilo 1 lee total = 10

Hilo 2 lee total = 10

Hilo 1 suma 5 → total = 15

Hilo 2 suma 3 → total = 13 (error)

---

## Forma de garantizar determinismo

Se puede usar:

Opción 1 — Reducción

Opción 2 — Variables locales por hilo

Cada hilo calcula su resultado y luego se combinan al final:

total_local = 0;
- cada hilo suma
- luego combinar resultados


---

Conclusión

El procesamiento puede paralelizarse dividiendo la imagen en filas o bloques

La distribución dinámica es más eficiente si el cómputo varía

Existen riesgos de condiciones de carrera al usar variables globales

El determinismo se garantiza usando reducción o variables locales
