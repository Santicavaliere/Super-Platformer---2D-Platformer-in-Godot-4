extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	SignalManager.level_completed.connect(_on_level_completed)
	visible = true
	animation_player.play("fade_in")


func _on_level_completed():
	animation_player.play("fade_out")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_out":
		GameManager.load_next_level()
