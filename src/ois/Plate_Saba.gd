extends Node3D

signal saba_plated

@onready var saba_bananas_fried = $MainMesh/SabaBananas_Fried

func _on_plate_receiver_area_entered(area):
	if area.name == "StrainerActor" and area.get_parent().saba_check:
		saba_bananas_fried.visible = true
		saba_plated.emit()
