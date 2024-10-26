extends Event


# Called when the node enters the scene tree for the first time.
@onready var roasting_pit = $"../../Roasting Pit/pole_bamboo_chicken_roastpit"


func _on_pole_bamboo_chicken_new_pole_inserted_inventory():
	roasting_pit.visible = true
	quests.add_active_quest("QuestKalabasaSoup")
	close_event()
	
