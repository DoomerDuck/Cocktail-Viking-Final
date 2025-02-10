extends CharacterBody2D

var health : int
var speed = 60
@onready var healthbar = $HealthBar
@onready var dno = $dno
var take_damage : bool = false
var facing_right = true
var damage_taken : int

func _ready() -> void:
	health = 100
	healthbar.init_health(health)
	healthbar.health = health

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	if health <= 0:
		queue_free()
	healthbar.health = health
	velocity.x = speed
	move_and_slide()
	if !$RayCast2D.is_colliding() && is_on_floor():
		flip()

	
func take_damage_from_player(player_damage):
	if take_damage:
		player_damage = damage_taken
		health -= player_damage
		#DispayNumber.display_number(player_damage, dno.global_position, true, false, false, false)
		take_damage = false

func flip():
	scale.x = abs(scale.x) * -1
	facing_right = !facing_right
	if facing_right:
		speed = abs(speed)
	else:
		speed = abs(speed) * -1
