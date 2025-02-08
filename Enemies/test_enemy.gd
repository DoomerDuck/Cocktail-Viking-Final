extends CharacterBody2D

var health : int
@onready var healthbar = $HealthBar

func _ready() -> void:
	health = 100
	healthbar.init_health(health)
	healthbar.health = health

func _physics_process(_delta: float) -> void:
	if health <= 0:
		queue_free()
	healthbar.health = health
	
