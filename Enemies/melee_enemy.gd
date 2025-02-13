extends CharacterBody2D
class_name MeleeEnemy


var speed: int = 100
var facing_right: bool = true
@onready var detect_ground : RayCast2D = $GroundDetect
var can_move : bool = true
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
var take_damage : bool = false
@export var health : int
var damage_taken : int
var damage: int = 10
var is_attacking: bool = false
@onready var attack_raycast: RayCast2D = $Attack

func _ready() -> void:
	pass

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
	melee_attack()
	raycast_range_detection()
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
	
func melee_attack():
	if is_attacking:
		$Hitbox/CollisionShape2D.disabled = false
	else:
		$Hitbox/CollisionShape2D.disabled = true

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.player_take_damage = true
		can_move = false
		anim.play("attack")
		body.take_damage(damage)
		$Attack.enabled = false
		await anim.animation_finished
		body.player_take_damage = false
		can_move = true
		$Timer.start()

func raycast_range_detection():
	if attack_raycast.is_colliding():
		is_attacking = true
	else:
		is_attacking = false
		


func _on_timer_timeout() -> void:
	$Attack.enabled = true
