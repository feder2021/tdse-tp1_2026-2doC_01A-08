# FIUBA - Electrónica - Taller de Sistemas Embebidos

## Trabajo Práctico N° 1 - Diagramas de Estado - Modelado

### Archivo: `tdse-tp1_00-problem_approach.md`

---

## 1. Solución de COMA Electronics

Como referencia para el desarrollo del proyecto se toma el **Intelligent Parking Management System** de COMA Electronics, un sistema destinado a la gestión integral y automatizada de estacionamientos (*Automated Parking System*).

La solución se divide en dos áreas principales:

* **Área de Entrada (Entry):** Gestionada por la máquina dispensadora de tickets (*Parking Ticket Dispenser Machine* - PTDM), la cual detecta la llegada del vehículo, valida las condiciones, interactúa con el usuario mediante pantallas e intercomunicadores, imprime un ticket con fecha/hora y emite la señal de apertura a la barrera vehicular.
* **Área de Pago Centralizado y Salida (Exit):** Terminales automáticas para el cobro y validación de la estadía con tiempo de gracia antes del egreso.

Dentro de esta solución se toma como referencia la **Parking Ticket Dispenser Machine (Entry)**.

---

## 2. Implementación de la Parking Ticket Dispenser Machine (Entry)

Para el desarrollo del proyecto se implementa un **Producto Mínimo Viable (MVP)** que replica el comportamiento de la terminal de entrada.

El comportamiento del sistema se organiza de forma modular en tres capas (*Escrutar, Procesar, Actuar*) sincronizadas mediante un esquema temporizado no bloqueante (*Update by Time Code*) de ejecución cíclica cada 1 ms ($1\text{ ms}$):

* **Sensor (Escrutar):** Encargado de capturar y filtrar las entradas del sistema (como `Camera`, `Button` y `Sensor Coil`) aplicando algoritmos anti-rebote (*debouncing*).
* **System (Procesar):** Encargado de procesar los eventos limpios recibidos desde los sensores, evaluar la máquina de estados lógicos (FSM) y determinar las acciones a realizar.
* **Actuator (Actuar):** Encargado de controlar el comportamiento de las salidas digitales (como `Display`, `Printer`, `Barrier` y `Server`).

La arquitectura de comunicación entre módulos es:

$$\text{Sensor (Escrutar)} \longrightarrow \text{System (Procesar)} \longrightarrow \text{Actuator (Actuar)}$$

---

## 3. Modelos de Comportamiento de los Módulos (Temporizado, $T = 1\text{ ms}$)

Los tres módulos se implementan en código C como máquinas de estados temporizadas de ejecución no bloqueante:

* **Modelo Sensor (`Sensor Statechart`):** Ejecutado cada 1 ms. Recorre las entradas digitales, filtra ruidos mecánicos mediante temporizadores decrecientes (`tick--`) e inyecta eventos validados (`EV_SYS_...`) hacia el módulo central.
* **Modelo Sistema (`System Statechart`):** Ejecutado cada 1 ms. Recibe las señales de los sensores, evalúa las condiciones de la terminal y genera las órdenes dirigidas hacia los actuadores (`EV_ACT_...`).
* **Modelo Actuador (`Actuator Statechart`):** Ejecutado cada 1 ms. Recibe las órdenes del sistema y controla el estado de las salidas físicas o patrones visuales (encendido, apagado, parpadeos/pulsos) sin bloquear la CPU.

---

## 4. Reemplazo de Sensores y Actuadores en Prototipo

Para las pruebas de laboratorio se sustituyen los componentes físicos reales por periféricos binarios simples:

### Digital Inputs $\rightarrow$ Sensor

| Sensor Real | Reemplazo | Descripción / Modus Operandi |
| :--- | :--- | :--- |
| `Camera` | Interruptor DIP Switch | Representa la presencia continua de un vehículo en la entrada. |
| `Button` | Pulsador | Simula la acción momentánea del usuario al solicitar un ticket. |
| `Sensor Coil` | Interruptor DIP Switch | Simula la activación del lazo magnético cuando el auto cruza. |

### Digital Outputs $\rightarrow$ Actuator

| Actuador Real | Reemplazo | Descripción / Modus Operandi |
| :--- | :--- | :--- |
| `Display` | LED | Indicador de estado / mensaje de bienvenida. |
| `Printer` | LED | Representación visual del proceso de impresión activo. |
| `Barrier` | LED | Indicador visual de barrera levantada (encendido) / cerrada (apagado). |
| `Server` | LED | Confirmación de comunicación/registro con el servidor central. |