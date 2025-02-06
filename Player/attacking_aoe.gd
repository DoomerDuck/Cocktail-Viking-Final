extends PlayerState

var attack_duration : float = 1.5
var attack_timer : float = 0.0
@onready var player_sprite = $"../Sprite2D"
@onready var aoe_area = $"../AOEAttackArea/AOE"
var aoe_damage : int = 25
var is_aoe : bool = false

func enter_state(player_node):
	super(player_node)
	attack_timer = attack_duration
	player.velocity.x = 0
	aoe_attack()
	player.play_animation("attack_aoe")
	
func handle_input(delta):
	update_state(delta)
	
func update_state(delta):
	attack_timer -= delta
	if attack_timer <= 0:
		aoe_area.disabled = true
		is_aoe = false
		player.change_state("IdleState")
func aoe_attack():
	aoe_area.disabled = false

func _on_aoe_attack_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy") and is_aoe:
		body.health -= aoe_damage
