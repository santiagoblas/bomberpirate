extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -400.0


# Los comentarios que estaban aquí siguen en la rama del tutorial anterior por si querés verlos.
#region Movilidad
var _direction:float = 0
var _speed:float = 0
var _gravity:float = 10


func _input(event:InputEvent):
	if event.is_action("move_left") or event.is_action("move_right"):
		_direction = Input.get_axis("move_left", "move_right")
	
	if event.is_action_pressed("jump") and is_on_floor():
		_jump()


func _physics_process(delta):
	_movement(delta)
	
	# Ordena el movimiento
	move_and_slide()


func _movement(delta):
	if not is_on_floor():
		velocity.y += _gravity
	
	if _direction == 0:
		_speed -= sign(_speed) * 20
		velocity.x = _speed
		return
	
	if abs(_speed) <= SPEED or \
	(abs(_speed) > SPEED and sign(_speed) != _direction): 
		_speed += _direction * 15
		print_debug(_speed)
	
	velocity.x = _speed


func _jump():
	velocity.y += JUMP_VELOCITY
#endregion
