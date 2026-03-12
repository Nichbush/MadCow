extends CharacterBody2D


@export var speed = 150.0
var player = null

func _ready():
	# Wait one frame to make sure all nodes are finished loading
	await get_tree().process_frame
	player = get_tree().get_first_node_in_group("player")
	
	if player:
		print("Found player! Chase initiated.")
	else:
		print("Still can't find 'player' group. Double-check the Player node.")
		
func _physics_process(_delta):
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
	else:
		print("I can't find the player! Check your groups.")
		# Search again just in case the player spawned late
		player = get_tree().get_first_node_in_group("player")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		# Look for the Stats node inside the player
		var stats = body.get_node_or_null("Stats")
		
		if stats:
			# Call your function!
			stats.take_damage(10) # 10 is the damage amount
			var knockback_direction = (global_position - body.global_position).normalized()
			global_position += knockback_direction * 20
			print("Chicken pecked you! Health is now: ", stats.current_health)
