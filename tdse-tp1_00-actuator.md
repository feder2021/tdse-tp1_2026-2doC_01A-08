# FIUBA - Electrónica - Taller de Sistemas Embebidos
## Trabajo Práctico N°: 1 - Diagramas de Estado - Modelado
### Archivo: tdse-tp1_00-actuator.md

---

# FIUBA - Electrónica - Taller de Sistemas Embebidos
## Trabajo Práctico N°: 1 - Diagramas de Estado - Modelado
### Archivo: tdse-tp1_00-actuator.md

---

## 1. Descripción de Eventos y Acciones del Modelo Actuator (Paso 10)

El modelo del actuador gestiona el dispositivo de salida del sistema (representado mediante un LED indicador de estado) bajo un esquema temporizado no bloqueante (*Update by Time Code*, $\text{period} = 1\text{ ms}$). Su función es traducir las órdenes emitidas por el módulo de procesamiento (*System Statechart*) en respuestas físicas visibles y patrones de parpadeo diferenciados.

* **Estados del Modelo (`ST_LED_NAME`):**
  - `ST_LED_OFF`: Estado en el cual el actuador/LED se encuentra apagado (nivel bajo), indicando barrera cerrada o reposo.
  - `ST_LED_ON`: Estado en el cual el actuador/LED se encuentra encendido de forma fija (nivel alto), indicando barrera abierta.
  - `ST_LED_BLINKING_SLOW`: Estado donde el LED titila de manera intermitente a baja velocidad, indicando presencia vehicular / bienvenida.
  - `ST_LED_BLINKING_FAST`: Estado donde el LED titila de manera intermitente a alta velocidad, indicando proceso activo (impresión de ticket).

* **Eventos de Entrada / Disparadores (Triggers):**
  - `EV_ACT_WELCOME`: Señal recibida para indicar presencia vehicular, activando el modo intermitente lento.
  - `EV_ACT_PRINT_START`: Señal recibida para iniciar la impresión, activando el modo intermitente rápido.
  - `EV_ACT_BARRIER_UP`: Señal recibida para abrir la barrera, encendiendo el indicador de forma fija.
  - `EV_ACT_BARRIER_DOWN`: Señal recibida para cerrar la barrera, apagando el indicador.
  - `Tick` / `Timeout`: Disparadores periódicos de 1 ms para controlar los intervalos de conmutación del parpadeo.

* **Acciones y Efectos:**
  - Modificación de salidas digitales mediante funciones de bajo nivel o eventos de salida (ej. `raise EV_LED_OFF`, `raise EV_LED_ON`, `raise EV_LED_TOGGLE`).
  - Inicialización, decremento o recarga de variables de control de tiempo (`tick`).

* **Variables de Control y Temporización:**
  - `tick`: Variable contador decrementable que opera en milisegundos.
  - `DEL_BLINK_SLOW`: Constante de tiempo para el periodo de parpadeo lento (ej. 1000 ms).
  - `DEL_BLINK_FAST`: Constante de tiempo para el periodo de parpadeo rápido (ej. 200 ms).

---

## 2. Tabla de Transición de Estados del Actuador (Paso 11)

| Current State | Event (Trigger) | [Guard] (Condición) | Next State | Actions / Effects (Excitaciones) |
| :--- | :--- | :--- | :--- | :--- |
| **ST_LED_OFF** | `EV_ACT_WELCOME` | | **ST_LED_BLINKING_SLOW** | `tick = DEL_BLINK_SLOW` |
| **ST_LED_OFF** | `EV_ACT_PRINT_START` | | **ST_LED_BLINKING_FAST** | `tick = DEL_BLINK_FAST` |
| **ST_LED_OFF** | `EV_ACT_BARRIER_UP` | | **ST_LED_ON** | `raise EV_LED_ON` |
| **ST_LED_ON** | `EV_ACT_BARRIER_DOWN` | | **ST_LED_OFF** | `raise EV_LED_OFF` |
| **ST_LED_ON** | `EV_ACT_PRINT_START` | | **ST_LED_BLINKING_FAST** | `tick = DEL_BLINK_FAST` |
| **ST_LED_ON** | `EV_ACT_WELCOME` | | **ST_LED_BLINKING_SLOW** | `tick = DEL_BLINK_SLOW` |
| **ST_LED_BLINKING_SLOW** | `Tick` *(1 ms)* | `[tick > 0]` | **ST_LED_BLINKING_SLOW** | `tick--` |
| **ST_LED_BLINKING_SLOW** | `Tick` *(1 ms)* | `[tick == 0]` *(Timeout)* | **ST_LED_BLINKING_SLOW** | `raise EV_LED_TOGGLE`, `tick = DEL_BLINK_SLOW` |
| **ST_LED_BLINKING_SLOW** | `EV_ACT_PRINT_START` | | **ST_LED_BLINKING_FAST** | `tick = DEL_BLINK_FAST` |
| **ST_LED_BLINKING_SLOW** | `EV_ACT_BARRIER_UP` | | **ST_LED_ON** | `raise EV_LED_ON` |
| **ST_LED_BLINKING_SLOW** | `EV_ACT_BARRIER_DOWN` | | **ST_LED_OFF** | `raise EV_LED_OFF` |
| **ST_LED_BLINKING_FAST** | `Tick` *(1 ms)* | `[tick > 0]` | **ST_LED_BLINKING_FAST** | `tick--` |
| **ST_LED_BLINKING_FAST** | `Tick` *(1 ms)* | `[tick == 0]` *(Timeout)* | **ST_LED_BLINKING_FAST** | `raise EV_LED_TOGGLE`, `tick = DEL_BLINK_FAST` |
| **ST_LED_BLINKING_FAST** | `EV_ACT_BARRIER_UP` | | **ST_LED_ON** | `raise EV_LED_ON` |
| **ST_LED_BLINKING_FAST** | `EV_ACT_BARRIER_DOWN` | | **ST_LED_OFF** | `raise EV_LED_OFF` |