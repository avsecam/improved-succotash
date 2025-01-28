extends Event
@onready var shotgun = $"../../shotgun"
@onready var howitzer_actual = $"../../Howitzer"
@onready var distortion_crystal = $"../../DistortionCrystal10"


func _on_event_started():
	howitzer_actual.visible = true
	shotgun.queue_free()
	play_event_audio()
	await event_audio_done
	close_event()
