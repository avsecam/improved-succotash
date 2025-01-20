extends XRToolsPickable

@onready var pistol_sound = $pistol_sound

func _on_action_pressed(pickable):
	if pickable.event_type == XRToolsPointerEvent.Type.PRESSED:
		AudioHandler.play_sfx("Char_Cat_Meow1", pistol_sound)
