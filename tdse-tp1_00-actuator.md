# FIUBA - Electrónica - Taller de Sistemas Embebidos
## Trabajo Práctico N° 1 - Diagramas de Estado - Modelado
### Archivo: `tdse-tp1_00-actuator.md`

---

## 1. Descripción de Eventos y Acciones del Modelo Actuator (Paso 10)

El modelo del actuador gestiona el dispositivo de salida del sistema, representado mediante un único LED indicador que simula los estados y movimientos de la barrera de acceso (*Barrier Gate*) bajo un esquema temporizado no bloqueante (*Update by Time Code*, $\text{period} = 1\text{ ms}$).

Para representar visualmente tanto el estado de reposo como las transiciones físicas del brazo mecánico de la barrera (elevación y descenso), este modelo utiliza patrones de parpadeo a distintas frecuencias en el LED (`DEL_FREQ_1` y `DEL_FREQ_2`). De esta manera:
- En reposo (barrera cerrada), el LED permanece totalmente apagado.
- Durante el proceso de apertura (elevación), el LED conmuta periódicamente a frecuencia rápida 1.
- Con la barrera completamente levantada, el LED permanece encendido de forma fija.
- Durante el proceso de cierre (descenso), el LED conmuta periódicamente a frecuencia media 2.

Esta temporización de frecuencias se implementa mediante contadores decrecientes (`tick--`) accionados por el evento de reloj `EV_TICK`, garantizando la ejecución no bloqueante de la CPU.

* **Estados del Modelo (`ST_BARRIER_NAME`):**
  - `ST_BARRIER_CLOSED`: Barrera cerrada (LED apagado). Estado de reposo y restricción de paso.
  - `ST_BARRIER_RAISING`: Barrera en proceso de apertura (LED titilando a frecuencia 1, ej. 200 ms).
  - `ST_BARRIER_OPEN`: Barrera completamente levantada (LED encendido fijo)[cite: 1].
  - `ST_BARRIER_LOWERING`: Barrera en proceso de cierre (LED titilando a frecuencia 2, ej. 500 ms).

* **Eventos de Entrada / Disparadores (Triggers):**
  - `EV_ACT_OPEN_BARRIER`: Orden recibida desde el módulo `System` para iniciar la apertura de la barrera.
  - `EV_ACT_CLOSE_BARRIER`: Orden recibida desde el módulo `System` para iniciar el cierre de la barrera.
  - `EV_TICK`: Disparador periódico de 1 ms para controlar la temporización decreciente del movimiento y los intervalos de conmutación del parpadeo.

* **Señales y Acciones sobre el Hardware (GPIO):**
  - `EV_LED_ON`: Enciende el LED de la barrera.
  - `EV_LED_OFF`: Apaga el LED de la barrera.
  - `EV_LED_TOGGLE`: Conmuta el estado lógico del LED.

* **Variables de Control y Temporización:**
  - `tick`: Variable contador decrementable (en milisegundos) para medir la duración total del movimiento de la barrera.
  - `DEL_RAISING`: Tiempo total que tarda la barrera en levantarse (ej. 2000 ms).
  - `DEL_LOWERING`: Tiempo total que tarda la barrera en bajarse (ej. 2000 ms).
  - `tick_blink`: Variable contador decrementable (en milisegundos) para controlar los intervalos de parpadeo.
  - `DEL_FREQ_1`: Intervalo de conmutación para el parpadeo rápido en ascenso (ej. 200 ms).
  - `DEL_FREQ_2`: Intervalo de conmutación para el parpadeo lento en descenso (ej. 500 ms).

---

## 2. Tabla de Transición de Estados del Actuador (Paso 11)

Secuencia principal:  
`ST_BARRIER_CLOSED` $\longrightarrow$ `ST_BARRIER_RAISING` $\longrightarrow$ `ST_BARRIER_OPEN` $\longrightarrow$ `ST_BARRIER_LOWERING` $\longrightarrow$ `ST_BARRIER_CLOSED`

Las transiciones autorreferentes dentro de los estados de movimiento (`ST_BARRIER_RAISING` y `ST_BARRIER_LOWERING`) evalúan explícitamente el contador de parpadeo `tick_blink` para decrementar las variables en cada `EV_TICK` (1 ms) y emitir la conmutación `EV_LED_TOGGLE` al expirar la cuenta.

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