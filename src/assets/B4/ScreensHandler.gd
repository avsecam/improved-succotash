extends Node

@onready var screen1_text = $Screen1/Viewport2Din3D/Viewport/NumPadUI/VBoxContainer/ColorRect/NumpadView
@onready var screen2_text = $Screen2/Viewport2Din3D/Viewport/NumPadUI/VBoxContainer/ColorRect/NumpadView
@onready var screen3_text = $Screen3/Viewport2Din3D/Viewport/NumPadUI/VBoxContainer/ColorRect/NumpadView
@onready var left_2_jpg = $"../Teleporters/Left2_jpg"

# Called when the node enters the scene tree for the first time.
func _ready():
	screen1_text.text = "[center]FREE"
	screen2_text.text = "[center]THEM"
	screen3_text.text = "[center]PLEASE"
	if Events.finished_events.has("QuestLookAtTheButterflies_Done"):
		screen1_text.text = "[center]E"
		screen2_text.text = "[center]N"
		screen3_text.text = "[center]S"
		left_2_jpg.enabled = false
		left_2_jpg.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
