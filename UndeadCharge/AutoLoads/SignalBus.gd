extends Node

signal Fire(resource : ProjectileBaseResource, location : Vector2, direction : Vector2)

func Emit_Fire(resource : ProjectileBaseResource, location : Vector2, direction : Vector2):
	Fire.emit(resource, location, direction)
