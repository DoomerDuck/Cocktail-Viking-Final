extends PlayerState


func enter_state(player_node):
	super(player_node) #call parent class method
	player.velocity.x = 0
	player.play_animation("hurt")
	$Timer.start()


func _on_timer_timeout() -> void:
	player.change_state("IdleState")
