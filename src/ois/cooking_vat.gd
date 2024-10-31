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

var papaya_grated_bool : bool
var onion_sliced_bool : bool
var garlic_sliced_bool : bool

var floattrackbool : bool


func _ready():
	garlic = false
	onion = false
	papaya = false
	papaya_grated_bool = false
	onion_sliced_bool = false
	garlic_sliced_bool = false
	floattrack = 0
	
func _process(delta):
	if garlic and onion and papaya:
		atchara_complete.emit()
	if floattrack >= 100:
		if !floattrackbool:
			floattrackbool = true
			progress_view.progress_complete_anim()

func _on_vat_long_receiver_area_entered(area):
	print("COOKING VAT: "+ area.name)

	if !progress_view.visible:
		progress_view.visible = true
		
	if area.name == "GarlicReceiver":
		if garlic_sliced_bool:
			garlic_minced.visible = true
			add_garlic.emit()
			garlic = true
			area.get_parent().queue_free()
	elif area.name == "PapayaReceiver":
		if papaya_grated_bool:
			peeled_papaya.visible = true
			add_papaya.emit()
			papaya = true
			area.get_parent().queue_free()
	elif area.name == "OnionReceiver":
		if onion_sliced_bool:
			onion_eighths.visible = true
			add_onion.emit()
			onion = true
			area.get_parent().queue_free()
		
	if floattrack >= 100:
		progress_view.progress_complete_anim()
		pass	
	progress_view.change_progress_value(floattrack)
	
func _on_atchara_garlic_added_event_finished():
	garlic_minced.visible = true
	floattrack += 33.4
	garlic = true
	progress_view.change_progress_value(floattrack)
	

func _on_atchara_papaya_added_event_finished():
	peeled_papaya.visible = true
	floattrack += 33.4
	papaya = true
	progress_view.change_progress_value(floattrack)

func _on_atchara_onion_added_event_finished():
	onion_eighths.visible = true
	floattrack += 33.4
	onion = true
	progress_view.change_progress_value(floattrack)

func _on_atchara_complete_added_event_finished():
	onion_eighths.visible = true
	peeled_papaya.visible = true
	garlic_minced.visible = true

func _on_papaya_grated_event_finished():
	papaya_grated_bool = true

func _on_onion_sliced_event_finished():
	onion_sliced_bool = true

func _on_garlic_sliced_event_finished():
	garlic_sliced_bool = true
	
	
		
		
