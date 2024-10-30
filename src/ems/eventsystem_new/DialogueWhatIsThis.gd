extends Event

@onready var distortion := $"../../MagicalDistortion/GPUParticles3D"

func _on_event_started():
	distortion.emitting = true
	play_event_audio()
	await event_audio_done
	quests.add_active_quest("QuestDestroyTheDistortionCrystal")
	close_event()

