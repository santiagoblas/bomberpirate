extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -400.0


 #esta se comenta para la versión pro
 #(este es el template predefinido de godot).
func _physics_process(delta):
	# Añadimos la gravedad al vector velocidad.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Manejo del salto con ui_accept (action predefinida de godot).
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Obtenemoos la dirección
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		# Seteamos la velocidad en x
		velocity.x = direction * SPEED
	else:
		# Devolvemos la velocidad en x a 0
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# move_and_slide es una de las formas de mover un CharacterBody. Utiliza el vector velocity que seteamos antes.
	move_and_slide()


#region Versión Pro
## Para usar esta versión comentar la función _physics_process que está arriba y descomentamos todo esta region (Seleccionamos todo y Ctrl+K)
#var _direction:float = 0
#var _speed:float = 0
#var _gravity:float = 10
#
#
#func _input(event:InputEvent):
	## Con event.is_action vemos si se utilizó algún control de movimiento
	## (Utilizamos actions definidos en Project->Project Settings->Input Map)
	#if event.is_action("move_left") or event.is_action("move_right"):
		## Usamos la clase Input para extraer un valor entre -1.0 y 1.0
		#_direction = Input.get_axis("move_left", "move_right")
	#
	## Con event.is_actio_pressed nos fijamos si fue presionada la acción jump
	#if event.is_action_pressed("jump") and is_on_floor():
		#_jump()
#
#
#func _physics_process(delta):
	#_movement(delta)
	#
	## Ordena el movimiento
	#move_and_slide()
#
#
#func _movement(delta):
	#if not is_on_floor():
		#velocity.y += _gravity
	#
	## Input presionado en una dirección?
	#if _direction == 0:
		##Bajo la velocidad si no hay input (controlando la desaceleración)
		#_speed -= sign(_speed) * 20
		#velocity.x = _speed
		#return
	#
	## Velocidad máxima alcanzada?
	#if abs(_speed) <= SPEED or \
	## Maxima pero Input en la dirección opuesta?
	#(abs(_speed) > SPEED and sign(_speed) != _direction): 
		##Acelero hasta la velocidad máxima (controlando la aceleración)
		#_speed += _direction * 15
		#print_debug(_speed)
	#
	#velocity.x = _speed
#
#
#func _jump():
	## Setea una velocidad hacia arriba. El eje Y baja hacia arriba en godot 2D 🤷‍♂️
	#velocity.y += JUMP_VELOCITY
#endregion
