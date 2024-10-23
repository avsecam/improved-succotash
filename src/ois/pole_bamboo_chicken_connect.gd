extends XRToolsPickable

signal chicken_connect
signal chicken_connect_2
signal pole_inserted_inventory

@onready var chicken_1 = $Chicken1
@onready var chicken_2 = $Chicken2

var chicken_b1 : bool
var chicken_b2 : bool

func _on_chicken_1_has_picked_up(what):
	chicken_1.enabled = false
	what.disable_collision()
	chicken_connect.emit()
	chicken_b1 = true
	
	if chicken_b2:
		all_chicken_complete()


func _on_chicken_2_has_picked_up(what):
	chicken_2.enabled = false
	what.disable_collision()
	chicken_connect_2.emit()
	chicken_b2 = true
	
	if chicken_b1:
		all_chicken_complete()

func all_chicken_complete():
	await get_tree().create_timer(3).timeout
	pole_inserted_inventory.emit()
	chicken_2.picked_up_object.queue_free()
	chicken_1.picked_up_object.queue_free()
	self.visible = false
	self.enabled = false
