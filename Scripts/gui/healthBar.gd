extends TextureProgressBar


var stats : Stats
var current
var max_health

func set_stats(s: Stats):
	stats = s
	stats.health_changed.connect(update)
	update()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#recieve update signal
	update()

	
#update healthbar
func update():
	current = stats.current_health
	max_health = stats.max_health
	value = current * 100 / max_health
	$Health_Label.update_label()
