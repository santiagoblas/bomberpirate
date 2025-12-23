extends AnimatedSprite2D
class_name Coin


#INFO Cuando seleccionás un nodo, a la derecha está el menú "Node". Ahí se conectan las señales a funciones existentes o nuevas.
# Conectado con señal de Area2D, hacer click en el simbolito verde.
func _on_area_2d_body_entered(area):
	play("pop")


# Conectado con señal de AnimatedSprite2D (Coin)
func _on_animation_finished():
	# Cuando termina la animación pop desaparece la moneda
	if animation == "pop":
		queue_free()
