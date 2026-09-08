# FIUBA - Electrónica - Taller de Sistemas Embebidos
## Trabajo Práctico N°: 1 - Diagramas de Estado - Modelado
### Archivo: tdse-tp1_00-actuator.md

---

## 1. Descripción de Eventos y Acciones del Modelo Actuator (Paso 10)

El modelo del actuador gestiona los dispositivos de salida del sistema (representados mediante LEDs indicadores de estado) bajo un esquema temporizado no bloqueante (*Update by Time Code*, $\text{period} = 1\text{ ms}$). Su función es traducir las órdenes emitidas por el módulo de procesamiento (*System Statechart*) en respuestas físicas visibles.

* **Estados del Modelo (`ST_LED_NAME`):**
  - `ST_LED_OFF`: Estado en el cual el actuador/LED se encuentra apagado (nivel bajo), indicando barrera cerrada o reposo.
  - `ST_LED_ON`: Estado en el cual el actuador/LED se encuentra encendido de forma fija (nivel alto), indicando barrera abierta.
  - `ST_LED_BLINKING`: Estado transitorio o compuesto donde el actuador/LED titila de manera intermitente, indicando proceso activo (por ejemplo, impresión de ticket).

* **Eventos de Entrada / Disparadores (`EV_ACT_`):**
  - `EV_ACT_PRINT_START`: Señal recibida desde el sistema principal para iniciar la impresión, activando el modo intermitente (*blinking*).
  - `EV_ACT_BARRIER_UP`: Señal recibida para abrir la barrera, encendiendo el indicador de forma fija.
  - `EV_ACT_BARRIER_DOWN`: Señal recibida para cerrar la barrera, apagando el indicador.
  - `Tick` / `Timeout`: Disparadores periódicos de 1 ms para controlar los intervalos de conmutación del parpadeo.

* **Acciones y Efectos:**
  - Modificación de salidas digitales mediante funciones de bajo nivel (ej. `HAL_GPIO_WritePin`).
  - Inicialización, decremento o recarga de variables de control de tiempo (`tick`).

* **Variables de Control y Temporización:**
  - `tick`: Variable contador decrementable que opera en milisegundos.
  - `DEL_BLINK_PERIOD`: Constante de tiempo de retardo para definir el periodo de parpadeo.

---

## 2. Tabla de Transición de Estados del Actuador (Paso 11)

| Current State | Event (Trigger) | [Guard] (Condición) | Next State | Actions / Effects (Excitaciones) |
| :--- | :--- | :--- | :--- | :--- |
| **ST_LED_OFF** | `EV_ACT_BARRIER_UP` | | **ST_LED_ON** | Encender LED (`GPIO_PIN_SET`) |
| **ST_LED_OFF** | `EV_ACT_PRINT_START` | | **ST_LED_BLINKING** | `tick = DEL_BLINK_PERIOD` |
| **ST_LED_ON** | `EV_ACT_BARRIER_DOWN` | | **ST_LED_OFF** | Apagar LED (`GPIO_PIN_RESET`) |
| **ST_LED_ON** | `EV_ACT_PRINT_START` | | **ST_LED_BLINKING** | `tick = DEL_BLINK_PERIOD` |
| **ST_LED_BLINKING** | `Tick` *(1 ms)* | `[tick > 0]` | **ST_LED_BLINKING** | `tick--` |
| **ST_LED_BLINKING** | `Tick` *(1 ms)* | `[tick == 0]` *(Timeout)* | **ST_LED_BLINKING** | Invertir estado del LED, recargar `tick = DEL_BLINK_PERIOD` |
| **ST_LED_BLINKING** | `EV_ACT_BARRIER_DOWN` | | **ST_LED_OFF** | Apagar LED (`GPIO_PIN_RESET`) |
| **ST_LED_BLINKING** | `EV_ACT_BARRIER_UP` | | **ST_LED_ON** | Encender LED (`GPIO_PIN_SET`) |