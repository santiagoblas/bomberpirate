extends Node
class_name EnemyHealth


# Para acceder con facilidad al parent
@export var _ENEMY:Enemy
#ALERT PRO TIP: Como voy a tener muchos enemigos, probablemente quiera cambiarle la vida que cada uno va a tener, entonces usamos max hp para luego en _ready cargar el valor en hp
@export var _max_hp:int = 3
var _hp:int = 0


func _ready():
	_hp = _max_hp


# Igual que el del player
func _take_damage(damage:int):
	_hp -= damage
	
	if _hp <= 0:
		_hp = 0
		_die()


func _die():
	_ENEMY.queue_free()


func _on_damage_detection_area_entered(area):
	_take_damage(1)
	# Reproducimos la animación de daño y esperamos su finalización para volver a idle
	%AnimationPlayer.play("hit")
	#ALERT PRO TIP: Luego de await colocamos una señal y el código ESPERARÁ AQUÍ hasta que esa señal sea enviada
	await %AnimationPlayer.animation_finished
	%AnimationPlayer.play("idle")
	# Recordar que para utilizar % hay que configurarlo desde Scene, haciendo click sobre el nodo e indicándole que queremos activar el nombre único sobre ese nodo.
