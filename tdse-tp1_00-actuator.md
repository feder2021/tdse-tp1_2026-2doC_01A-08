# FIUBA - Electrónica - Taller de Sistemas Embebidos
## Trabajo Práctico N°: 1 - Diagramas de Estado - Modelado
### Archivo: tdse-tp1_00-actuator.md

---

## 1. Descripción de Eventos y Acciones del Modelo Actuator (Paso 10)

El modelo del actuador gestiona el dispositivo de salida del sistema, representado mediante un LED indicador de estado, bajo un esquema temporizado no bloqueante (*Update by Time Code*, $\text{period} = 1\text{ ms}$).

Su función es traducir las órdenes emitidas por el módulo de procesamiento (*System Statechart*) en respuestas físicas visibles mediante diferentes estados del LED.

El comportamiento esperado del actuador sigue la siguiente secuencia:

Vehículo detectado → Parpadeo lento → Botón de impresión → Parpadeo rápido → Barrera arriba → LED encendido fijo → Barrera abajo → LED apagado  
*(Escape por inactividad: Parpadeo lento → LED apagado)*

### Estados del Modelo (`ST_LED_NAME`)
* `ST_LED_OFF`: Estado inicial y de reposo. El LED se encuentra apagado (LOW), indicando que la barrera está cerrada y no hay un proceso activo.
* `ST_LED_BLINKING_SLOW`: Estado en el cual el LED titila a baja velocidad. Se activa cuando se detecta la presencia de un vehículo y representa la espera para iniciar la operación de impresión.
* `ST_LED_BLINKING_FAST`: Estado en el cual el LED titila a alta velocidad. Se activa cuando se presiona el botón para iniciar la impresión del ticket y representa que el proceso de impresión está activo.
* `ST_LED_ON`: Estado en el cual el LED permanece encendido de forma fija (HIGH). Se alcanza cuando la barrera se levanta y representa que el vehículo puede avanzar.

### Eventos de Entrada / Disparadores (Triggers)
* `EV_ACT_WELCOME`: Señal recibida para indicar la presencia de un vehículo. Produce la transición desde `ST_LED_OFF` hacia `ST_LED_BLINKING_SLOW`.
* `EV_ACT_PRINT_START`: Señal recibida cuando se presiona el botón de impresión. Produce la transición desde `ST_LED_BLINKING_SLOW` hacia `ST_LED_BLINKING_FAST`.
* `EV_ACT_BARRIER_UP`: Señal recibida para indicar que la barrera se levantó. Produce la transición desde `ST_LED_BLINKING_FAST` hacia `ST_LED_ON`.
* `EV_ACT_BARRIER_DOWN`: Señal recibida para indicar que la barrera se bajó tras completar el paso. Produce la transición desde `ST_LED_ON` hacia `ST_LED_OFF`.
* `EV_ACT_OFF`: Señal recibida para apagar el indicador tras la cancelación por inactividad (el vehículo se retiró). Produce la transición desde `ST_LED_BLINKING_SLOW` hacia `ST_LED_OFF`.
* `Tick`: Disparador periódico de 1 ms utilizado para implementar el parpadeo de manera no bloqueante. Permite decrementar el contador `tick` y producir el cambio de estado lógico del LED cuando el contador alcanza cero.

### Acciones y Efectos
Las acciones asociadas a las transiciones permiten controlar la salida del LED y el temporizador:
* `EV_LED_OFF`: apaga el LED.
* `EV_LED_ON`: enciende el LED.
* `EV_LED_TOGGLE`: conmuta el estado lógico del LED.
* `tick--`: decrementa el contador de tiempo en 1 ms.
* `tick = DEL_BLINK_SLOW`: recarga el contador con el intervalo correspondiente al parpadeo lento.
* `tick = DEL_BLINK_FAST`: recarga el contador con el intervalo correspondiente al parpadeo rápido.

### Variables de Control y Temporización
* `tick`: Variable contador decrementable utilizada para medir el tiempo restante hasta la próxima conmutación del LED.
* `DEL_BLINK_SLOW`: Constante utilizada para determinar el intervalo de conmutación del parpadeo lento. Valor de referencia: 1000 ms.
* `DEL_BLINK_FAST`: Constante utilizada para determinar el intervalo de conmutación del parpadeo rápido. Valor de referencia: 200 ms.

El contador `tick` es actualizado mediante un `Tick` periódico cada 1 ms, evitando el uso de esperas bloqueantes.

---

## 2. Tabla de Transición de Estados del Actuador (Paso 11)

El modelo implementa la secuencia operacional:

`ST_LED_OFF` -> `ST_LED_BLINKING_SLOW` -> `ST_LED_BLINKING_FAST` -> `ST_LED_ON` -> `ST_LED_OFF`  
*(Escape por inactividad: `ST_LED_BLINKING_SLOW` -> `ST_LED_OFF`)*

Las transiciones de temporización dentro de los estados de parpadeo son autorreferentes, es decir, permanecen en el mismo estado mientras controlan el tiempo de conmutación del LED.

| Current State | Event (Trigger) | [Guard] (Condición) | Next State | Actions / Effects (Excitaciones) |
| :--- | :--- | :--- | :--- | :--- |
| **ST_LED_OFF** | `EV_ACT_WELCOME` | — | **ST_LED_BLINKING_SLOW** | `tick = DEL_BLINK_SLOW` |
| **ST_LED_BLINKING_SLOW** | `Tick` *(1 ms)* | `[tick > 0]` | **ST_LED_BLINKING_SLOW** | `tick--` |
| **ST_LED_BLINKING_SLOW** | `Tick` *(1 ms)* | `[tick == 0]` | **ST_LED_BLINKING_SLOW** | `EV_LED_TOGGLE, tick = DEL_BLINK_SLOW` |
| **ST_LED_BLINKING_SLOW** | `EV_ACT_OFF` | — | **ST_LED_OFF** | `EV_LED_OFF` *(Cancelación por inactividad)* |
| **ST_LED_BLINKING_SLOW** | `EV_ACT_PRINT_START` | — | **ST_LED_BLINKING_FAST** | `tick = DEL_BLINK_FAST` |
| **ST_LED_BLINKING_FAST** | `Tick` *(1 ms)* | `[tick > 0]` | **ST_LED_BLINKING_FAST** | `tick--` |
| **ST_LED_BLINKING_FAST** | `Tick` *(1 ms)* | `[tick == 0]` | **ST_LED_BLINKING_FAST** | `EV_LED_TOGGLE, tick = DEL_BLINK_FAST` |
| **ST_LED_BLINKING_FAST** | `EV_ACT_BARRIER_UP` | — | **ST_LED_ON** | `EV_LED_ON` |
| **ST_LED_ON** | `EV_ACT_BARRIER_DOWN` | — | **ST_LED_OFF** | `EV_LED_OFF` |