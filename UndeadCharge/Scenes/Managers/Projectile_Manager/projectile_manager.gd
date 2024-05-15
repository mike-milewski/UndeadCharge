class_name ProjectileManager
extends Node2D

@onready var base_bullet_scene : PackedScene = preload("res://Scenes/Bullet/bullet.tscn")

func _ready():
	SignalBus.connect("Fire", build_projectile)

func build_projectile(resource : ProjectileBaseResource, location : Vector2, direction : Vector2) -> void:
	var new_bullet = base_bullet_scene.instantiate() as bullet
	
	new_bullet.sprite_2d = resource.projectile_sprite
	
	new_bullet.position = location
	new_bullet.direction = (direction - global_position.normalized())
	new_bullet.rotation = new_bullet.direction.angle()
	new_bullet.speed = resource.projectile_speed
	
	fire_projectile(new_bullet)

func fire_projectile(_bullet : bullet) -> void:
	var projectile_container = NodeExtentions.get_projectile_container()
	
	if projectile_container == null:
		return
	
	projectile_container.add_child(_bullet)
