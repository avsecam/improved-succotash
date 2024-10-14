extends Node3D

@onready var vat_achara_receiver = $VatAcharaReceiver
@onready var onion_eighths = $MainMesh/Onion_Eighths
@onready var garlic_minced = $MainMesh/Garlic_Minced
@onready var peeled_papaya = $MainMesh/PeeledPapaya

signal atchara_prep_complete

var atchara_prep_complete_bool : bool
var onion : bool
var papaya : bool
var garlic : bool


func _ready():
	#vat_achara_receiver.set_monitoring(false)
	atchara_prep_complete_bool = false
	onion = false
	papaya = false
	garlic = false
	
func _process(delta):
	atchara_prep_comp()
	
func atchara_prep_comp():
	if onion and papaya and garlic:
		atchara_prep_complete.emit()

func _on_vat_long_receiver_area_entered(area):
	print("COOKING VAT: "+ area.name)
	if area.name == "GarlicReceiver":
		garlic_minced.visible = true
		garlic = true
		area.get_parent().queue_free()
	elif area.name == "PapayaReceiver":
		peeled_papaya.visible = true
		papaya = true
		area.get_parent().queue_free()
	elif area.name == "OnionReceiver":
		onion_eighths.visible = true
		onion = true
		area.get_parent().queue_free()
	
		
		
