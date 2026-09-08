# FIUBA - Electrónica - Taller de Sistemas Embebidos
## Trabajo Práctico N°: 1 - Diagramas de Estado - Modelado
### Archivo: tdse-tp1_00-sensor.md

---

## 1. Descripción de Eventos y Acciones del Modelo Sensor (Paso 06)

El modelo del sensor gestiona un único botón binario bajo un esquema temporizado no bloqueante (*Update by Time Code*, $\text{period} = 1\text{ ms}$) para realizar la tarea de escrutinio y filtrado de rebotes mecánicos (*debouncing*).

* **Estados del Modelo (`ST_BTN_NAME`):**
  - `ST_BTN_UP`: Estado de reposo donde el botón se encuentra liberado (nivel alto lógico).
  - `ST_BTN_FALLING`: Estado transitorio de validación tras detectar un flanco de bajada (presionado inicial).
  - `ST_BTN_DOWN`: Estado estable donde el botón se encuentra presionado (nivel bajo lógico confirmado).
  - `ST_BTN_RISING`: Estado transitorio de validación tras detectar un flanco de subida (liberación inicial).

* **Eventos de Entrada (`EV_BTN_NAME`):**
  - `EV_BTN_PRESSED`: Evento disparado cuando el pin físico cambia a estado activo/bajo (presionado).
  - `EV_BTN_RELEASED`: Evento disparado cuando el pin físico cambia a estado inactivo/alto (liberado).
  - `Tick` / `Timeout`: Disparadores periódicos de 1 ms para controlar los intervalos de estabilización.

* **Señales hacia el Sistema (`EV_SYS_NAME`):**
  - `EV_SYS_BTN_DOWN`: Señal limpia generada hacia el módulo de procesamiento (*System Statechart*) al confirmar una pulsación estable.
  - `EV_SYS_BTN_UP`: Señal limpia generada hacia el módulo de procesamiento al confirmar una liberación estable.

* **Variables de Control y Temporización:**
  - `tick`: Variable contador decrementable que opera en milisegundos.
  - `DEL_BTN_DEBOUNCE`: Constante de tiempo de retardo para la estabilización (ej. entre 20 ms y 50 ms).

---

## 2. Tabla de Transición de Estados del Sensor (Paso 07)

| Current State | Event (Trigger) | [Guard] (Condición) | Next State | Actions / Effects (Excitaciones) |
| :--- | :--- | :--- | :--- | :--- |
| **ST_BTN_UP** | `EV_BTN_PRESSED` | | **ST_BTN_FALLING** | `tick = DEL_BTN_DEBOUNCE` |
| **ST_BTN_FALLING** | `EV_BTN_RELEASED` | | **ST_BTN_UP** | *(Descartar rebote / Glitch)* |
| **ST_BTN_FALLING** | `Tick` *(1 ms)* | `[tick > 0]` | **ST_BTN_FALLING** | `tick--` |
| **ST_BTN_FALLING** | `Tick` *(1 ms)* | `[tick == 0]` *(Timeout)* | **ST_BTN_DOWN** | `EV_SYS_BTN_DOWN` |
| **ST_BTN_DOWN** | `EV_BTN_RELEASED` | | **ST_BTN_RISING** | `tick = DEL_BTN_DEBOUNCE` |
| **ST_BTN_RISING** | `EV_BTN_PRESSED` | | **ST_BTN_DOWN** | *(Descartar rebote / Glitch)* |
| **ST_BTN_RISING** | `Tick` *(1 ms)* | `[tick > 0]` | **ST_BTN_RISING** | `tick--` |
| **ST_BTN_RISING** | `Tick` *(1 ms)* | `[tick == 0]` *(Timeout)* | **ST_BTN_UP** | `EV_SYS_BTN_UP` |