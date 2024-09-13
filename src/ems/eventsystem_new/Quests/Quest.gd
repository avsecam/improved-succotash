extends Node
class_name Quest

signal quest_started()
signal quest_ended()

var quest_name : String
var quest_description : Dictionary
var quest_completion_requirements : Array
@export_range (0.0, 1.0) var quest_progress : float


func _ready():
	quest_ended.connect(get_parent().update_active_quests)
	quest_progress = 0.0

func initialize_quest() -> void:
	quest_name = name
	if Events.quest_library.has(quest_name):
		quest_description = Events.quest_library[quest_name]["Quest_Description"]
		quest_completion_requirements = Events.quest_library[quest_name]["Quest_Completion_Requirements"]
		print("Quest " + quest_name + " Started")
	else:
		print("Quest " + quest_name + " Not Found")
	
	update_quest()

func update_quest() -> void:
	var iterator : int = 0
	for reqs in quest_completion_requirements:
		if reqs in Events.finished_events:
			iterator += 1
	
	print(iterator)
	print(quest_completion_requirements.size())
	quest_progress = float(iterator) / float(quest_completion_requirements.size())
	print(quest_progress)
	print(quest_description["Name"] + " " + str(snapped((quest_progress * 100), 0.01)) + "% Complete")
	if quest_progress >= 1.0:
		end_quest()


func end_quest() -> void:
	Events.finished_events.append(quest_name + "_Done")
	queue_free()
	print(Events.finished_events)
	await tree_exited
	emit_signal("quest_ended")