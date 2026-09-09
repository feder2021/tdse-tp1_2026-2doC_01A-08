# FIUBA - Electrónica - Taller de Sistemas Embebidos
## Trabajo Práctico N°: 1 - Diagramas de Estado - Modelado
### Archivo: tdse-tp1_00-system.md

---

## 1. Descripción de Eventos y Acciones del Modelo System (Paso 08)

El modelo del sistema gestiona la lógica central de procesamiento (*Process*) bajo un esquema temporizado no bloqueante (*Update by Time Code*, $\text{period} = 1\text{ ms}$). Su función principal es recibir la señal limpia enviada por el módulo de sensores (`EV_SYS_BTN_DOWN`), evaluar el estado actual de la terminal de estacionamiento y disparar las señales hacia los actuadores.

Dado que la placa física cuenta con un solo pulsador de usuario (`B1`), la presencia de un vehículo en reposo se simula mediante la **primera pulsación** del botón.

* **Estados del Modelo (`ST_SYS_NAME`):**
  - `ST_SYS_IDLE`: Estado de reposo sin vehículos detectados.
  - `ST_SYS_WAIT_FOR_BTN`: Estado alcanzado tras la primera pulsación (vehículo detectado). El sistema aguarda la segunda pulsación para imprimir el ticket.
  - `ST_SYS_TICKET_PROCESSING`: Estado donde se procesa la solicitud y se manda a imprimir el ticket.
  - `ST_SYS_BARRIER_OPEN`: Estado donde se emite la orden de apertura de la barrera y se inicia el temporizador de seguridad.

* **Eventos de Entrada / Disparadores (Triggers):**
  - `EV_SYS_BTN_DOWN`: Señal limpia recibida desde el módulo `Sensor` tras la presión estable del botón físico.
  - `Tick` / `Timeout`: Disparadores periódicos de 1 ms para controlar el procesamiento y el tiempo de apertura de la barrera.

* **Acciones y Señales hacia los Actuadores:**
  - `EV_ACT_WELCOME`: Señal enviada al actuador para activar el patrón de parpadeo lento (bienvenida/vehículo presente).
  - `EV_ACT_PRINT_START`: Señal enviada al actuador para activar el patrón de parpadeo rápido (impresión activa).
  - `EV_ACT_BARRIER_UP`: Señal enviada para encender de forma fija el indicador de paso (barrera arriba).
  - `EV_ACT_BARRIER_DOWN`: Señal enviada para apagar los indicadores al cerrar la barrera transcurrido el tiempo.

* **Variables de Control y Temporización:**
  - `tick`: Variable contador decrementable que opera en milisegundos.
  - `DEL_BARRIER_TIMEOUT`: Constante de tiempo de retardo para mantener la barrera abierta (ej. 3000 ms).

---

## 2. Tabla de Transición de Estados del Sistema (Paso 09)

El modelo implementa la secuencia operacional reutilizando la pulsación del botón:

`ST_SYS_IDLE` -> `ST_SYS_WAIT_FOR_BTN` -> `ST_SYS_TICKET_PROCESSING` -> `ST_SYS_BARRIER_OPEN` -> `ST_SYS_IDLE`

| Current State | Event (Trigger) | [Guard] (Condición) | Next State | Actions / Effects (Excitaciones) |
| :--- | :--- | :--- | :--- | :--- |
| **ST_SYS_IDLE** | `EV_SYS_BTN_DOWN` | — | **ST_SYS_WAIT_FOR_BTN** | `EV_ACT_WELCOME` *(Simula llegada del vehículo)* |
| **ST_SYS_WAIT_FOR_BTN** | `EV_SYS_BTN_DOWN` | — | **ST_SYS_TICKET_PROCESSING** | `EV_ACT_PRINT_START` *(Solicita ticket)* |
| **ST_SYS_TICKET_PROCESSING** | `Tick` *(1 ms)* | — | **ST_SYS_BARRIER_OPEN** | `EV_ACT_BARRIER_UP, tick = DEL_BARRIER_TIMEOUT` |
| **ST_SYS_BARRIER_OPEN** | `Tick` *(1 ms)* | `[tick > 0]` | **ST_SYS_BARRIER_OPEN** | `tick--` |
| **ST_SYS_BARRIER_OPEN** | `Tick` *(1 ms)* | `[tick == 0]` | **ST_SYS_IDLE** | `EV_ACT_BARRIER_DOWN` |