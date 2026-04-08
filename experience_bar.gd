
extends TextureProgressBar


var stats : Stats
var current
var next

func set_stats(s: Stats):
	stats = s
	stats.experience_changed.connect(update)
	update()


# Called when the node enters the scene tree for the first time.
func _ready():
	if current == null:
		current = 0
		$Experience_Label.update_label()
	if stats != null:
		stats.experience_changed.connect(update)
		update()


#update healthbar
func update():
	current = stats.experience
	next = stats.experience_required
	value = current * 100 / next
	$Experience_Label.update_label()
