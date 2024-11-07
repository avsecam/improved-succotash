extends Node3D

@onready var oil_receiver = $OilReceiver
@onready var saba_bananas = $MainMesh/SabaBananas
@onready var strainer_receiver = $StrainerReceiver
@onready var saba_bananas_fried = $MainMesh/SabaBananas_Fried
@onready var progress_view = $"Progress View"
@export var timer_duration := 10
var timer_duration_x

var saba_limaw_test : bool
signal saba_being_fried
signal saba_ready

func _ready():
	strainer_receiver.set_monitoring(false)
	oil_receiver.set_monitoring(false)
	timer_duration_x = timer_duration
	saba_limaw_test = false
	
func _process(delta):
	pass
	
func _physics_process(delta):
	if progress_view.visible:
		timer_duration_x -= delta
		progress_view.change_progress_value((timer_duration - timer_duration_x)/timer_duration*100)
	
	
func _on_oil_receiver_area_entered(area):
	print("Kawali with Oil "+ area.name)
	if area.name == "SabaReceiver":
		saba_limaw_test = true
		saba_bananas.visible = true
		area.get_parent().queue_free()
		saba_being_fried.emit()
		progress_view.visible = true
		if saba_limaw_test:
			await get_tree().create_timer(timer_duration).timeout
			print("Enable strainer receiver on kawali.")
			progress_view.progress_complete_anim()
			saba_bananas_fried.visible = true
			saba_bananas.visible = false
			saba_ready.emit()
			strainer_receiver.set_monitoring(true)


func _on_strainer_receiver_area_entered(area):
	if area.name == "StrainerActor":
		saba_bananas_fried.visible = false
		progress_view.visible = false
		strainer_receiver.set_monitoring(false)

func _on_action_put_saba_in_pan_tree_exiting():
	saba_bananas.visible = true
	saba_bananas_fried.visible = false
	saba_limaw_test = true
	
func _on_action_finish_saba_cooking_tree_exiting():
	saba_bananas_fried.visible = true
	saba_bananas.visible = false
	strainer_receiver.set_monitoring(true)

func _on_action_put_cooked_saba_in_plate_tree_exiting():
	saba_bananas_fried.visible = false
	strainer_receiver.set_monitoring(false)


func _on_action_all_atchara_ingredients_tree_exiting():
	oil_receiver.set_monitoring(true)
