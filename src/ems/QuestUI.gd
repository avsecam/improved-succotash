extends VBoxContainer
class_name QuestUI

@onready var quest_name_label := $QuestName
@onready var quest_actions_container := $MarginContainer/QuestActions

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
		var new_action = Label.new()
		if quest_actions[acts].size() > 1:
			new_action.set_text("- " + acts + str(quest_actions[acts].size() + "x"))
		else:
			new_action.set_text("- " + acts)
		print("added quest")
		quest_actions_container.add_child(new_action)

