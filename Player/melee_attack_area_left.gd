extends Area2D

var player_damage : int

func _ready() -> void:
	aoe_attack()
	
func aoe_attack():
	var targets = get_overlapping_bodies()
	for target in targets:
		if target.is_in_group("Enemy"):
			target.take_damage_from_player(player_damage)
			target.take_damage = true
		else:
			pass
