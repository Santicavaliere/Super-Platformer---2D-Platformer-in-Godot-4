extends Camera2D

var player

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")


func _process(delta: float) -> void:
	if not player:
		return
	position = player.position 
