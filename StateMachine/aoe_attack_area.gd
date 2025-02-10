extends Area2D

var player_damage : int
@onready var is_aoe = $"../AttackingAOE"

func _ready() -> void:
	aoe_attack()
	is_aoe.is_aoe = true
	
func aoe_attack():
	var targets = get_overlapping_bodies()
	for target in targets:
		if target.is_in_group("Enemy"):
			target.take_damage_from_player(player_damage)
			target.take_damage = true
			target.damage_taken = player_damage
		else:
			pass
