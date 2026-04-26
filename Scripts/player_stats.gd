extends CharacterBody2D

@onready var stats : Stats = $Stats

func _ready():
	stats.died.connect(_on_died)

func attack(target):
	target.stats.take_damage(stats.get_stat("damage"))

func _on_died():
	print("Player died")
