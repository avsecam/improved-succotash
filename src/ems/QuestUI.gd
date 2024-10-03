extends VBoxContainer
class_name QuestUI

@onready var quest_name_label := $QuestName
@onready var quest_actions_container := $MarginContainer/QuestActions
@export var quest_action_label := preload("res://src/ems/QuestActionLabel.tscn")

var quest_name : String
var quest_actions : Dictionary

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func initialize_quest_ui(qn : String, qa : Dictionary) -> void:
	quest_name = qn
	quest_actions = qa
	
	quest_name_label.set_text(Events.quest_library[quest_name]["Quest_Description"]["Name"])
	
	for acts in quest_actions:
		var new_action = quest_action_label.instantiate()
		if quest_actions[acts].size() > 1:
			new_action.set_text("- " + acts + " : 0/" + str(quest_actions[acts].size()))
		else:
			new_action.set_text("- " + acts)
		print("added quest")
		quest_actions_container.add_child(new_action)


func update_quest_ui() -> void:
	for child in quest_actions_container.get_children():
		child.queue_free()
	
	for acts in quest_actions:
		var new_action = quest_action_label.instantiate()
		if quest_actions[acts].size() > 1:
			var iterator : int = 0
			for a in quest_actions[acts]:
				if a in Events.finished_events:
					iterator += 1
			if iterator < quest_actions[acts].size():
				new_action.set_text("- " + acts + " : " + str(iterator) + "/" + str(quest_actions[acts].size()))
			elif iterator >= quest_actions[acts].size():
				new_action.set_text("- " + acts + " : ✓")
		else:
			if quest_actions[acts][0] in Events.finished_events:
				new_action.set_text("- " + acts + " : ✓")
			else: 
				new_action.set_text("- " + acts)
		quest_actions_container.add_child(new_action)

