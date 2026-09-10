# FIUBA - Electrónica - Taller de Sistemas Embebidos
## Trabajo Práctico N°: 1 - Diagramas de Estado - Modelado
### Archivo: tdse-tp1_00-actuator.md

---

## 1. Descripción de Eventos y Acciones del Modelo Actuator (Paso 10)

El modelo del actuador gestiona el dispositivo de salida del sistema, representado mediante un único LED indicador que simula los estados y movimientos de la barrera de acceso bajo un esquema temporizado no bloqueante (*Update by Time Code*, $\text{period} = 1\text{ ms}$).

Para representar visualmente los estados de transición o movimiento físico de la barrera (apertura y cierre), este modelo utiliza patrones de parpadeo a distintas frecuencias en el LED (`DEL_FREQ_1` y `DEL_FREQ_2`). De esta forma, el LED permanece apagado en reposo, enciende de forma fija cuando la barrera está abierta, y conmuta periódicamente a diferentes velocidades durante sus movimientos de elevación y descenso sin utilizar esperas bloqueantes.

* **Estados del Modelo (`ST_BARRIER_NAME`):**
  - `ST_BARRIER_CLOSED`: Barrera cerrada (LED apagado). Estado de reposo.
  - `ST_BARRIER_RAISING`: Barrera en proceso de apertura (LED titilando a frecuencia 1, ej. 200 ms).
  - `ST_BARRIER_OPEN`: Barrera completamente levantada (LED encendido fijo).
  - `ST_BARRIER_LOWERING`: Barrera en proceso de cierre (LED titilando a frecuencia 2, ej. 500 ms).

* **Eventos de Entrada / Disparadores (Triggers):**
  - `EV_ACT_OPEN_BARRIER`: Orden recibida desde `System` para iniciar la apertura de la barrera.
  - `EV_ACT_CLOSE_BARRIER`: Orden recibida desde `System` para iniciar el cierre de la barrera.
  - `EV_TICK`: Disparador periódico de 1 ms para controlar los tiempos de parpadeo y la duración del movimiento del brazo mecánico.

* **Señales y Acciones sobre el Hardware (GPIO):**
  - `EV_LED_ON`: Enciende el LED.
  - `EV_LED_OFF`: Apaga el LED.
  - `EV_LED_TOGGLE`: Conmuta el estado lógico del LED.

* **Variables de Control y Temporización:**
  - `tick`: Variable contador decrementable que opera en milisegundos para medir la duración total de los movimientos de la barrera.
  - `DEL_RAISING`: Constante de tiempo total que tarda la barrera en levantarse (ej. 2000 ms).
  - `DEL_LOWERING`: Constante de tiempo total que tarda la barrera en bajarse (ej. 2000 ms).
  - `tick_blink`: Variable contador decrementable que opera en milisegundos para controlar la frecuencia de parpadeo del LED.
  - `DEL_FREQ_1`: Intervalo de conmutación para el parpadeo rápido (frecuencia 1, ej. 200 ms).
  - `DEL_FREQ_2`: Intervalo de conmutación para el parpadeo lento (frecuencia 2, ej. 500 ms).

---

## 2. Tabla de Transición de Estados del Actuador (Paso 11)

Secuencia principal: `ST_BARRIER_CLOSED` -> `ST_BARRIER_RAISING` -> `ST_BARRIER_OPEN` -> `ST_BARRIER_LOWERING` -> `ST_BARRIER_CLOSED`


| Current State | Event (Trigger) | [Guard] (Condición) | Next State | Actions / Effects (Excitaciones) |
| :--- | :--- | :--- | :--- | :--- |
| **ST_BARRIER_CLOSED** | `EV_ACT_OPEN_BARRIER` | — | **ST_BARRIER_RAISING** | `tick = DEL_RAISING; tick_blink = DEL_FREQ_1` |
| **ST_BARRIER_RAISING** | `EV_TICK` *(1 ms)* | `[tick > 0 && tick_blink > 0]` | **ST_BARRIER_RAISING** | `tick--; tick_blink--` |
| **ST_BARRIER_RAISING** | `EV_TICK` *(1 ms)* | `[tick_blink == 0]` | **ST_BARRIER_RAISING** | `EV_LED_TOGGLE; tick_blink = DEL_FREQ_1` |
| **ST_BARRIER_RAISING** | `EV_TICK` *(1 ms)* | `[tick == 0]` | **ST_BARRIER_OPEN** | `EV_LED_ON` |
| **ST_BARRIER_OPEN** | `EV_ACT_CLOSE_BARRIER` | — | **ST_BARRIER_LOWERING** | `tick = DEL_LOWERING; tick_blink = DEL_FREQ_2` |
| **ST_BARRIER_LOWERING** | `EV_TICK` *(1 ms)* | `[tick > 0 && tick_blink > 0]` | **ST_BARRIER_LOWERING** | `tick--; tick_blink--` |
| **ST_BARRIER_LOWERING** | `EV_TICK` *(1 ms)* | `[tick_blink == 0]` | **ST_BARRIER_LOWERING** | `EV_LED_TOGGLE; tick_blink = DEL_FREQ_2` |
| **ST_BARRIER_LOWERING** | `EV_TICK` *(1 ms)* | `[tick == 0]` | **ST_BARRIER_CLOSED** | `EV_LED_OFF` |