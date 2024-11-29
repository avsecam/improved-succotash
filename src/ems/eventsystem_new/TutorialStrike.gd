extends Event

@onready var marble_spirit := $"../../MarbleSpirit_Normal"
@onready var holy_water := $"../../holy_water"
@onready var pillar := $"../../Pillar_A2"

func _on_event_started():
	tutorial_ui.connect("tutorial_done", _on_tutorial_finished)
	await get_tree().create_timer(1).timeout
	marble_spirit.visible = false
	holy_water.visible = false
	pillar.visible = true
	show_event_dialogue()


func _on_tutorial_finished():
	marble_spirit.visible = true
	holy_water.visible = true
	pillar.visible = true
	close_event()
