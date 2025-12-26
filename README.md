# Super Platformer 2D Platformer in Godot 4

## 🎮 Sobre el Proyecto
Este proyecto es un plataformas 2D desarrollado en Godot 4.4 utilizando GDScript. 
El objetivo principal fue implementar una arquitectura de software escalable y robusta, aplicando principios de Ingeniería de Software.
El juego cuenta con sistema de niveles, persistencia de datos (High Score), audio manager y mecánicas de "Game Feel" avanzadas.

### 🛠️ Aspectos Técnicos Destacados
Lo más valioso de mí proyecto es la estructura del código. Para esto, voy a enumerar algunos aspectos destacados:

### ⚙️ Arquitectura
* **Máquina de Estados Finita (FSM):** Lógica del jugador desacoplada en nodos independientes (`Idle`, `Run`, `Jump`, `Fall`) para máxima escalabilidad.
* **Sistema de Eventos:** Uso de `Signals` para comunicar UI, Player y Enemigos sin dependencias rígidas.

### 🕹️ Game Feel (Jugabilidad)
* **Coyote Time:** Implementación de ventana de tiempo post-plataforma.
* **Jump Buffering:** Cola de inputs para saltos precisos.
* **Variable Jump Height:** Control físico total sobre la altura del salto.

### Patrones de Diseño Aplicados
* **Singleton:** Utilizado en GameManager para el control de flujo global y AudioManager para la gestión de sonido persistente.
* **Observer (Signals):** Uso de un SignalManager para comunicar la UI, el Player y los enemigos sin generar dependencias rígidas (Spaghetti Code).
* **Composition:** Utilicé nodos hijos (Hurtboxes, StateMachine) para agregar funcionalidades en caso de necesitarlas en un futuro.

## 🛠️ Tecnologías Usadas
* **Engine:** Godot 4.4 (GDScript)
* **Patrones:** Singleton, State, Observer, Component.
* **Persistencia:** Sistema de guardado JSON/Binario para High Scores.

* **Santiago Cavaliere**
