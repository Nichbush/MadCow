extends Control

var stats: Stats

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	$CenterContainer/Panel/HBoxContainer/HealthButton.pressed.connect(_on_health)
	$CenterContainer/Panel/HBoxContainer/DamageButton.pressed.connect(_on_damage)
	$CenterContainer/Panel/HBoxContainer/DefenseButton.pressed.connect(_on_defense)

func _on_health():
	stats.apply_upgrade(Stats.UpgradeType.HEALTH)
	
	get_tree().paused = false
	queue_free()

func _on_damage():
	stats.apply_upgrade(Stats.UpgradeType.DAMAGE)
	
	get_tree().paused = false
	queue_free()

func _on_defense():
	stats.apply_upgrade(Stats.UpgradeType.DEFENSE)
	
	get_tree().paused = false
	queue_free()
