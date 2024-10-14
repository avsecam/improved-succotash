extends Node3D

@onready var vat_achara_receiver = $VatAcharaReceiver
@onready var onion_eighths = $MainMesh/Onion_Eighths
@onready var garlic_minced = $MainMesh/Garlic_Minced
@onready var peeled_papaya = $MainMesh/PeeledPapaya

signal add_onion
signal add_garlic
signal add_papaya
signal atchara_complete

var garlic : bool
var onion : bool
var papaya : bool

func _ready():
	garlic = false
	onion = false
	papaya = false
	
func _process(delta):
	if garlic and onion and papaya:
		atchara_complete.emit()

func _on_vat_long_receiver_area_entered(area):
	print("COOKING VAT: "+ area.name)
	if area.name == "GarlicReceiver":
		garlic_minced.visible = true
		add_garlic.emit()
		garlic = true
		area.get_parent().queue_free()
	elif area.name == "PapayaReceiver":
		peeled_papaya.visible = true
		add_papaya.emit()
		papaya = true
		area.get_parent().queue_free()
	elif area.name == "OnionReceiver":
		onion_eighths.visible = true
		add_onion.emit()
		onion = true
		area.get_parent().queue_free()
	
		
		
