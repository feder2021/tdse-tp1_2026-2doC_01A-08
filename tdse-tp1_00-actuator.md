# FIUBA - Electrónica - Taller de Sistemas Embebidos
## Trabajo Práctico N°: 1 - Diagramas de Estado - Modelado
### Archivo: tdse-tp1_00-actuator.md

---

## 1. Descripción de Eventos y Acciones del Modelo Actuator (Paso 10)

El modelo del actuador gestiona un único dispositivo de salida (un LED) bajo un esquema temporizado no bloqueante (*Update by Time Code*, $\text{period} = 1\text{ ms}$) para realizar la tarea de "actuar". Un LED es un dispositivo semiconductor que emite luz al aplicársele una corriente eléctrica, y su comportamiento puede variar entre encendido, apagado, titilando (*blinking*), pulsos simples o múltiples (N pulsos), haciendo necesario el uso de un temporizador (`tick`).

* **Estados del Modelo (`ST_LED_NAME`):**
  - `ST_LED_OFF`: Estado en el cual el LED se encuentra apagado (nivel bajo).
  - `ST_LED_ON`: Estado en el cual el LED se encuentra encendido de forma fija (nivel alto).
  - `ST_LED_BLINKING`: Estado transitorio o compuesto donde el LED titila de manera intermitente utilizando temporizadores.

* **Eventos de Entrada / Disparadores (`EV_ACT_`):**
  - `EV_ACT_TURN_ON`: Señal recibida desde el sistema principal para encender el LED de forma fija.
  - `EV_ACT_TURN_OFF`: Señal recibida para apagar el LED.
  - `EV_ACT_BLINK`: Señal recibida para activar el modo intermitente (*blinking*).
  - `Tick` / `Timeout`: Disparadores periódicos de 1 ms para controlar los intervalos de conmutación.

* **Acciones y Efectos:**
  - Modificación de salidas digitales mediante funciones de bajo nivel (ej. `HAL_GPIO_WritePin`).
  
* **Variables de Control y Temporización:**
  - `tick`: Variable contador decrementable que opera en milisegundos.
  - `DEL_BLINK_PERIOD`: Constante de tiempo de retardo para definir el periodo de parpadeo.

---

## 2. Tabla de Transición de Estados del Actuador (Paso 11)

| Current State | Event (Trigger) | [Guard] (Condición) | Next State | Actions / Effects (Excitaciones) |
| :--- | :--- | :--- | :--- | :--- |
| **ST_LED_OFF** | `EV_ACT_TURN_ON` | | **ST_LED_ON** | Encender LED (`GPIO_PIN_SET`) |
| **ST_LED_OFF** | `EV_ACT_BLINK` | | **ST_LED_BLINKING** | `tick = DEL_BLINK_PERIOD` |
| **ST_LED_ON** | `EV_ACT_TURN_OFF` | | **ST_LED_OFF** | Apagar LED (`GPIO_PIN_RESET`) |
| **ST_LED_ON** | `EV_ACT_BLINK` | | **ST_LED_BLINKING** | `tick = DEL_BLINK_PERIOD` |
| **ST_LED_BLINKING** | `Tick` *(1 ms)* | `[tick > 0]` | **ST_LED_BLINKING** | `tick--` |
| **ST_LED_BLINKING** | `Tick` *(1 ms)* | `[tick == 0]` *(Timeout)* | **ST_LED_BLINKING** | Invertir estado del LED, recargar `tick = DEL_BLINK_PERIOD` |
| **ST_LED_BLINKING** | `EV_ACT_TURN_OFF` | | **ST_LED_OFF** | Apagar LED (`GPIO_PIN_RESET`) |
| **ST_LED_BLINKING** | `EV_ACT_TURN_ON` | | **ST_LED_ON** | Encender LED (`GPIO_PIN_SET`) |