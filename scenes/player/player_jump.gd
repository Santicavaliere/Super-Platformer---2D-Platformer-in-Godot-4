## Estado de caída y gestión de aterrizaje.
extends State

func enter():
	player.animated_sprite.play("jump")
	player.velocity.y = player.jump_speed

func physics_update(delta: float):
	player.velocity.y += player.gravity * delta
	
	var direction = Input.get_axis("left", "right")
	if direction:
		player.velocity.x = direction * player.speed
		player.animated_sprite.flip_h = player.velocity.x < 0
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.speed)
	
	player.move_and_slide()
	
	if player.velocity.y > 0:
		transition_requested.emit("fall")
