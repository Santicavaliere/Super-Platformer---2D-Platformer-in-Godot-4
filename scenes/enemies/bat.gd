extends Enemy



func _physics_process(delta: float) -> void:
	if not player:
		return
	
	flip()
	follow_player()

func flip():
	animated_sprite_2d.flip_h = player.position.x > position.x
	

func follow_player():
	var direction = (player.position - position).normalized()
	velocity = direction * speed
	move_and_slide()
