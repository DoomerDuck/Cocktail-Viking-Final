extends PlayerState

func enter_state(player_node):
	super(player_node)
	player.velocity.y = player.jump_velocity
	player.play_animation("jump")
	
	
func handle_input(_delta):
	if player.is_on_floor():
		player.change_state("IdleState")
	elif Input.is_action_just_pressed("dash") and player.stamina >= 10:
		player.change_state("DashingState")
	elif Input.is_action_just_pressed("attack_melee"):
		player.change_state("JumpAttackState")
