# C_Paralela_Distribuida_C2
## Caso de estudio 1
Caso propuesto: "Procesamiento paralelo de datos en un sistema de reservas aéreas”
### Contexto
Una aerolínea internacional desarrolla un sistema que debe:

- Calcular rápidamente tarifas dinámicas usando algoritmos recursivos.

- Procesar millones de reservas usando streams paralelos.

- Evitar errores cuando múltiples usuarios intentan reservar el último asiento disponible al mismo tiempo.

### Preguntas
1. ¿Cómo aplicarían memorización para optimizar el cálculo de tarifas dinámicas que se repiten constantemente?

2. ¿Qué ventajas tendría usar Streams de Java en el procesamiento paralelo de reservas y búsqueda de vuelos?

3. Identifiquen un posible escenario de condición de carrera en el sistema de reservas y propongan una estrategia 
para mantener el determinismo.

### Entregable
Ensayo de 3–5 páginas con:
- Definición del problema.

- Análisis de cómo aplicar cada concepto.

- Propuesta de solución con ventajas y riesgos.

- Comparación con un caso real investigado por ellos (ejemplo: sistemas de reservas como Amadeus, Sabre, o Despegar).

---

## Caso de estudio 2
Caso: Procesamiento de imágenes satelitales
Una empresa de monitoreo ambiental recibe imágenes satelitales de 10.000 x 10.000 píxeles. 
Cada píxel debe analizarse para determinar el nivel de vegetación (NDVI).

### Preguntas de análisis:
1. ¿Cómo se podría paralelizar el procesamiento de los píxeles usando bucles paralelos?

2. ¿Qué esquema de distribución de iteraciones (estático o dinámico) sería más eficiente si algunas 
áreas de la imagen requieren más cómputo?

3. ¿Qué riesgos de condiciones de carrera existirían si los hilos actualizan una variable global con 
resultados parciales?

Propongan una forma de organizar el algoritmo para garantizar determinismo.

### Actividad propuesta: “Procesamiento paralelo de listas en Python
Paralelización en Python con multiprocessing
https://www.youtube.com/watch?v=fKl2JW_qrso
#### Enunciado
La empresa EcoData recopila información de sensores ambientales (temperatura, humedad, CO2) de 1 millón de registros. 
Cada registro debe ser procesado para calcular un “índice de confort ambiental” con la fórmula:

**Indice = (Temperatura X 0.4) + (Humedad X 0.3) + (CO2 X 0.3)**

Escriba un programa en Python que genere de manera aleatoria una lista de 1 millón de registros, cada uno con los 
tres valores mencionados.
Programe dos versiones de la solución:

- Versión secuencial: recorre la lista completa y calcula el índice de cada 
registro.

- Versión paralela: divida la lista en 4 sublistas y use multiprocessing para que 4 procesos trabajen en paralelo 
sobre cada sublista.

Compare los tiempos de ejecución de ambas versiones.
Explique si hubo speedup y qué limitaciones observó.

### Entregable
Script en Python con ambas versiones.
Un documento breve (1–2 páginas) donde:

- Expliquen cómo usaron multiprocessing.

- Comparen tiempos de ejecución.

- Reflexionen sobre qué tipo de problemas sí se benefician de paralelismo y cuáles no.

