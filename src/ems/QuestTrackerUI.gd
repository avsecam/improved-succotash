extends Control

@onready var quest_container := $QuestTracker/VBoxContainer
@onready var quest_indicator := $CenterContainer/VBoxContainer/QuestIndicator
@onready var quest_description := $CenterContainer/VBoxContainer/QuestDescription

var quest = preload("res://src/ems/QuestUI.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	quest_indicator.visible = false
	quest_description.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _add_quest(quest_name) -> void:
	flash_quest_start(quest_name)
	var new_quest = quest.instantiate()
	quest_container.add_child(new_quest)
	new_quest.initialize_quest_ui(quest_name, Events.quest_library[quest_name]["Quest_Completion_Tracker"])


func _remove_quest(quest_name) -> void:
	for quest in quest_container.get_children():
		if quest.quest_name == quest_name:
			await get_tree().create_timer(1).timeout
			print("Ending " + quest_name)
			flash_quest_end(quest_name)
			quest.queue_free()

func _update_quest_progress(quest_name) -> void:
	print("updating quest progress")
	for quest in quest_container.get_children():
		quest.update_quest_ui()


func flash_quest_start(quest_name) -> void:
	quest_indicator.set_text("Quest Started: " + Events.quest_library[quest_name]["Quest_Description"]["Name"])
	quest_description.set_text(Events.quest_library[quest_name]["Quest_Description"]["Description"])
	quest_indicator.visible = true
	quest_description.visible = true
	await get_tree().create_timer(2).timeout
	quest_indicator.visible = false
	quest_description.visible = false


func flash_quest_end(quest_name) -> void:
	quest_indicator.set_text("Quest Finished: " + Events.quest_library[quest_name]["Quest_Description"]["Name"])
	quest_indicator.visible = true
	await get_tree().create_timer(2).timeout
	quest_indicator.visible = false
