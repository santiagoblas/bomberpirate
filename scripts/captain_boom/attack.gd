extends Node
class_name CaptainAttack


var _has_control:bool = false #ALERT Ver PRO TIP en Health
var _can_attack:bool = true


func _input(event):
	if _can_attack and event.is_action_pressed("attack"):
		#Flag para el cooldown
		_can_attack = false
		_has_control = true
		
		%AnimationPlayer.play("attack_1")
		#ALERT Ver PRO TIP en Health
		%AnimationPlayer.animation_finished.connect(_on_animation_finished)
		
		#Cooldown para evitar ataques muy seguidos
		$Cooldown.start()
	pass


func _attack():
	pass


# Esta función será llamada cuando el Timer Cooldown termine con su conteo.
# Fue seteada con la configuración de Node (Al lado de Inspector a tu derecha)
func _on_cooldown_timeout():
	_can_attack = true


# Esta función será llamada cuando el AnimationPlayer termine con su animación actual.
# (Siempre que esté conectada a la señal)
func _on_animation_finished(animation_name:String):
	#ALERT Ver PRO TIP en Health
	_has_control = false
	%AnimationPlayer.animation_finished.disconnect(_on_animation_finished)
