# FIUBA - Electrónica - Taller de Sistemas Embebidos
## Trabajo Práctico N°: 1 - Diagramas de Estado - Modelado
### Archivo: tdse-tp1_00-system.md

---

## 1. Descripción de Eventos y Acciones del Modelo System (Paso 08)

El modelo del sistema gestiona la lógica central de procesamiento (*Process*) bajo un esquema temporizado no bloqueante (*Update by Time Code*, $\text{period} = 1\text{ ms}$). Su función principal es recibir las señales limpias provenientes del módulo de sensores, evaluar el estado actual de la máquina de tickets (*Parking Ticket Dispenser Machine*) y disparar las acciones o señales correspondientes hacia los actuadores.

* **Estados del Modelo (`ST_SYS_NAME`):**
  - `ST_SYS_IDLE`: Estado de reposo o espera, el sistema aguarda la llegada de un vehículo a la terminal.
  - `ST_SYS_WAIT_FOR_BUTTON`: Estado donde hay un vehículo detectado en la entrada y el sistema aguarda a que el usuario presione el botón de tickets.
  - `ST_SYS_TICKET_PROCESSING`: Estado donde se procesa la solicitud, se ordena la impresión del ticket y se activa el registro en el servidor.
  - `ST_SYS_BARRIER_OPEN`: Estado donde se emite la orden de apertura de la barrera de acceso y se inicia un temporizador de seguridad.

* **Eventos de Entrada / Disparadores (Triggers):**
  - `EV_SYS_CAR_DETECTED`: Señal de presencia vehicular proveniente del lazo magnético o cámara de entrada.
  - `EV_SYS_BTN_DOWN`: Señal limpia recibida desde el sensor que indica que el usuario presionó el botón de tickets de forma estable.
  - `Tick` / `Timeout`: Disparadores periódicos de $1\text{ ms}$ para controlar el procesamiento y tiempo de apertura de la barrera[cite: 1, 2].

* **Acciones y Señales hacia los Actuadores:**
  - `EV_ACT_WELCOME`: Señal enviada al display para habilitar el mensaje de bienvenida / presencia de vehículo.
  - `EV_ACT_PRINT_START`: Señal enviada al módulo de la impresora (*Printer*) para generar el ticket.
  - `EV_ACT_BARRIER_UP`: Señal enviada al actuador de la barrera (*Barrier*) para levantar el brazo de acceso.
  - `EV_ACT_BARRIER_DOWN`: Señal enviada para cerrar la barrera transcurrido el tiempo de paso.

---

## 2. Tabla de Transición de Estados del Sistema (Paso 09)

| Current State | Event (Trigger) | [Guard] (Condición) | Next State | Actions / Effects (Excitaciones) |
| :--- | :--- | :--- | :--- | :--- |
| **ST_SYS_IDLE** | `EV_SYS_CAR_DETECTED` | | **ST_SYS_WAIT_FOR_BUTTON** | `EV_ACT_WELCOME` |
| **ST_SYS_WAIT_FOR_BUTTON** | `EV_SYS_BTN_DOWN` | | **ST_SYS_TICKET_PROCESSING** | `EV_ACT_PRINT_START`, Registrar en servidor |
| **ST_SYS_TICKET_PROCESSING** | `Tick` *(1 ms)* | | **ST_SYS_BARRIER_OPEN** | `EV_ACT_BARRIER_UP`, `tick = DEL_BARRIER_TIMEOUT` |
| **ST_SYS_BARRIER_OPEN** | `Tick` *(1 ms)* | `[tick > 0]` | **ST_SYS_BARRIER_OPEN** | `tick = tick --` |
| **ST_SYS_BARRIER_OPEN** | `Tick` *(1 ms)* | `[tick == 0]` *(Timeout)* | **ST_SYS_IDLE** | `EV_ACT_BARRIER_DOWN` |