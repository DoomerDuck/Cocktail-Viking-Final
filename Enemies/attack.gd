extends RayCast2D

var target: Player = null
var damage = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if is_colliding():
		if get_collider() is Player:
			target = get_collider()
			target.take_damage(damage)
