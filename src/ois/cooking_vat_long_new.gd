extends ReceiverObj

signal kalabasa_in_pot_receiver
signal kalabasa_soup_complete

@onready var water_clear = $MainMesh/WaterClear
@onready var kalabasa_soup_unmixed = $MainMesh/KalabasaSoupUnmixed
@onready var kalabasa_soup_mixed = $MainMesh/KalabasaSoupMixed
@onready var kalabasa_soup_receiver = $KalabasaSoupReceiver
@onready var kalabasa_slice_receiver = $KalabasaSliceReceiver


func _on_kalabasa_slice_receiver_area_entered(area):
	if area.name == "KalabasaReceiver":
		area.get_parent().queue_free()
		water_clear.visible = false
		kalabasa_soup_unmixed.visible = true
		kalabasa_in_pot_receiver.emit()
		kalabasa_slice_receiver.set_monitoring(false)


func _on_feedback_mix_complete():
	kalabasa_soup_complete.emit()


