# FIUBA - Electrónica - Taller de Sistemas Embebidos
## Trabajo Práctico N°: 1 - Diagramas de Estado - Modelado
### Archivo: tdse-tp1_00-system.md

---

## 1. Descripción de Eventos y Acciones del Modelo System (Paso 08)

El modelo del sistema gestiona la lógica central de procesamiento (*Process*) bajo un esquema temporizado no bloqueante (*Update by Time Code*, $\text{period} = 1\text{ ms}$).

* **Estados del Modelo (`ST_SYS_NAME`):**
  - `ST_SYS_IDLE`: Estado de reposo sin vehículos detectados.
  - `ST_SYS_WAIT_FOR_BTN`: Estado alcanzado tras la primera pulsación (vehículo detectado). El sistema aguarda la segunda pulsación para imprimir el ticket o retorna a reposo si expira el temporizador de inactividad.
  - `ST_SYS_TICKET_PROCESSING`: Estado donde se procesa la solicitud y se manda a imprimir el ticket.
  - `ST_SYS_BARRIER_OPEN`: Estado donde se emite la orden de apertura de la barrera y se inicia el temporizador de paso.

* **Eventos de Entrada / Disparadores (Triggers):**
  - `EV_SYS_BTN_DOWN`: Señal limpia recibida desde el módulo `Sensor` tras la presión estable del botón físico.
  - `Tick` / `Timeout`: Disparadores periódicos de 1 ms para controlar los temporizadores de inactividad, procesamiento y cierre de la barrera.

* **Acciones y Señales hacia los Actuadores:**
  - `EV_ACT_WELCOME`: Señal para activar el patrón de parpadeo lento (vehículo presente).
  - `EV_ACT_PRINT_START`: Señal para activar el patrón de parpadeo rápido (impresión activa).
  - `EV_ACT_BARRIER_UP`: Señal para encender de forma fija el indicador de paso (barrera arriba).
  - `EV_ACT_BARRIER_DOWN`: Señal enviada al cerrar la barrera o cancelar por inactividad.

* **Variables de Control y Temporización:**
  - `tick`: Variable contador decrementable que opera en milisegundos.
  - `DEL_SYS_TIMEOUT`: Constante de tiempo de espera máxima en la terminal (ej. 10000 ms).
  - `DEL_BARRIER_TIMEOUT`: Constante de tiempo para mantener la barrera abierta (ej. 3000 ms).

---

## 2. Tabla de Transición de Estados del Sistema (Paso 09)

`ST_SYS_IDLE` -> `ST_SYS_WAIT_FOR_BTN` -> `ST_SYS_TICKET_PROCESSING` -> `ST_SYS_BARRIER_OPEN` -> `ST_SYS_IDLE`  
*(Escape por inactividad: `ST_SYS_WAIT_FOR_BTN` -> `ST_SYS_IDLE`)*

| Current State | Event (Trigger) | [Guard] (Condición) | Next State | Actions / Effects (Excitaciones) |
| :--- | :--- | :--- | :--- | :--- |
| **ST_SYS_IDLE** | `EV_SYS_BTN_DOWN` | — | **ST_SYS_WAIT_FOR_BTN** | `EV_ACT_WELCOME, tick = DEL_SYS_TIMEOUT` |
| **ST_SYS_WAIT_FOR_BTN** | `Tick` *(1 ms)* | `[tick > 0]` | **ST_SYS_WAIT_FOR_BTN** | `tick--` |
| **ST_SYS_WAIT_FOR_BTN** | `Tick` *(1 ms)* | `[tick == 0]` | **ST_SYS_IDLE** | `EV_ACT_BARRIER_DOWN` *(Inactividad / Auto se fue)* |
| **ST_SYS_WAIT_FOR_BTN** | `EV_SYS_BTN_DOWN` | `[tick > 0]` | **ST_SYS_TICKET_PROCESSING** | `EV_ACT_PRINT_START` |
| **ST_SYS_TICKET_PROCESSING** | `Tick` *(1 ms)* | — | **ST_SYS_BARRIER_OPEN** | `EV_ACT_BARRIER_UP, tick = DEL_BARRIER_TIMEOUT` |
| **ST_SYS_BARRIER_OPEN** | `Tick` *(1 ms)* | `[tick > 0]` | **ST_SYS_BARRIER_OPEN** | `tick--` |
| **ST_SYS_BARRIER_OPEN** | `Tick` *(1 ms)* | `[tick == 0]` | **ST_SYS_IDLE** | `EV_ACT_BARRIER_DOWN` |