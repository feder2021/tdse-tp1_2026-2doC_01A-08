# FIUBA - Electrónica - Taller de Sistemas Embebidos
## Trabajo Práctico N°: 1 - Diagramas de Estado - Modelado
### Archivo: tdse-tp1_00-actuator.md

---

## 1. Descripción de Eventos y Acciones del Modelo Actuator (Paso 10)

El modelo del actuador gestiona el dispositivo de salida del sistema, representado mediante un único LED indicador que simula los estados y movimientos de la barrera de acceso bajo un esquema temporizado no bloqueante (*Update by Time Code*, $\text{period} = 1\text{ ms}$).

* **Estados del Modelo (`ST_BARRIER_NAME`):**
  - `ST_BARRIER_CLOSED`: Barrera cerrada (LED apagado). Reposo.
  - `ST_BARRIER_RAISING`: Barrera en proceso de apertura (LED titilando a frecuencia 1, ej. 200 ms).
  - `ST_BARRIER_OPEN`: Barrera completamente levantada (LED encendido fijo).
  - `ST_BARRIER_LOWERING`: Barrera en proceso de cierre (LED titilando a frecuencia 2, ej. 500 ms).

* **Eventos de Entrada / Disparadores (Triggers):**
  - `EV_ACT_OPEN_BARRIER`: Orden recibida desde `System` para iniciar la apertura de la barrera.
  - `EV_ACT_CLOSE_BARRIER`: Orden recibida desde `System` para iniciar el cierre de la barrera.
  - `Tick`: Disparador periódico de 1 ms para controlar los tiempos de parpadeo y la duración del movimiento del brazo mecánico.

* **Señales o acciones:**
  - `EV_LED_ON`: Enciende el LED.
  - `EV_LED_OFF`: Apaga el LED.
  - `EV_LED_TOGGLE`: Conmuta el estado del LED.

* **Variables de control y Temporización:**
  - `tick`: Variable contador decrementable que opera en milisegundos.
  - `DEL_RAISING`: Tiempo total que tarda la barrera en levantarse (ej. 2000 ms).
  - `DEL_LOWERING`: Tiempo total que tarda la barrera en bajarse (ej. 2000 ms).
  - `DEL_FREQ_1`: Intervalo de conmutación de parpadeo rápido.
  - `DEL_FREQ_2`: Intervalo de conmutación de parpadeo lento.

---

## 2. Tabla de Transición de Estados del Actuador (Paso 11)

Secuencia principal: `ST_BARRIER_CLOSED` -> `ST_BARRIER_RAISING` -> `ST_BARRIER_OPEN` -> `ST_BARRIER_LOWERING` -> `ST_BARRIER_CLOSED`

| Current State | Event (Trigger) | [Guard] (Condición) | Next State | Actions / Effects (Excitaciones) |
| :--- | :--- | :--- | :--- | :--- |
| **ST_BARRIER_CLOSED** | `EV_ACT_OPEN_BARRIER` | — | **ST_BARRIER_RAISING** | `tick = DEL_RAISING, tick_blink = DEL_FREQ_1` |
| **ST_BARRIER_RAISING** | `Tick` *(1 ms)* | `[tick > 0]` | **ST_BARRIER_RAISING** | `tick--, (lógica toggle con tick_blink)` |
| **ST_BARRIER_RAISING** | `Tick` *(1 ms)* | `[tick == 0]` | **ST_BARRIER_OPEN** | `EV_LED_ON` |
| **ST_BARRIER_OPEN** | `EV_ACT_CLOSE_BARRIER` | — | **ST_BARRIER_LOWERING** | `tick = DEL_LOWERING, tick_blink = DEL_FREQ_2` |
| **ST_BARRIER_LOWERING** | `Tick` *(1 ms)* | `[tick > 0]` | **ST_BARRIER_LOWERING** | `tick--, (lógica toggle con tick_blink)` |
| **ST_BARRIER_LOWERING** | `Tick` *(1 ms)* | `[tick == 0]` | **ST_BARRIER_CLOSED** | `EV_LED_OFF` |