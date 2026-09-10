# FIUBA - Electrónica - Taller de Sistemas Embebidos
## Trabajo Práctico N°: 1 - Diagramas de Estado - Modelado
### Archivo: tdse-tp1_00-system.md

---

## 1. Descripción de Eventos y Acciones del Modelo System (Paso 08)

El modelo del sistema gestiona la lógica central de procesamiento (*Process*) bajo un esquema temporizado no bloqueante (*Update by Time Code*, $\text{period} = 1\text{ ms}$). Su función principal es recibir las señales limpias de los sensores de entrada (Cámara, Botón y Lazo Magnético), evaluar la secuencia del vehículo en la terminal de entrada (*Entry Terminal*) y ordenar las acciones al actuador de la barrera.

En este modelo simplificado, se asume la permanencia del vehículo una vez detectado por la cámara, omitiendo cualquier evento de desdetección o abandono previo a la pulsación del botón.

* **Estados del Modelo (`ST_SYS_NAME`):**
  - `ST_SYS_IDLE`: Estado de reposo sin vehículos detectados en la terminal.
  - `ST_SYS_WAIT_FOR_BTN`: Un vehículo ha sido detectado por la cámara (llave ON). El sistema aguarda a que el usuario presione el botón de solicitud.
  - `ST_SYS_BARRIER_OPEN`: El usuario presionó el botón. Se emite la orden de abrir la barrera (encender LED) y se aguarda la confirmación del paso del vehículo a través del lazo magnético.

* **Eventos de Entrada / Disparadores (Triggers):**
  - `EV_SYS_CAMERA_ON`: Señal recibida al activar la llave de la cámara (detección de presencia de vehículo).
  - `EV_SYS_BTN_DOWN`: Señal limpia recibida desde el sensor del botón tras una pulsación estable.
  - `EV_SYS_COIL_OFF`: Señal recibida al desactivar la llave del lazo magnético (el auto terminó de pasar completamente).
  - `Tick` / `Timeout`: Disparadores periódicos de 1 ms.

* **Acciones y Señales hacia el Actuador (`Barrier`):**
  - `EV_ACT_OPEN_BARRIER`: Señal enviada al actuador para levantar la barrera (encender LED).
  - `EV_ACT_CLOSE_BARRIER`: Señal enviada al actuador para bajar la barrera (apagar LED).

---

## 2. Tabla de Transición de Estados del Sistema (Paso 09)

Secuencia principal estricta: `ST_SYS_IDLE` -> `ST_SYS_WAIT_FOR_BTN` -> `ST_SYS_BARRIER_OPEN` -> `ST_SYS_IDLE`

| Current State | Event (Trigger) | [Guard] (Condición) | Next State | Actions / Effects (Excitaciones) |
| :--- | :--- | :--- | :--- | :--- |
| **ST_SYS_IDLE** | `EV_SYS_CAMERA_ON` | — | **ST_SYS_WAIT_FOR_BTN** | *(Vehículo detectado en entrada)* |
| **ST_SYS_WAIT_FOR_BTN** | `EV_SYS_BTN_DOWN` | — | **ST_SYS_BARRIER_OPEN** | `EV_ACT_OPEN_BARRIER` |
| **ST_SYS_BARRIER_OPEN** | `EV_SYS_COIL_OFF` | — | **ST_SYS_IDLE** | `EV_ACT_CLOSE_BARRIER` |