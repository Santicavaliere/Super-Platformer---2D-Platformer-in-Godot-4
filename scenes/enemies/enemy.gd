## Entidad básica de enemigo con patrulla simple y daño por contacto.
class_name Enemy

extends CharacterBody2D

@export var speed: float
@export var gravity: float
@export var points: int
@onready var hurtbox: Area2D = $Hurtbox
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var player

func _ready() -> void:
	SignalManager.level_completed.connect(_on_level_completed)
	player = get_tree().get_first_node_in_group("player")
	set_physics_process(false)


func _on_hurtbox_area_entered(area: Area2D) -> void:
	if player.position.y < hurtbox.global_position.y:
		die()


func die():
	animation_player.play("dissapear")
	set_physics_process(false)
	animated_sprite_2d.pause()
	GameManager.update_score(points)
	SignalManager.score_updated.emit()
	AudioManager.play_sfx(audio_stream_player_2d, AudioManager.ENEMY_DIE)	

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	set_physics_process(true)

func _on_level_completed():
	set_physics_process(false)
