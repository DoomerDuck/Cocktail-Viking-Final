extends PlayerState

func enter_state(player_node):
	super(player_node) #call parent class method
	player.velocity.x = 0
	player.play_animation("idle")
	
func handle_input(_delta):
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		player.change_state("JumpingState")
	elif Input.get_axis("left","right") != 0:
		player.change_state("MovingState")
	elif Input.is_action_just_pressed("dash"):
		player.change_state("DashingState")
	elif Input.is_action_just_pressed("attack_melee"):
		player.change_state("AttackingState")
	elif Input.is_action_just_pressed("attack_aoe") and player.is_on_floor():
		player.change_state("AttackingAOE")
	elif Input.is_action_just_pressed("attack_range") and player.is_on_floor():
		player.change_state("AttackingRange")
	elif Input.is_action_just_pressed("buff") and player.is_on_floor():
		player.change_state("BuffingState")
