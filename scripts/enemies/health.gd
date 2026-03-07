extends Node
class_name EnemyHealth


@export var _ENEMY:Enemy
#Comentarios en 6-ATAQUE-Y-SALUD-ENEMIGO
@export var _max_hp:int = 3
var _hp:int = 0
var _has_control:bool = false


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
	_has_control = true
	# Reproducimos la animación de daño y esperamos su finalización para volver a idle
	%AnimationPlayer.play("hit")
	#Comentarios en 6-ATAQUE-Y-SALUD-ENEMIGO
	await %AnimationPlayer.animation_finished
	_has_control = false
	%AnimationPlayer.play("idle")
