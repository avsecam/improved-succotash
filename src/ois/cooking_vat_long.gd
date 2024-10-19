extends WipeAction

@onready var water_clear = $MainMesh/WaterClear
@onready var kalabasa_soup_unmixed = $MainMesh/KalabasaSoupUnmixed
@onready var kalabasa_soup_mixed = $MainMesh/KalabasaSoupMixed
@onready var vat_long_receiver = $VatLongReceiver
@onready var progress_view = $"Progress View"

signal kalabasa_in_pot_receiver

var enable_receiver : bool

func _ready():
	vat_long_receiver.set_monitoring(enable_receiver)
	
func _process(delta):
	pass
	

func _on_vat_long_receiver_area_entered(area):
	print("COOKING VAT: "+ area.name)
	
	if area.name == "KalabasaReceiver" and enable_receiver:
		area.get_parent().queue_free()
		water_clear.visible = false
		kalabasa_soup_unmixed.visible = true
		kalabasa_in_pot_receiver.emit()
		progress_view.visible = true
		

func _on_action_chop_kalabasa_event_ended():
	enable_receiver = true
	vat_long_receiver.set_monitoring(enable_receiver)
	

