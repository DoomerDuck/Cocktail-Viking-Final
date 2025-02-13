extends CharacterBody2D
class_name MeleeEnemy


var speed = 100
var facing_right = true
@onready var detect_ground : RayCast2D = $GroundDetect
var can_move : bool = true
@onready var anim = $AnimatedSprite2D
var take_damage : bool = false
var health : int
var damage_taken : int

func _ready() -> void:
	health = 100

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		velocity.x = speed
	if !detect_ground.is_colliding() && is_on_floor():
		flip()
	if can_move:
		anim.play("run")
		velocity.x = speed
	else:
		velocity.x = 0
	if health <= 0:
		dead()
		
	move_and_slide()

func flip():
	scale.x = abs(scale.x) * -1
	facing_right = !facing_right
	if facing_right:
		speed = abs(speed)
	else:
		speed = abs(speed) * -1

func take_damage_from_player(player_damage):
	if take_damage:
		health -= player_damage
		take_damage = false
		can_move = false
		#$Timer.start()
		anim.play("hurt")
		await anim.animation_finished
		can_move = true

func dead():
	anim.play("death")
	await anim.animation_finished
	queue_free()
	
