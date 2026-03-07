extends Node
class_name EnemyMovement

# En enemy en lugar de const usamos var, porque probablemente queramos que distintos enemigos tengan distintas velocidades
@export var SPEED = 30.0
const JUMP_VELOCITY = -400.0


@export var _enemy:Enemy
@export var _target:CaptainBoom
@export var _active:bool = true


# Dirección izq o der en que se moverá el enemigo.
@export var _direction:float


# Esto inicializa la dirección de los componentes del enemigo.
func _ready():
	if _direction > 0:
		_flip()


func _physics_process(delta):
	if not _enemy.is_on_floor():
		_enemy.velocity += _enemy.get_gravity() * delta
	
	if %Health._has_control:
		return
	
	_movement()
	
	#ALERT PRO TIP: Podría poner este código acá, pero... *
	#if _active:
		#if $"../Sight"._in_sight:
			#_follow()
		#else:
			#_patrol()

	_enemy.move_and_slide()


func _movement():
	#ALERT * ... de esta manera puedo hacer una "salida rápida" con return y me ahorro una tabulación. En este caso el código es mínimo y no es demasiada diferencia, pero hay casos donde aporta claridad encapsulando mejor una funcionalidad.
	if not _active:
		return
	
	# Si vemos al capitán lo seguimos, sino patrullamos. Son bastante parecidas de todas formas
	if $"../Sight"._in_sight:
		_follow()
	else:
		_patrol()
	
	# Cuando se ejecuta la función movimiento es un buen momento para ejecutar la animación correspondiente
	%AnimationPlayer.play("walk")


func _patrol():
	# Si no se detecta más el suelo hay que dar la vuelta.
	if not %FloorRC.is_colliding():
		_flip()
		_direction = _direction * -1
	
	_enemy.velocity.x = _direction * SPEED


func _follow():
	# Si se termina el piso en lugar de flipear frena, luego ampliaremos este comportamiento. Si nos colocamos donde nos vea pero no nos toque, se queda en el borde mirándonos
	if not %FloorRC.is_colliding():
		_enemy.velocity = Vector2.ZERO
		return
	
	_enemy.velocity.x = _direction * SPEED


func _flip():
	$"../Sprite2D".flip_h = not $"../Sprite2D".flip_h
	%FloorRC.position.x *= -1
	%SightRC.target_position.x *= -1
