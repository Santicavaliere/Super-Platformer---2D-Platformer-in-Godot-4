## Gestor de estados genérico.
##
## Inicializa, actualiza y gestiona las transiciones entre nodos hijos de tipo [State].
## Garantiza que solo un estado esté activo a la vez.
class_name StateMachine
extends Node

## El estado inicial con el que arrancará la máquina.
@export var initial_state: State

var current_state: State
var states: Dictionary = {}

func _ready() -> void:
	await owner.ready 
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.player = owner
			child.transition_requested.connect(on_child_transition)
	if initial_state:
		initial_state.enter()
		current_state = initial_state

func _process(delta):
	if current_state:
		current_state.update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

## Maneja la transición segura entre el estado actual y el nuevo.
## Llama a [method State.exit] del anterior y [method State.enter] del nuevo.
func on_child_transition(new_state_name: String):
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		push_warning("El estado " + new_state_name + " no existe.")
		return
	
	if current_state:
		current_state.exit()
	
	new_state.enter()
	current_state = new_state
