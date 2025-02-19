extends Node3D

@export var questName:String
@onready var quests = get_tree().get_root().get_node("/root/Demo/Quests")

func _ready():
	if questName + "_Done" not in Events.finished_events:
		quests.add_active_quest(questName)
		queue_free()
