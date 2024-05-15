extends CharacterBody2D

var wave_manager : WaveManager
var game_manager : GameManager

@onready var animated_sprite = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer
@onready var death_sound = $DeathSound
@onready var area_2d = $Area2D

@export var speed : int
@export var maximumSpeed : int
@export var speedModifier : int

var currentSpeed : int

var isFacingRight = false
var isFacingLeft = false
var isFacingUp = false
var isFacingDown = false
var isDead = false

var directionX = 0
var directionY = 0

func SetSpeed():
	currentSpeed = speed + (wave_manager.currentWave + speedModifier)
	if(currentSpeed > maximumSpeed):
		currentSpeed = maximumSpeed

func _on_area_2d_area_entered(area):
	if area.is_in_group("Projectile") and collision_layer == 1:
		isDead = true
		area_2d.collision_layer = 2
		collision_layer = 2
		animated_sprite.play("Dead")
		animation_player.play("Enemy_Dead")
		game_manager.DecrementEnemyCount()
	elif area.is_in_group("GameOver"):
		game_manager.GameOver()

#AnimationPlayer event
func DestroyEnemy():
	queue_free()

func _physics_process(_delta):
	if !isDead:
		Move()
		Change_Walk_Sprite()
		move_and_slide()

func Move():
	if isFacingDown and !isFacingLeft and !isFacingUp and !isFacingRight:
		directionX = 0
		directionY = 1
	
	if !isFacingDown and isFacingLeft and !isFacingUp and !isFacingRight:
		directionX = -1
		directionY = 0
	
	if !isFacingDown and !isFacingLeft and isFacingUp and !isFacingRight:
		directionX = 0
		directionY = -1
	
	if !isFacingDown and !isFacingLeft and !isFacingUp and isFacingRight:
		directionX = 1
		directionY = 0
	
	if isFacingRight or isFacingLeft:
		if directionX:
			velocity.x = directionX * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
	
	if isFacingUp or isFacingDown:
		if directionY:
			velocity.y = directionY * speed
		else:
			velocity.y = move_toward(velocity.y, 0, speed)

func Change_Walk_Sprite():
	
	if isFacingUp and !isFacingDown and !isFacingRight and !isFacingLeft:
		animated_sprite.play("Walk_Up")
	
	if !isFacingUp and isFacingDown and !isFacingRight and !isFacingLeft:
		animated_sprite.play("Walk_Down")
	
	if !isFacingUp and !isFacingDown and isFacingRight and !isFacingLeft:
		animated_sprite.play("Walk_Right")
	
	if !isFacingUp and !isFacingDown and !isFacingRight and isFacingLeft:
		animated_sprite.play("Walk_Left")

func PlayDeathSound():
	death_sound.play()
