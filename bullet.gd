# bullet.gd
extends Area2D

@export var speed = 600

func _physics_process(delta):
	position += transform.x * speed * delta # Moves the bullet forward relative to its rotation

func _on_body_entered(body):
	# If the thing we hit is the player, do nothing and don't disappear
	if body is Player:
		return
	if body.has_method("take_damage"):
		body.take_damage(10)
	queue_free() # Destroy bullet on impact
