extends XRToolsPickable

@onready var saba_bananas_fried = $MainMesh/SabaBananas_Fried
@onready var strainer_actor = $StrainerActor

var saba_check : bool
var saba_plated_bool : bool
var saba_finish_cook : bool

func _ready():
	saba_check = false
	saba_plated_bool = false
	saba_finish_cook = false
	super()

func _on_strainer_actor_area_entered(area):
	if area.name == "StrainerReceiver" and saba_finish_cook and !saba_check:
		saba_bananas_fried.visible = true
		saba_check = true
	elif area.name == "PlateReceiver" and !saba_plated_bool and saba_finish_cook:
		saba_bananas_fried.visible = false
		strainer_actor.set_monitoring(false)

func _on_action_put_cooked_saba_in_plate_tree_exiting():
	saba_plated_bool = true
	self.visible = false


func _on_action_finish_saba_cooking_tree_exiting():
	saba_finish_cook = true


func _on_action_all_atchara_ingredients_tree_exiting():
	self.visible = true
