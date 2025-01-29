extends Event
@onready var shotgun = $"../../shotgun"
@onready var howitzer_actual = $"../../Howitzer"
@onready var distortion_crystal = $"../../DistortionCrystal10"
@onready var distortion_light = $"../../DistortionLight"


func _on_event_started():
	howitzer_actual.visible = true
	shotgun.queue_free()
	distortion_crystal.visible = true
	distortion_light.visible = true
	play_event_audio()
	await event_audio_done
	close_event()
