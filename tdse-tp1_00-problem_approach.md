# # FIUBA - Electrónica - Taller de Sistemas Embebidos
## Trabajo Práctico N°: 1 - Diagramas de Estado - Modelado
### Archivo: tdse-tp1_00-problem_approach.md

---

## 1. Descripción de la solución Intelligent Parking Management System (COMA Electronics)
La arquitectura de referencia provista por COMA Electronics plantea un sistema automatizado e inteligente para la gestión integral de playas de estacionamiento (Automated Parking System). El sistema resuelve de manera eficiente el flujo vehicular dividiéndolo en dos grandes puntos críticos:
- **Área de Entrada (Entry):** Gestionada por la máquina dispensadora de tickets (*Parking Ticket Dispenser Machine - PTDM*), la cual detecta la llegada del vehículo, valida las condiciones, interactúa con el usuario mediante displays e intercomunicadores, imprime un ticket con número de serie, fecha y hora, y finalmente emite una señal de apertura hacia la barrera de alta velocidad.
- **Área de Pago Centralizado (Central Payment Point) y Salida (Exit):** Donde el usuario valida y abona su estadía en terminales automáticas antes de retornar a su vehículo, permitiendo un acceso rápido y validado en la terminal de egreso bajo un tiempo de gracia preestablecido.

---

## 2. Descripción de la implementación: Parking Ticket Dispenser Machine (Entry)
Para el desarrollo del Producto Mínimo Viable (MVP) en el marco de la asignatura, la implementación se centra exclusivamente en modelar y replicar el comportamiento de la **Parking Ticket Dispenser Machine (Entry)**. 
El sistema se desglosa y organiza de forma modular mediante una estructura de tres capas de comportamiento ("escrutar, procesar, actuar") sincronizada a través de un esquema temporizado no bloqueante (*Update by Time Code*) de ejecución cíclica cada 1 milisegundo ($1\text{ mS}$):
1. **Módulo de Sensores (Scrutinize / Entradas Digitales):** Se encarga de capturar y filtrar las señales del mundo físico (como la presencia del vehículo mediante lazo magnético/cámara, el botón de tickets y el estado de la barrera). En el prototipo de laboratorio, los sensores físicos se reemplazan por pulsadores e interruptores del tipo *Dip Switch*.
2. **Módulo del Sistema (Process / Interfaz Lógica):** Recibe los mensajes procesados desde los sensores, evalúa las máquinas de estados (FSM) correspondientes y toma decisiones lógicas sobre qué acción disparar a continuación.
3. **Módulo de Actuadores (Act / Salidas Digitales):** Ejecuta las órdenes enviadas por el sistema (displays, impresora de tickets, comunicación con el servidor central y control del motor/apertura de la barrera). En el prototipo, los actuadores reales se reemplazan mediante el uso de LEDs indicadores.

---

## 3. Enunciado de los modelos para el comportamiento en código C (Temporizado, T = 1mS)
Para gestionar de forma robusta y no bloqueante la lógica del sistema bajo una ejecución cíclica de $1\text{ mS}$, se definen tres modelos principales basados en máquinas de estados de Harel/UML implementados mediante lenguajes estructurados:

- **Modelo Sensor (`Sensor Statechart`):** 
  Modela el comportamiento de escrutinio de un dispositivo de entrada binario (un pulsador o interruptor). Su función principal es aplicar un algoritmo anti-rebote (*debouncing*) utilizando un temporizador decreciente (`tick--`) para filtrar transitorios y ruidos mecánicos de los contactos físicos, generando eventos limpios y estables hacia el sistema principal (`EV_SYS_...`).
- **Modelo Sistema (`System Statechart`):** 
  Modela el núcleo lógico de procesamiento de la máquina de entrada. Recibe los eventos validados de los sensores (por ejemplo, la pulsación limpia del botón de tickets), evalúa las condiciones de ocupación o disponibilidad del sistema, y emite las órdenes y mensajes correspondientes hacia los actuadores.
- **Modelo Actuador (`Actuator Statechart`):** 
  Modela el comportamiento de las salidas digitales (como el accionamiento de la barrera representada mediante un LED o la gestión de estados intermitentes/pulsos). Garantiza que las respuestas físicas del sistema se ejecuten de manera sincronizada y sin bloquear la CPU del microcontrolador.
