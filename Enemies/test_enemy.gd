extends CharacterBody2D

var health : int
@onready var healthbar = $HealthBar
@onready var dno = $dno
var take_damage : bool = false

func _ready() -> void:
	health = 100
	healthbar.init_health(health)
	healthbar.health = health

func _physics_process(_delta: float) -> void:
	if health <= 0:
		queue_free()
	healthbar.health = health
	take_damage_from_player()
	
func take_damage_from_player():
	if take_damage:
		var damage_taken = health - healthbar.damage_bar.value
		DispayNumber.display_number(damage_taken, dno.global_position, true, false, false, false)
		take_damage = false
