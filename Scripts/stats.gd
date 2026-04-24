extends Node
class_name Stats

signal health_changed()
signal died
signal level_up(new_level)
signal experience_changed()

var max_health : int = 100
var current_health : int
@export var damage : int = 10
var defense : int = 0

var level : int = 1
var experience : int = 0
var experience_required : int = 100


func _ready():
	current_health = max_health
	emit_signal("health_changed")


func take_damage(amount: int):
	var reduced = max(amount - defense, 0)
	current_health -= reduced
	current_health = max(current_health, 0)
	emit_signal("health_changed")

	if current_health <= 0:
		emit_signal("died")


func heal(amount: int):
	current_health += amount
	current_health = min(current_health, max_health)

	emit_signal("health_changed")


func add_experience(amount: int):
	experience += amount
	emit_signal("experience_changed")

	while experience >= experience_required:
		experience -= experience_required
		increase_level()


func increase_level():
	level += 1
	print("LEVEL UP TRIGGERED")
	experience_required = int(experience_required * 1.5)

	current_health = max_health

	emit_signal("level_up", level)
	emit_signal("health_changed")
	emit_signal("experience_changed")

enum UpgradeType {
	HEALTH,
	DAMAGE,
	DEFENSE
}

func apply_upgrade(type: int):
	match type:
		UpgradeType.HEALTH:
			max_health += 20
			current_health = max_health

		UpgradeType.DAMAGE:
			damage += 5

		UpgradeType.DEFENSE:
			defense += 2
	emit_signal("health_changed")
