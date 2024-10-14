extends Feedback

@onready var papaya_peeled = $"../MainMesh/Papaya_Peeled"
@onready var papaya_grated = $"../MainMesh/Papaya_Grated"

	
var progress_track_papaya : float = 0
	
	
func papaya_receiver_comp_workaround():
	papaya_peeled.visible = false
	papaya_grated.visible = true
	self.queue_free()

func _on_papaya_receiver_action_in_progress(requirement, total_progress):
	var percentage = progress_track_papaya
	
	progress_track_papaya += 0.05
	
	if progress_track_papaya >= 1:
		print("Call papaya workaround")
		papaya_receiver_comp_workaround()
	
	print("Papaya grate progress: " + str(percentage*100)+"%")
