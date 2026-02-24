extends Node
class_name Stats

signal health_changed(current, max)
signal died
signal level_up(new_level)
signal experience_changed(current, required)

var base_stats := {
	"max_health": 100,
	"damage": 10,
	"defense": 0,
}

var current_health : int
var level : int = 1
var experience : int = 0
var experience_required : int = 100


func _ready():
	current_health = get_stat("max_health")
	emit_signal("health_changed", current_health, get_stat("max_health"))


func get_stat(stat_name: String) -> float:
	var value = base_stats.get(stat_name, 0)

	return value

func take_damage(amount: int):
	var reduced = max(amount - get_stat("defense"), 0)
	current_health -= reduced
	current_health = max(current_health, 0)

	emit_signal("health_changed", current_health, get_stat("max_health"))

	if current_health <= 0:
		emit_signal("died")

func heal(amount: int):
	current_health += amount
	current_health = min(current_health, get_stat("max_health"))

	emit_signal("health_changed", current_health, get_stat("max_health"))

func add_experience(amount: int):
	experience += amount
	emit_signal("experience_changed", experience, experience_required)

	while experience >= experience_required:
		experience -= experience_required
		increase_level()

func increase_level():
	level += 1
	experience_required = int(experience_required * 1.5)

	# Example stat growth
	base_stats["max_health"] += 20
	base_stats["damage"] += 5

	current_health = get_stat("max_health")

	emit_signal("level_up", level)
	emit_signal("health_changed", current_health, get_stat("max_health"))
	emit_signal("experience_changed", experience, experience_required)
