# FIUBA - Electrónica - Taller de Sistemas Embebidos
## Trabajo Práctico N°: 1 - Diagramas de Estado - Modelado
### Archivo: tdse-tp1_00-actuator.md

---

## 1. Descripción de Eventos y Acciones del Modelo Actuator (Paso 10)

El modelo del actuador gestiona el dispositivo de salida físico del sistema, simplificado y representado mediante un **único LED** que simula el estado de la barrera de acceso (*Barrier Gate*), bajo un esquema temporizado no bloqueante (*Update by Time Code*, $\text{period} = 1\text{ ms}$).

* **Estados del Modelo (`ST_BARRIER_NAME`):**
  - `ST_BARRIER_CLOSED`: La barrera se encuentra abajo (LED apagado). Estado de reposo y restricción de paso.
  - `ST_BARRIER_OPEN`: La barrera se encuentra arriba (LED encendido fijo). Estado de paso habilitado para el vehículo.

* **Eventos de Entrada / Disparadores (Triggers):**
  - `EV_ACT_OPEN_BARRIER`: Orden recibida desde el módulo `System` para abrir la barrera.
  - `EV_ACT_CLOSE_BARRIER`: Orden recibida desde el módulo `System` para cerrar la barrera.

* **Acciones y Efectos en Hardware (GPIO):**
  - `EV_LED_ON`: Enciende el LED de la barrera (`GPIO_PIN_SET`).
  - `EV_LED_OFF`: Apaga el LED de la barrera (`GPIO_PIN_RESET`).

---

## 2. Tabla de Transición de Estados del Actuador (Paso 11)

El modelo implementa la conmutación directa del LED indicador de barrera:

`ST_BARRIER_CLOSED` <-> `ST_BARRIER_OPEN`

| Current State | Event (Trigger) | [Guard] (Condición) | Next State | Actions / Effects (Excitaciones) |
| :--- | :--- | :--- | :--- | :--- |
| **ST_BARRIER_CLOSED** | `EV_ACT_OPEN_BARRIER` | — | **ST_BARRIER_OPEN** | `EV_LED_ON` |
| **ST_BARRIER_OPEN** | `EV_ACT_CLOSE_BARRIER` | — | **ST_BARRIER_CLOSED** | `EV_LED_OFF` |