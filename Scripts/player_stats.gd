extends CharacterBody2D

@onready var stats : Stats = $Stats

func _ready():
	stats.level_up.connect(_on_level_up)
	stats.died.connect(_on_died)
	stats.level_up.connect(_on_level_up)

func attack(target):
	target.stats.take_damage(stats.get_stat("damage"))

func _on_died():
	print("Player died")

func _on_level_up(new_level):
	get_tree().paused = true

	var ui = preload("res://Upgrade.tscn").instantiate()
	ui.stats = stats
	add_child(ui)
