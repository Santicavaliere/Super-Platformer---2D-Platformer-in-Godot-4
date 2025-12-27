## Clase base abstracta para implementar el patrón State.
##
## Esta clase define la interfaz que todos los estados del juego deben respetar.
## No debe adjuntarse directamente a un nodo, debe ser heredada.
class_name State
extends Node

## Referencia al [Player] que es dueño de este estado.
## Se inyecta automáticamente desde la [StateMachine].
var player: CharacterBody2D

## Señal emitida cuando el estado desea finalizar y cambiar a otro.
signal transition_requested(new_state_name: String)

## Método virtual. Se ejecuta una única vez al entrar al estado.
## Útil para iniciar animaciones o resetear variables temporales.
func enter():
	pass

## Método virtual. Se ejecuta una única vez antes de cambiar a otro estado.
## Útil para limpieza de datos.
func exit():
	pass

## Método virtual. Equivalente a [_process].
func update(delta: float):
	pass

## Método virtual. Equivalente a [_physics_process].
## Aquí se debe implementar la lógica de movimiento y físicas.
func physics_update(delta: float) -> void:
	pass
