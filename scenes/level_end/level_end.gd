extends Area2D

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _on_area_entered(area: Area2D) -> void:
	AudioManager.play_sfx(audio_stream_player_2d, AudioManager.SUCCESS)
	SignalManager.level_completed.emit()
	#GameManager.load_next_level()
