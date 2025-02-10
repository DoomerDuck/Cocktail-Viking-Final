extends PlayerState

var attack_duration : float = 1.5
var attack_timer : float = 0.0
@onready var player_sprite = $"../Sprite2D"
@onready var aoe_area = $"../AOEAttackArea/AOE"
var is_aoe : bool = false
@onready var dno = $"../DamageNumberOrigins"
@onready var hurtbox = $"../AOEAttackArea"

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
		player.change_state("IdleState")
func aoe_attack():
	$AOETimer.start()

func _on_aoe_attack_area_body_entered(_body: Node2D) -> void:
		hurtbox.aoe_attack()
		hurtbox.player_damage = player.aoe_damage
		is_aoe = true
	#if body.is_in_group("Enemy") and is_aoe:
		#body.health -= player.aoe_damage
		#is_aoe = false
		#body.take_damage = true
		#body.damage_taken = player.aoe_damage
		#body.take_damage_from_player()

func _on_aoe_timer_timeout() -> void:
	aoe_area.disabled = false
