extends Label

	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_label()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func update_label():
	$".".text = str($"..".current)
