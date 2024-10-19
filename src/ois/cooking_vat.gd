extends Node3D

@onready var vat_achara_receiver = $VatAcharaReceiver
@onready var onion_eighths = $MainMesh/Onion_Eighths
@onready var garlic_minced = $MainMesh/Garlic_Minced
@onready var peeled_papaya = $MainMesh/PeeledPapaya
@onready var progress_view = $"Progress View"

signal add_onion
signal add_garlic
signal add_papaya
signal atchara_complete

var garlic : bool
var onion : bool
var papaya : bool
var floattrack : float

func _ready():
	garlic = false
	onion = false
	papaya = false
	floattrack = 0
	
func _process(delta):
	if garlic and onion and papaya:
		atchara_complete.emit()

func _on_vat_long_receiver_area_entered(area):
	print("COOKING VAT: "+ area.name)

	if !progress_view.visible:
		progress_view.visible = true
		
	
	if area.name == "GarlicReceiver":
		garlic_minced.visible = true
		add_garlic.emit()
		garlic = true
		area.get_parent().queue_free()
		floattrack += 33.4
	elif area.name == "PapayaReceiver":
		peeled_papaya.visible = true
		add_papaya.emit()
		papaya = true
		area.get_parent().queue_free()
		floattrack += 33.4
	elif area.name == "OnionReceiver":
		onion_eighths.visible = true
		add_onion.emit()
		onion = true
		area.get_parent().queue_free()
		floattrack += 33.4
		
	if floattrack >= 100:
		progress_view.progress_complete_anim()
		pass
	progress_view.change_progress_value(floattrack)
	
		
		
