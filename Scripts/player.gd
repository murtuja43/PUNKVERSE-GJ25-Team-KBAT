extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Left / Right movement
	var direction := Input.get_axis("move_left", "move_right")

	if direction != 0:
		velocity.x = direction * SPEED

		# Flip sprite when moving left
		$AnimatedSprite2D.flip_h = direction < 0

		# Play run animation
		if not $AnimatedSprite2D.is_playing():
			$AnimatedSprite2D.play("run")
	else:
		# Stop horizontal movement
		velocity.x = move_toward(velocity.x, 0, SPEED)

		# Idle animation
		if is_on_floor():
			$AnimatedSprite2D.play("idle")

	move_and_slide()
