extends WipeAction

@onready var water_clear = $MainMesh/WaterClear
@onready var kalabasa_soup_unmixed = $MainMesh/KalabasaSoupUnmixed
@onready var kalabasa_soup_mixed = $MainMesh/KalabasaSoupMixed
@onready var vat_long_receiver = $VatLongReceiver

func _ready():
	#vat_long_receiver.set_monitoring(false)
	pass
	
func _process(delta):
	pass
	

func _on_vat_long_receiver_area_entered(area):
	print("COOKING VAT: "+ area.name)
	
	if area.name == "KalabasaReceiver":
		area.get_parent().queue_free()
		water_clear.visible = false
		kalabasa_soup_unmixed.visible = true
		

	
		
		
