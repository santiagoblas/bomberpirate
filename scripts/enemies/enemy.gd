extends CharacterBody2D
class_name Enemy


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Guardo esto para después
	#velocity.y = JUMP_VELOCITY
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
