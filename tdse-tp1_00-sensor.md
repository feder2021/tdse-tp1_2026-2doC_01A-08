# FIUBA - Electrónica - Taller de Sistemas Embebidos
## Trabajo Práctico N° 1 - Diagramas de Estado - Modelado
### Archivo: `tdse-tp1_00-sensor.md`

---

## 1. Descripción de Eventos y Acciones del Modelo Sensor (Paso 06)

El modelo `Sensor` tiene como objetivo **escrutar** periódicamente el estado de un único botón binario utilizado como entrada digital del sistema, bajo un esquema temporizado no bloqueante (*Update by Time Code*, $\text{period} = 1\text{ ms}$) para realizar el filtrado de rebotes mecánicos (*debouncing*).

El botón es un sensor binario que puede presentar dos posiciones o eventos de entrada físicos:
* **`EV_BTN_PRESSED`:** Indica que el pin físico cambió a posición activa/baja (presionado).
* **`EV_BTN_RELEASED`:** Indica que el pin físico cambió a posición inactiva/alta (liberado).

Estos eventos actúan como **triggers (Eventos)** del modelo `Sensor`.

Por lo tanto, el estado de la entrada se comprueba periódicamente cada 1 ms sin utilizar código bloqueante mediante el evento de reloj `Tick` (`EV_TICK`).

---

## 2. Acciones del Modelo Sensor y Señales hacia el Sistema

Cuando el modelo determina que ocurrió un cambio válido y estable en la posición del botón tras filtrar las perturbaciones mecánicas, genera una acción o señal (*signal*) dirigida hacia el modelo `System` (`EV_SYS_NAME`):

* **`EV_SYS_BTN_DOWN`:** Señal limpia generada hacia el módulo de procesamiento (*System Statechart*) al confirmar una pulsación estable (**Not Pressed $\rightarrow$ Pressed**).
* **`EV_SYS_BTN_UP`:** Señal limpia generada hacia el módulo de procesamiento al confirmar una liberación estable (**Pressed $\rightarrow$ Not Pressed**).

De esta manera, el módulo `Sensor` se encarga de detectar y validar el cambio físico del botón, mientras que el módulo `System` recibe el evento limpio correspondiente para procesarlo.

---

## 3. Rebote del Pulsador y Temporización para Debouncing

Un pulsador mecánico no produce necesariamente una transición instantánea entre los estados abierto y cerrado. Al presionarlo o liberarlo, sus contactos pueden generar múltiples cambios rápidos entre los niveles lógicos antes de alcanzar un valor estable. Este fenómeno se conoce como **rebote del pulsador (*switch bounce*)**.

Si cada cambio fuese considerado como un evento válido, una única pulsación podría interpretarse erróneamente como varias pulsaciones seguidas. Por este motivo es necesario implementar un mecanismo de **debouncing**.

Para eliminar los efectos del rebote se utiliza una variable de temporización decreciente:
`tick`

La variable `tick` opera en milisegundos y se carga con el valor:
`DEL_BTN_DEBOUNCE` (ej. 50 ms)

El contador `tick` se decrementa cada **1 ms** (`tick--`) mediante la ejecución periódica del sistema (*Update by Time Code*, $T = 1\text{ ms}$).

Cuando se detecta una posible modificación en la posición del botón, se inicializa `tick = DEL_BTN_DEBOUNCE`. La nueva posición solamente se considera válida cuando permanece estable durante todo el intervalo transcurrido hasta que el temporizador llega a cero (`[tick == 0]`).

De esta manera, `tick` se utiliza como **guard** para condicionar las transiciones bajo la estructura general:
`trigger [guard] / effect`

* **Confirmación de pulsación:**  
  `Tick [tick == 0] / EV_SYS_BTN_DOWN`
* **Confirmación de liberación:**  
  `Tick [tick == 0] / EV_SYS_BTN_UP`

---

## 4. Resumen de Eventos, Estados y Acciones

| Tipo | Identificador | Descripción / Definición |
| :--- | :--- | :--- |
| **Estado Modelo** | `ST_BTN_UP` | Botón liberado en reposo (nivel alto estable). |
| **Estado Modelo** | `ST_BTN_FALLING` | Transitorio de validación tras presionado inicial (flanco bajada). |
| **Estado Modelo** | `ST_BTN_DOWN` | Botón presionado y confirmado estable (nivel bajo). |
| **Estado Modelo** | `ST_BTN_RISING` | Transitorio de validación tras liberación inicial (flanco subida). |
| **Evento Sensor** | `EV_BTN_PRESSED` | Disparador físico: pin cambia a estado activo/bajo. |
| **Evento Sensor** | `EV_BTN_RELEASED` | Disparador físico: pin cambia a estado inactivo/alto. |
| **Evento Reloj** | `Tick` *(1 ms)* | Disparador periódico no bloqueante para decrementar `tick`. |
| **Acción / Signal**| `EV_SYS_BTN_DOWN` | Informa al `System` que se confirmó una pulsación limpia. |
| **Acción / Signal**| `EV_SYS_BTN_UP` | Informa al `System` que se confirmó una liberación limpia. |
| **Timer** | `tick` | Contador decreciente (en ms) utilizado para el debouncing. |
| **Delay** | `DEL_BTN_DEBOUNCE`| Tiempo requerido para validar una posición estable (50 ms). |

---

## 5. Tabla de Transición de Estados del Sensor (Paso 07)

El modelo implementa el ciclo completo de filtrado del botón:

$$\text{ST\_BTN\_UP} \longrightarrow \text{ST\_BTN\_FALLING} \longrightarrow \text{ST\_BTN\_DOWN} \longrightarrow \text{ST\_BTN\_RISING} \longrightarrow \text{ST\_BTN\_UP}$$

Las transiciones transitorias evalúan el contador decreciente `tick--` en cada evento periódico de 1 ms (`Tick`) y descartan cualquier ruido mecánico (*glitch*) si la señal física conmuta antes de expirar el tiempo de validación.

| Current State | Event (Trigger) | [Guard] (Condición) | Next State | Actions / Effects (Excitaciones) |
| :--- | :--- | :--- | :--- | :--- |
| **ST_BTN_UP** | `EV_BTN_PRESSED` | — | **ST_BTN_FALLING** | `tick = DEL_BTN_DEBOUNCE` |
| **ST_BTN_FALLING** | `EV_BTN_RELEASED` | — | **ST_BTN_UP** | *(Descartar rebote / Glitch)* |
| **ST_BTN_FALLING** | `Tick` *(1 ms)* | `[tick > 0]` | **ST_BTN_FALLING** | `tick--` |
| **ST_BTN_FALLING** | `Tick` *(1 ms)* | `[tick == 0]` *(Timeout)* | **ST_BTN_DOWN** | `EV_SYS_BTN_DOWN` |
| **ST_BTN_DOWN** | `EV_BTN_RELEASED` | — | **ST_BTN_RISING** | `tick = DEL_BTN_DEBOUNCE` |
| **ST_BTN_RISING** | `EV_BTN_PRESSED` | — | **ST_BTN_DOWN** | *(Descartar rebote / Glitch)*|
| **ST_BTN_RISING** | `Tick` *(1 ms)* | `[tick > 0]` | **ST_BTN_RISING** | `tick--` |
| **ST_BTN_RISING** | `Tick` *(1 ms)* | `[tick == 0]` *(Timeout)* | **ST_BTN_UP** | `EV_SYS_BTN_UP`|