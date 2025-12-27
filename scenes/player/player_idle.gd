## Estado de movimiento horizontal en suelo.
extends State

func enter():
	player.animated_sprite.play("idle")
	player.velocity.x = 0

func physics_update(delta: float):
	if not player.is_on_floor():
		player.coyote_timer = player.coyote_time
		transition_requested.emit("fall")
		return
	
	var direction = Input.get_axis("left", "right")
	if direction != 0:
		transition_requested.emit("run")
	
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		transition_requested.emit("jump")
		
	
	player.move_and_slide()
