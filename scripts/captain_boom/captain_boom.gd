extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -400.0


# Reordenamos las variables
var _direction:float = 0
var _speed:float = 0
var _gravity:float = 10


# Los comentarios se encuentran en la rama 2-ANIMACIONES
func _process(delta):
	var is_on_floor:bool = is_on_floor()
	
	if (Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right")):
		if is_on_floor:
			$AnimationPlayer.play("walk")
	
	if not is_on_floor and \
	velocity.y > 0:
		$AnimationPlayer.play("fall")
	
	if is_on_floor and _speed < 50 and _direction == 0:
		$AnimationPlayer.play("idle")


func _input(event:InputEvent):
	if event.is_action("move_left") or event.is_action("move_right"):
		_direction = Input.get_axis("move_left", "move_right")
		if _direction != 0:
			$Sprite2D.flip_h = _direction < 0
	
	if event.is_action_pressed("jump") and is_on_floor():
		_jump()


func _physics_process(delta):
	_movement(delta)
	
	move_and_slide()


func _movement(delta):
	if not is_on_floor():
		velocity.y += _gravity
		if _speed != 0:
			_speed -= sign(_speed) * 8
	
	if _direction == 0 and is_on_floor():
		_speed -= sign(_speed) * 20
		if abs(_speed) <= 5:
			_speed = 0
		velocity.x = _speed
		return
	
	if abs(_speed) <= SPEED or \
	(abs(_speed) > SPEED and sign(_speed) != _direction): 
		_speed += _direction * 15
	
	velocity.x = _speed


func _jump():
	velocity.y += JUMP_VELOCITY
	$AnimationPlayer.play("jump")
