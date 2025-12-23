extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -400.0


# Usamos el process para las animaciones
func _process(delta):
	var is_on_floor:bool = is_on_floor()
	
	# Si se presionó una dirección
	if (Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right")):
		# Si está en el suelo (no saltando o cayendo)
		if is_on_floor:
			# Reproducimos la animación deseada con la siguiente linea
			# '$' nos ayuda a conseguir la referencia del nodo dentro de nuestro arbol actual. 🏃‍♂️CaptainBoom > 🎞AnimationPlayer (en Scene, probablemente a tu izquierda)
			$AnimationPlayer.play("walk")
	
	# Si se presionó para saltar y está en el suelo
	#ALERT este if se comenta en la version pro. Buscar region
	if Input.is_action_just_pressed("jump") and velocity.y < 0:
		$AnimationPlayer.play("jump")
	
	# Si no está en el suelo, la velocidad en Y es mayor a 0 (hacia abajo 🔽)
	if not is_on_floor and \
	velocity.y > 0:
		$AnimationPlayer.play("fall")
	
	# Si estamos en el suelo, la velocidad es baja y no hay movimiento
	if is_on_floor and _speed < 50 and _direction == 0:
		$AnimationPlayer.play("idle")
	
	# Cambio la dirección del sprite
	#ALERT este if se comenta en la version pro. Buscar region
	if _direction != 0:
		$Sprite2D.flip_h = _direction < 0

# Los comentarios que estaban aquí siguen en la rama del tutorial anterior por si querés verlos.
var _direction:float = 0
var _speed:float = 0
var _gravity:float = 10


func _input(event:InputEvent):
	if event.is_action("move_left") or event.is_action("move_right"):
		_direction = Input.get_axis("move_left", "move_right")
		
		#region Versión Pro Animaciones
		# Aquí cambia _direction, ¿por qué no ejecutar este código solo en estas ocasiones?
		# La versión pro, como siempre, será la utilizada como base del siguiente tutorial
		if _direction != 0:
			$Sprite2D.flip_h = _direction < 0
		#endregion
	
	if event.is_action_pressed("jump") and is_on_floor():
		_jump()


func _physics_process(delta):
	_movement(delta)
	
	# Ordena el movimiento
	move_and_slide()


func _movement(delta):
	if not is_on_floor():
		velocity.y += _gravity
		#ALERT PRO TIP: Simulamos una resistencia del aire
		if _speed != 0:
			_speed -= sign(_speed) * 8
	
	#MEJORA Solo frenamos así si está en el piso
	if _direction == 0 and is_on_floor():
		_speed -= sign(_speed) * 20
		#MEJORA Frenamos completamente si la velocidad es baja
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
	
	#region Versión Pro Animaciones
	# Tenemos un lugar clave donde aplicar la animación de salto. Todo lo que sucede en el salto se hace acá
	#$AnimationPlayer.play("jump")
	#endregion
