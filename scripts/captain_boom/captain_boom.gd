extends CharacterBody2D
class_name CaptainBoom


const LAYER_PLATFORM:int = 9


@export var _respawn_point:Marker2D


func _input(event:InputEvent):
	if event.is_action("move_left") or event.is_action("move_right"):
		var direction = Input.get_axis("move_left", "move_right")
		if direction != 0:
			$Sprite2D.flip_h = direction < 0
			if is_on_floor(): 
				$AnimationPlayer.play("walk")


func _process(delta):
	var is_on_floor:bool = is_on_floor()
	
	if not is_on_floor and velocity.y > 0:
		$AnimationPlayer.play("fall")
	
	if is_on_floor and $Movement._speed < 50 and $Movement._direction == 0:
		$AnimationPlayer.play("idle")


#Las funciones que estaban acá ahora están distribuidas en Movement y Health. Mirar comentarios en rama 5-ENEMIGO-Y-DANIO
