extends Node
class_name CaptainHealth


#Los comentarios están en rama 5-ENEMIGO-Y-DANIO
@export var _CAPTAIN:CaptainBoom
#ALERT PRO TIP Vamos a usar has control para indicar que se está finalizando una acción y este script controla al capitán momentáneamente. 
var _has_control:bool
var _hp = 10


func _take_damage(damage:int):
	_has_control = true
	
	%AnimationPlayer.play("hit")
	#ALERT PRO TIP: Conecto la señal de animación finalizada solo cuando la necesito*
	%AnimationPlayer.animation_finished.connect(_on_animation_finished)
	
	_hp -= damage
	
	if _hp <= 0:
		_hp = 0
		_die()


func _die():
	get_parent().queue_free()


func _respawn():
	_CAPTAIN.global_position = _CAPTAIN._respawn_point.global_position


func _on_damage_detection_area_entered(area:Area2D):
	if area.get_collision_layer_value(11):
		_respawn()


func _on_damage_detection_body_entered(body:PhysicsBody2D):
	if body.get_collision_layer_value(5):
		_take_damage(1)
		%Movement._knockback(body.global_position)


# Si cuando termina la animación tiene el control se lo quito
func _on_animation_finished(animation_name):
	_has_control = false
	
	#ALERT PRO TIP: *Aquí desconecto la señal que conecté arriba
	# También podría estar la señal siempre conectada y con if _has_control sabríamos si debemos o no actuar
	%AnimationPlayer.animation_finished.disconnect(_on_animation_finished)
