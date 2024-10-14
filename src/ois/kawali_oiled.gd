extends Node3D

@onready var oil_receiver = $OilReceiver
@onready var saba_bananas = $MainMesh/SabaBananas
@onready var strainer_receiver = $StrainerReceiver
@onready var saba_bananas_fried = $MainMesh/SabaBananas_Fried


signal saba_being_fried
signal saba_ready


func _ready():
	strainer_receiver.set_monitoring(false)
	
func _process(delta):
	pass
	
func _on_oil_receiver_area_entered(area):
	print("Kawali with Oil "+ area.name)
	if area.name == "SabaReceiver":
		saba_bananas.visible = true
		area.get_parent().queue_free()
		saba_being_fried.emit()
		await get_tree().create_timer(10.0).timeout
		print("Enable strainer receiver on kawali.")
		saba_bananas_fried.visible = true
		saba_bananas.visible = false
		saba_ready.emit()
		strainer_receiver.set_monitoring(true)


func _on_strainer_receiver_area_entered(area):
	if area.name == "StrainerActor":
		saba_bananas_fried.visible = false
