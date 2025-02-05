extends PlayerState

var dash_speed = 1000 #how fast is the dash
var dash_duration = 0.2 #how long is the dash
var dash_timer = 0.0 #track dash duration

func enter_state(player_node):
	super(player_node)
	var direction = Input.get_axis("left","right")
	if direction == 0:
		direction = player.last_faced_direction
	player.velocity.x = direction * dash_speed
	dash_timer = dash_duration
	player.play_animation("dash")
	
func handle_input(delta):
	dash_timer -= delta
	if dash_timer <= 0:
		if Input.get_axis("left","right") != 0:
			player.change_state("MovingState")
		else:
			player.change_state("IdleState")
