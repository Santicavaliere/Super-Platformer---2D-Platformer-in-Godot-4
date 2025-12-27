## Controlador principal del jugador.
##
## Utiliza una [StateMachine] para delegar la lógica de comportamiento (Idle, Run, Jump, Fall).
## Gestiona las variables de física y las configuraciones de "Game Feel".
class_name Player
extends CharacterBody2D

# --- CONFIGURACIÓN DE FÍSICAS ---

## Velocidad máxima de movimiento horizontal.
@export var speed: float = 200.0 

## Fuerza del impulso de salto (valor negativo hacia arriba).
@export var jump_speed: float = -400.0

## Gravedad aplicada constante.
@export var gravity: float = 900.0

# --- CONFIGURACIÓN DE GAME FEEL ---

@export_group("Game Feel")
## Tiempo de gracia (en segundos) para saltar después de caer de una plataforma.
@export var coyote_time: float = 0.15      

## Tiempo de ventana (en segundos) para registrar un salto antes de tocar el suelo.
@export var jump_buffer_time: float = 0.1 

# --- VARIABLES DE LÓGICA ---
var coyote_timer: float = 0.0
var jump_buffer_timer: float = 0.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var state_machine: StateMachine = $StateMachine 

func _ready() -> void:
	SignalManager.level_completed.connect(_on_level_completed)


func die():
	animation_player.play("dissapear")
	state_machine.set_physics_process(false) 
	animated_sprite.pause()
	AudioManager.play_sfx(audio_stream_player_2d, AudioManager.PLAYER_DIE)

## Reduce los temporizadores de Coyote Time y Jump Buffer.
## Debe ser llamado por los estados activos en cada frame físico.
func update_game_feel_timers(delta: float):
	if coyote_timer > 0:
		coyote_timer -= delta
	
	if jump_buffer_timer > 0:
		jump_buffer_timer -= delta

func _on_level_completed():
	state_machine.set_physics_process(false)
	animated_sprite.play("idle")


func _on_hurtbox_area_entered(area: Area2D) -> void:
	# Lógica de trampas
	if area.is_in_group("traps"):
		die()
		return
	
	# Lógica de enemigos (Goomba stomp)
	if position.y < area.global_position.y:
		velocity.y = jump_speed 
		state_machine.on_child_transition("jump")
	else:
		die()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	GameManager.restart_level()
	queue_free()
