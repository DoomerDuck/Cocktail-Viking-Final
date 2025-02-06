extends CharacterBody2D

var health = 50

func _physics_process(_delta: float) -> void:
	$Label.text = str(health)
	if health <= 0:
		queue_free()
