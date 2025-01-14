extends Node

@onready var screen1_text = $Screen1/Viewport2Din3D/Viewport/NumPadUI/VBoxContainer/ColorRect/NumpadView
@onready var screen2_text = $Screen2/Viewport2Din3D/Viewport/NumPadUI/VBoxContainer/ColorRect/NumpadView
@onready var screen3_text = $Screen3/Viewport2Din3D/Viewport/NumPadUI/VBoxContainer/ColorRect/NumpadView

# Called when the node enters the scene tree for the first time.
func _ready():
	screen1_text.text = "[center]FREE"
	screen2_text.text = "[center]THE"
	screen3_text.text = "[center]BUTTERFLIES"
	if Events.finished_events.has("QuestLookAtTheButterflies_Done"):
		screen1_text.text = "[center]E"
		screen2_text.text = "[center]N"
		screen3_text.text = "[center]S"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
