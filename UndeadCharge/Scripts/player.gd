extends CharacterBody2D

const SPEED = 70.0

var facingRight = false
var facingLeft = false
var facingUp = false
var facingDown = true

var isAttacking = false

@export var fire_rate : float

var fire_time : float

@onready var animated_sprite = $AnimatedSprite2D

@export var projectile_resource : ProjectileBaseResource = null

func _process(delta):
	if !isAttacking:
		Attack()
	else:
		fire_time += delta
		if fire_time >= fire_rate:
			DisableAttack()

func _physics_process(_delta):

	if !isAttacking:
		Move()

	if !isAttacking:
		Change_Sprite_Position_Idle()
	
	if !isAttacking:
		Change_Sprite_Position_Walk()
	
	move_and_slide()

func Move():
	
	var directionX = Input.get_axis("move_left", "move_right")
	var directionY = Input.get_axis("move_up", "move_down")
	
	if directionX:
		velocity.x = directionX * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if directionY:
		velocity.y = directionY * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

func Change_Sprite_Position_Idle():
	
	if velocity.x > 0:
		facingRight = true
		facingLeft = false
		facingUp = false
		facingDown = false
	elif velocity.x < 0:
		facingLeft = true
		facingRight = false
		facingUp = false
		facingDown = false
	
	if velocity.y > 0:
		facingRight = false
		facingLeft = false
		facingUp = false
		facingDown = true
	elif velocity.y < 0:
		facingRight = false
		facingLeft = false
		facingDown = false
		facingUp = true

	if facingUp and velocity.x == 0 and velocity.y == 0:
		animated_sprite.play("Idle_Up")
	
	if facingDown and velocity.x == 0 and velocity.y == 0:
		animated_sprite.play("Idle_Down")
	
	if facingRight and velocity.x == 0 and velocity.y == 0:
		animated_sprite.play("Idle_Right")
		
	if facingLeft and velocity.x == 0 and velocity.y == 0:
		animated_sprite.play("Idle_Left")

func Change_Sprite_Position_Walk():
	
	if velocity.x > 0 and velocity.y == 0:
		animated_sprite.play("Walk_Right")
	
	if velocity.x < 0 and velocity.y == 0:
		animated_sprite.play("Walk_Left")
	
	if velocity.y > 0 and velocity.x == 0:
		animated_sprite.play("Walk_Down")
	
	if velocity.y < 0 and velocity.x == 0:
		animated_sprite.play("Walk_Up")
	
	if velocity.x > 0 and velocity.y < 0:
		animated_sprite.play("Walk_Up")
	
	if velocity.x < 0 and velocity.y < 0:
		animated_sprite.play("Walk_Up")
	
	if velocity.x < 0 and velocity.y > 0:
		animated_sprite.play("Walk_Down")
	
	if velocity.x > 0 and velocity.y > 0:
		animated_sprite.play("Walk_Down")

func Attack():
	
	if Input.is_action_just_pressed("Attack"):
		isAttacking = true
		velocity.x = 0
		velocity.y = 0
		ShootProjectile()
		if facingUp:
			animated_sprite.play("Attack_Up")
		if facingDown:
			animated_sprite.play("Attack_Down")
		if facingRight:
			animated_sprite.play("Attack_Right")
		if facingLeft:
			animated_sprite.play("Attack_Left")

# AnimationPlayer function call.
func DisableAttack():
	isAttacking = false
	fire_time = 0.0

func ShootProjectile():
	
	if facingUp:
		SignalBus.Emit_Fire(projectile_resource, Vector2(position.x, position.y - 6), Vector2.UP)
	if facingDown:
		SignalBus.Emit_Fire(projectile_resource, Vector2(position.x, position.y + 6), Vector2.DOWN)
	if facingRight:
		SignalBus.Emit_Fire(projectile_resource, Vector2(position.x + 6, position.y), Vector2.RIGHT)
	if facingLeft:
		SignalBus.Emit_Fire(projectile_resource, Vector2(position.x - 6, position.y), Vector2.LEFT)
