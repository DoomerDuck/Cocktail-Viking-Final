extends PlayerState

func enter_state(player_node):
	super(player_node)
	player.play_animation("move")

func handle_input(_delta):
	var direction = Input.get_axis("left", "right")
	if direction != 0:
		player.velocity.x = direction * player.speed
	else:
		player.change_state("IdleState")
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		player.change_state("JumpingState")
	elif Input.is_action_just_pressed("dash"):
		player.change_state("DashingState")
	elif Input.is_action_just_pressed("attack_melee"):
		player.change_state("MoveAttackState")
	elif Input.is_action_just_pressed("attack_aoe") and player.is_on_floor():
		player.change_state("AttackingAOE")
	elif Input.is_action_just_pressed("attack_range") and player.is_on_floor():
		player.change_state("AttackingRange")
	elif Input.is_action_just_pressed("buff") and player.is_on_floor():
		player.change_state("BuffingState")
