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
	_ENEMY._dead = true
	_ENEMY.z_index = -6
	%AnimationPlayer.play("die")
	$"../CollisionShape2D".queue_free()
	await %AnimationPlayer.animation_finished
	%Attack.queue_free()
	%Movement.queue_free()
	%Sight.queue_free()
	$"../DamageDetection".queue_free()
	$"../FlipComponents".queue_free()


func _on_damage_detection_area_entered(area:Area2D):
	_has_control = true
	
	#HACK Esta no es ni de cerca una buena forma de hacer esto, pero es una opción que existe. Miren en el Inspector en AttackArea del capitan y de la bomba, abajo de todo está la metadata
	var damage:int = area.get_meta("damage") if area.has_meta("damage") else 1
	
	_take_damage(damage)
	# Reproducimos la animación de daño y esperamos su finalización para volver a idle
	
	if _ENEMY._dead:
		return
	
	%AnimationPlayer.play("hit")
	#Comentarios en 6-ATAQUE-Y-SALUD-ENEMIGO
	await %AnimationPlayer.animation_finished
	_has_control = false
	%AnimationPlayer.play("idle")
