extends PlayerState

var attack_duration : float = 1.5
var attack_timer : float = 0.0

func enter_state(player_node):
	super(player_node)
	attack_timer = attack_duration
	player.velocity.x = 0
	buff_melee()
	player.play_animation("attack_buff")
	
func handle_input(delta):
	update_state(delta)
	
func update_state(delta):
	attack_timer -= delta
	if attack_timer <= 0:
		player.change_state("IdleState")

func buff_melee():
	if player.mana >= 20:
		player.move_attack_damage = 10
		player.jump_melee_damage = 10
		player.melee_damage = 30
		$Timer.start()
		player.mana -= 20

func _on_timer_timeout() -> void:
	player.move_attack_damage = 5
	player.jump_melee_damage = 5
	player.melee_damage = 15
