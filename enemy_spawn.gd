extends Node2D

@export var enemy_scene : PackedScene # Drag your Enemy.tscn here in Inspector
@export var spawn_delay = 5.0

@onready var spawn_timer = $Timer

func _ready():
	
	spawn_timer.wait_time = spawn_delay
	spawn_timer.start()

func _on_timer_timeout():
	print("Timer finished! Attempting to spawn...") 
	spawn_enemy()

func spawn_enemy():
	print("--- Attempting Spawn ---")
	
	if enemy_scene == null:
		return # Stops here if the slot is empty
		
	var children = get_children()
	print("Found " + str(children.size()) + " total children.")
	
	var points = children.filter(func(node): return node is Marker2D)
	print("Found " + str(points.size()) + " Marker2D points.")
	
	if points.size() > 0:
		var random_point = points.pick_random()
		var enemy = enemy_scene.instantiate()
		enemy.global_position = random_point.global_position
		get_tree().current_scene.add_child(enemy)
		print("SUCCESS: Enemy spawned at ", enemy.global_position)
	else:
		print("ERROR: No Marker2Ds found under this node!")
