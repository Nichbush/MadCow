extends Timer

var time_label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$".".start(300)
	time_label = int($".".time_left)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	time_label = int($".".time_left)
	$Word_Time_Label.update_label()
	
