## Estado de caída y gestión de aterrizaje.
extends State

func enter():
	player.animated_sprite.play("fall")

func physics_update(delta: float):
	player.update_game_feel_timers(delta)
	player.velocity.y += player.gravity * delta

	# MOVIMIENTO AÉREO 
	var direction = Input.get_axis("left", "right")
	if direction:
		player.velocity.x = direction * player.speed
		player.animated_sprite.flip_h = player.velocity.x < 0
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.speed)

	# --- LÓGICA DE SALTO (COYOTE TIME) ---
	if Input.is_action_just_pressed("jump") and player.coyote_timer > 0:
		player.velocity.y = player.jump_speed
		player.coyote_timer = 0 
		transition_requested.emit("jump")
		return

	# --- LÓGICA DE BUFFER (GUARDAR EL INPUT) ---
	# Si presionamos saltar en el aire (y ya no hay coyote), guardamos la intención
	if Input.is_action_just_pressed("jump"):
		player.jump_buffer_timer = player.jump_buffer_time

	player.move_and_slide()

# --- TRANSICIONES AL ATERRIZAR ---
	if player.is_on_floor():
		if player.jump_buffer_timer > 0:
			player.jump_buffer_timer = 0 
			transition_requested.emit("jump")
			return
			
		if direction != 0:
			transition_requested.emit("run")
		else:
			transition_requested.emit("idle")
