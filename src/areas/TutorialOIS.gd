extends Event

@onready var marble_spirit := $"../../MarbleSpirit_Normal"
@onready var cat := $"../../Cat"

func _on_event_started():
	tutorial_ui.connect("tutorial_done", _on_tutorial_finished)
	await get_tree().create_timer(1).timeout
	marble_spirit.visible = false
	cat.visible = false
	show_event_dialogue()


func _on_tutorial_finished():
	marble_spirit.visible = true
	cat.visible = true
	close_event()
