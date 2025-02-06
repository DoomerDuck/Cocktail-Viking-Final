extends PlayerState

var attack_duration : float = 2
var attack_timer : float = 0.0

func enter_state(player_node):
	super(player_node)
	attack_timer = attack_duration
	player.velocity.x = 0
	#here there should be the buff function based on what cocktail was used
	player.play_animation("attack_buff")
	
func handle_input(delta):
	update_state(delta)
	
func update_state(delta):
	attack_timer -= delta
	if attack_timer <= 0:
		player.change_state("IdleState")
