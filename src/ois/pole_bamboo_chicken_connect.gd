extends XRToolsPickable

signal chicken_connect
signal chicken_connect_2

@onready var chicken_1 = $Chicken1
@onready var chicken_2 = $Chicken2

var chicken_b1 : bool
var chicken_b2 : bool

func _on_chicken_1_has_picked_up(what):
	chicken_1.enabled = false
	what.disable_collision()
	chicken_connect.emit()
	chicken_b1 = true

func _on_chicken_2_has_picked_up(what):
	chicken_2.enabled = false
	what.disable_collision()
	chicken_connect_2.emit()
	chicken_b2 = true

	
func _on_associated_event_finished():
	self.visible = false


