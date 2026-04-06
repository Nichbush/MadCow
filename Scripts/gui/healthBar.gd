extends TextureProgressBar

signal label_changed()

var stats : Stats
var current
var max

func set_stats(s: Stats):
	stats = s
	stats.health_changed.connect(update)
	update()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#recieve update signal
	stats.health_changed.connect(update)
	update()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
#update healthbar
func update():
	current = stats.current_health
	max = stats.max_health
	value = current * 100 / max
	$Health_Label.update_label()
