extends CharacterBody2D

var enemy_health = 50

func _physics_process(delta: float) -> void:
	if enemy_health <= 0:
		queue_free()
