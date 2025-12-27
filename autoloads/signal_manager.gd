## Bus de eventos global (Patrón Observer).
##
## Centraliza las señales para desacoplar los objetos del juego (ej: Enemigo -> UI).
extends Node

## Emitida cuando el puntaje cambia.
signal score_updated

## Emitida cuando el jugador alcanza el objetivo final del nivel.
signal level_completed
