extends Feedback

@onready var papaya_peeled = $"../MainMesh/Papaya_Peeled"
@onready var papaya_grated = $"../MainMesh/Papaya_Grated"
@onready var progress_view = $"../Progress View"

	
var progress_track_papaya : float = 0

signal papaya_grated_workaround

func papaya_receiver_comp_workaround():
	papaya_peeled.visible = false
	papaya_grated.visible = true
	papaya_grated_workaround.emit()
	progress_view.progress_complete_anim()
	self.queue_free()

func _on_papaya_receiver_action_in_progress(requirement, total_progress):
	var percentage = progress_track_papaya
	
	progress_track_papaya += 0.05
	
	if progress_track_papaya >= 1:
		print("Call papaya workaround")
		papaya_receiver_comp_workaround()
	
	print("Papaya grate progress: " + str(percentage*100)+"%")
	
	if progress_view.visible == false:
		progress_view.visible = true
	progress_view.change_progress_value(percentage*100)
