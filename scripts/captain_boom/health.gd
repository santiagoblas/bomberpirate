extends Node
class_name CaptainHealth


#Los comentarios están en rama 5-ENEMIGO-Y-DANIO
@export var _CAPTAIN:CaptainBoom
#Comentarios en 6-ATAQUE-Y-SALUD-ENEMIGO
var _has_control:bool
var _hp = 10


func _take_damage(damage:int):
	_has_control = true
	
	%AnimationPlayer.play("hit")
	#Comentarios en 6-ATAQUE-Y-SALUD-ENEMIGO
	%AnimationPlayer.animation_finished.connect(_on_animation_finished)
	
	_hp -= damage
	
	if _hp <= 0:
		_hp = 0
		_die()


func _die():
	# _CAPTAIN._dead se utilizará para evitar que se ejecute código con el pj en ese estado
	_CAPTAIN._dead = true
	%AnimationPlayer.play("die")
	# Primero esperamos que la animación se complete y luego nos deshacemos de los nodos que no vamos a necesitar más
	await %AnimationPlayer.animation_finished
	%Attack.queue_free()
	$"../DamageDetection".queue_free()
	$"../AttackArea".queue_free()
	%Movement.queue_free()


func _respawn():
	_CAPTAIN.global_position = _CAPTAIN._respawn_point.global_position


func _on_damage_detection_area_entered(area:Area2D):
	if area.get_collision_layer_value(11):
		_respawn()
	elif area.get_collision_layer_value(5):
		_handle_enemy_collision(area.global_position)


func _on_damage_detection_body_entered(body:PhysicsBody2D):
	if body.get_collision_layer_value(5) and body is Enemy:
		_handle_enemy_collision(body.global_position)


func _handle_enemy_collision(hit_position:Vector2):
	_take_damage(1)
	%Movement._knockback(hit_position)


# Si cuando termina la animación tiene el control se lo quito
func _on_animation_finished(animation_name):
	_has_control = false
	
	#Comentarios en 6-ATAQUE-Y-SALUD-ENEMIGO
	%AnimationPlayer.animation_finished.disconnect(_on_animation_finished)
