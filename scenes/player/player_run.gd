## Estado de movimiento horizontal en suelo.
extends State

func enter():
	player.animated_sprite.play("run")

func physics_update(delta: float):
	# Gravedad
	if not player.is_on_floor():
		player.coyote_timer = player.coyote_time
		transition_requested.emit("fall")
		return
		

	# Movimiento
	var direction = Input.get_axis("left", "right")
	if direction:
		player.velocity.x = direction * player.speed
		
		player.animated_sprite.flip_h = player.velocity.x < 0
	else:
		# Si soltó la tecla, volvemos a Idle
		player.velocity.x = move_toward(player.velocity.x, 0, player.speed)
		transition_requested.emit("idle")
		
	# Salto 
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		transition_requested.emit("jump")

	player.move_and_slide()
