extends CharacterBody2D

var health : int
var speed = 60
@onready var dno = $dno
var take_damage : bool = false
var facing_right = true
var damage_taken : int
var can_move : bool = true
@onready var anim = $AnimatedSprite2D

func _ready() -> void:
	health = 100

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	if health <= 0:
		anim.play("death")
		await anim.animation_finished
		queue_free()
	if can_move:
		anim.play("run")
		velocity.x = speed
	else:
		velocity.x = 0
	move_and_slide()
	if !$RayCast2D.is_colliding() && is_on_floor():
		flip()

	
func take_damage_from_player(player_damage):
	if take_damage:
		health -= player_damage
		take_damage = false
		can_move = false
		#$Timer.start()
		anim.play("hurt")
		await anim.animation_finished
		can_move = true

func flip():
	scale.x = abs(scale.x) * -1
	facing_right = !facing_right
	if facing_right:
		speed = abs(speed)
	else:
		speed = abs(speed) * -1


func _on_timer_timeout() -> void:
	can_move = true
