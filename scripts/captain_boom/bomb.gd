extends RigidBody2D
class_name Bomb


func _on_boom_timeout():
	_explode()


func _explode():
	#Al explotar nos deshacemos del sprite y activamos las partículas y la colisión de daño
	$AnimatedSprite2D.queue_free()
	$AttackArea/CollisionShape2D.disabled = false
	$GPUParticles2D.emitting = true
	#Esperamos por medio segundo y apagamos la colisión
	await get_tree().create_timer(.5).timeout
	$AttackArea/CollisionShape2D.disabled = true


func _on_gpu_particles_2d_finished():
	queue_free()
