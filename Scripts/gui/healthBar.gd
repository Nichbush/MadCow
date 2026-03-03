extends TextureProgressBar

var stats : Stats

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
	value = stats.current_health * 100 / stats.max_health
