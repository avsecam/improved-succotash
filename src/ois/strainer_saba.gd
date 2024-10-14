extends XRToolsPickable

@onready var saba_bananas_fried = $MainMesh/SabaBananas_Fried
@onready var strainer_actor = $StrainerActor



func _on_strainer_actor_area_entered(area):
	if area.name == "StrainerReceiver":
		saba_bananas_fried.visible = true
