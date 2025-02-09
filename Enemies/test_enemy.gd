extends CharacterBody2D

var health : int
@onready var healthbar = $HealthBar
@onready var dno = $dno
var take_damage : bool = false
var damage_taken : int

func _ready() -> void:
	health = 100
	healthbar.init_health(health)
	healthbar.health = health

func _physics_process(_delta: float) -> void:
	if health <= 0:
		queue_free()
	healthbar.health = health

	
func take_damage_from_player(player_damage):
	if take_damage:
		health -= player_damage
		#DispayNumber.display_number(player_damage, dno.global_position, true, false, false, false)
		take_damage = false
