extends Control
class_name SaveFileSlot

@onready var save_data_information := $MarginContainer/SaveDataInformation
@onready var no_save_data_label := $MarginContainer/NoSaveDataLabel
@onready var save_file_label := $MarginContainer/SaveDataInformation/VBoxContainer/SaveFileLabel
@onready var current_location_label := $MarginContainer/SaveDataInformation/VBoxContainer/CurrentLocation
@onready var quests_finished_label := $MarginContainer/SaveDataInformation/VBoxContainer/QuestsFinished
@onready var save_image := $MarginContainer/SaveDataInformation/CenterContainer/TextureRect

@export var slot_number: int = 0

var has_savedata := false

func _ready():
	no_save_data()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func no_save_data() -> void:
	save_data_information.visible = false
	no_save_data_label.visible = true


func show_savedata() -> void:
	save_data_information.visible = true
	no_save_data_label.visible = false
