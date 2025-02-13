extends CharacterBody2D

const speed = 300.0
const jump_velocity = -400
var current_state
var last_faced_direction = 1
@export var player_health : int = 100
@export var mana : int = 50
@export var stamina : int = 70
@onready var player_sprite: AnimatedSprite2D = $Sprite2D
var move_attack_damage : int = 5
var jump_melee_damage : int = 5
var melee_damage : int = 15
var aoe_damage : int = 25

func _ready() -> void:
	change_state("IdleState")
	add_to_group("Player")
	
func change_state(new_state_name: String):
	if current_state:
		current_state.exit_state()
	current_state = get_node(new_state_name)
	if current_state:
		current_state.enter_state(self)
		
func _physics_process(delta: float) -> void:
	#update last facing direction based on input
	var direction = Input.get_axis("left", "right")
	#update direction when moving left or right
	if direction != 0:
		last_faced_direction = sign(direction)
		
	if not is_on_floor():
		velocity += get_gravity() * delta
	#make sure state is active
	if current_state:
		current_state.handle_input(delta)
		
	move_and_slide()
	if direction >= 1:
		player_sprite.flip_h = false
	elif direction <= -1:
		player_sprite.flip_h = true

func play_animation(animation_name):
	player_sprite.play(animation_name)
