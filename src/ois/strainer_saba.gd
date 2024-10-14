extends XRToolsPickable

@onready var saba_bananas_fried = $MainMesh/SabaBananas_Fried
@onready var strainer_actor = $StrainerActor

var saba_check : bool

func _ready():
	saba_check = false

func _on_strainer_actor_area_entered(area):
	if area.name == "StrainerReceiver":
		saba_bananas_fried.visible = true
		saba_check = true
	elif area.name == "PlateReceiver":
		saba_bananas_fried.visible = false
