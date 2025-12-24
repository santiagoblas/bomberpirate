extends Node
class_name CaptainHealth


#Los comentarios están en rama 5-ENEMIGO-Y-DANIO
var _hp = 10
@export var _CAPTAIN:CaptainBoom


func _take_damage(damage:int):
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
