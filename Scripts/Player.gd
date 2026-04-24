extends CharacterBody2D

class_name Player

@export var speed = 250
@export var tile_layer : TileMapLayer
@export var bullet_scene : PackedScene


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
@onready var health_bar = $"../CanvasLayer/HealthBar"
@onready var experience_bar = $"../CanvasLayer/ExperienceBar"

func _ready():
	stats.level_up.connect(_on_level_up)
	health_bar.set_stats(stats)
	if tile_layer == null:
		return
		
	await get_tree().process_frame
	
func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	
	# NEW: Shooting logic
	if Input.is_action_just_pressed("fire"): # Or "shoot" if you defined it
		shoot()
		
func shoot():
	if bullet_scene:
		var bullet = bullet_scene.instantiate()
		
		# Use global_position to avoid math errors if player is parented to something else
		bullet.global_position = global_position
		
		# Make it face the mouse so it actually has a direction to fly in
		bullet.look_at(get_global_mouse_position())
		
		# Add it to the level so it moves independently of the player
		get_parent().add_child(bullet)
	else:
		print("Don't forget to drag the bullet.tscn into the Inspector!")
	
func _physics_process(_delta: float):
	get_input()
	move_and_slide()
	
	#Map wrapping logic
	position.x = wrapf(position.x, min_x - buffer, max_x + buffer)
	position.y = wrapf(position.y, min_y - buffer, max_y + buffer)

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		stats.increase_level()

func _on_level_up(new_level):
	get_tree().paused = true

	var ui = preload("res://Upgrade.tscn").instantiate()
	ui.stats = stats
	add_child(ui)
