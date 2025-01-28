extends XRToolsInteractableArea
@onready var howitzer_round = $"../../howitzer_round"
@onready var round_slot = $"../Howitzer_Round_slot"
signal loaded_howitzer
signal fire_howitzer
@onready var dark_crystal = $"../../DistortionCrystal10/MainMesh/Dark_Crystal"
var loaded = false

func _on_body_entered(body):
	if body == howitzer_round:
		howitzer_round.queue_free()
		round_slot.visible = true
		loaded_howitzer.emit()
		loaded = true


func _on_pointer_event(event):
	if event.event_type == XRToolsPointerEvent.Type.PRESSED and loaded:
		AudioHandler.play_sfx("C_Howitzer", null)
		round_slot.visible = false
		loaded = false
		await get_tree().create_timer(2).timeout
		dark_crystal.anim.play("smash")
		AudioHandler.play_sfx("A_CrystalShatter", $"../AudioStreamPlayer3D")
		await dark_crystal.anim.animation_finished
		fire_howitzer.emit()
		dark_crystal.get_parent().get_parent().queue_free()
