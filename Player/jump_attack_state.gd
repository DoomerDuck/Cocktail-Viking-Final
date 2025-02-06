extends PlayerState

var attack_duration : float = 0.5
var attack_timer : float = 0.0
@onready var player_sprite = $"../Sprite2D"
@onready var hitbox_right : CollisionShape2D = $"../MeleeAttackAreaRight/RightMelee"
@onready var hitbox_left : CollisionShape2D = $"../MeleeAttackAreaLeft/LeftMelee"
var jump_melee_damage : int = 5
var is_jump_melee : bool = false

func enter_state(player_node):
	super(player_node)
	attack_timer = attack_duration
	jump_attack_melee()
	player.play_animation("attack_melee_air")
	
func handle_input(delta):
	update_state(delta)
	
func update_state(delta):
	attack_timer -= delta
	if attack_timer <= 0:
		player.change_state("IdleState")
		hitbox_left.disabled = true
		hitbox_right.disabled = true
		is_jump_melee = false
func jump_attack_melee():
	is_jump_melee = true
	if player_sprite.flip_h:
		hitbox_left.disabled = false
	else:
		hitbox_right.disabled = false


func _on_melee_attack_area_right_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy") and is_jump_melee:
		body.health -= jump_melee_damage

func _on_melee_attack_area_left_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy") and is_jump_melee:
		body.health -= jump_melee_damage
