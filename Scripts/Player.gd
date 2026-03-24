extends CharacterBody2D

class_name Player

@export var speed = 250
@export var tile_layer : TileMapLayer

var min_x = 0
var min_y = 0

var map_width = 1224
var map_height = 696

var buffer = 32

#Max map coordinates calcualtion
@onready var max_x = min_x + map_width
@onready var max_y = min_y + map_height

#animation onready
@onready var animator = $AnimatedSprite2D

#health bar
@export var maxHealth = 100
@onready var currentHealth: int = maxHealth
@onready var stats = $Stats
@onready var health_bar = $"../CanvasLayer/TextureProgressBar"

func _ready():
	health_bar.set_stats(stats)
	if tile_layer == null:
		return
		
	await get_tree().process_frame
	
func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	
func _physics_process(_delta: float):
	get_input()
	move_and_slide()
	
	#Map wrapping logic
	position.x = wrapf(position.x, min_x - buffer, max_x + buffer)
	position.y = wrapf(position.y, min_y - buffer, max_y + buffer)
