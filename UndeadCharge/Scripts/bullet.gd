class_name bullet
extends CharacterBody2D

@onready var sprite_2d = $Sprite2D
@onready var visible_notifier = $VisibleNotifier
@onready var timer = $Timer
@onready var projectile_sound = $ProjectileSound

var direction : Vector2 = Vector2.RIGHT
var speed : float = 0.0

func _ready():
	projectile_sound.play()

func _physics_process(delta):
	Move(delta)

func Move(delta : float) -> void:
	move_and_collide(direction * speed * delta)

func _on_visible_notifier_screen_exited():
	timer.start(0.8)

func _on_timer_timeout():
	queue_free()

func _on_area_2d_area_entered(area):
	if area.is_in_group("Enemy"):
		queue_free()
