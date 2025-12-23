extends Node
class_name CaptainHealth


var _hp = 10
# Una referencia al capitán
@export var _CAPTAIN:CaptainBoom


# Esta función es fácil de entender 😉
func _take_damage(damage:int):
	_hp -= damage
	
	if _hp <= 0:
		_hp = 0
		_die()


func _die():
	# Borramos al pj. Por ahora...
	get_parent().queue_free()


func _respawn():
	_CAPTAIN.global_position = _CAPTAIN._respawn_point.global_position


func _on_damage_detection_area_entered(area:Area2D):
	# La layer del área es 11 (FreeFall)?
	if area.get_collision_layer_value(11):
		_respawn()


func _on_damage_detection_body_entered(body:PhysicsBody2D):
	# La layer del body es 5 (Enemy)?
	if body.get_collision_layer_value(5):
		_take_damage(1)
		%Movement._knockback(body.global_position)
