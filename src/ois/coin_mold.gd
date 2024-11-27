extends StaticBody3D

@onready var molten_iron_receiver = $MoltenIronReceiver
@onready var coin_sz_collider = $CoinSnapZone/CollisionShape3D
@onready var coin_snap_zone = $CoinSnapZone
@onready var coin_silver = $coin_silver
@onready var progress_view = $"Progress View"
@onready var blessed_particles_real = $BlessedParticlesReal

@export var ingot_amount = 5
var ingot_amount_x

var molten_iron_receiver_in : bool
var coin_complete : bool
var molten_iron : bool
var complete_through_event_load : bool

signal coin_complete_signal


func _ready():
	coin_silver.visible = false
	coin_snap_zone.enabled = false
	molten_iron_receiver_in = false
	complete_through_event_load = false
	#coin_sz_collider.disabled = true
	ingot_amount_x = ingot_amount

func _process(delta):
	if !complete_through_event_load:
		if ingot_amount_x <= 0:
			if !coin_complete:
				coin_complete = true
				blessed_particles_real.emitting = true
				coin_silver.visible = true
				coin_silver._set_coin_complete()
				coin_snap_zone.enabled = true
				progress_view.progress_complete_anim()
				coin_complete_signal.emit()
		
func _physics_process(delta):
	if !molten_iron_receiver_in and molten_iron and !complete_through_event_load:
		progress_view.visible = true
	elif molten_iron:
		if ingot_amount_x > 0:
			ingot_amount_x -= delta
			progress_view.change_progress_value((ingot_amount - ingot_amount_x)/ingot_amount*100)

func _on_molten_iron_receiver_area_entered(area):
	if area.name == "MoltenIronReceiver":
		print("MOLTEN IRON RECEIVER DETECTED")
		molten_iron_receiver_in = true


func _on_molten_iron_receiver_area_exited(area):
	if area.name == "MoltenIronReceiver":
		print("MOLTEN IRON EXIT DETECTED")
		molten_iron_receiver_in = false


func _on_small_crucible_ingot_is_melted():
	molten_iron = true

func _on_action_coin_complete_event_ended():
	complete_through_event_load = true
	coin_complete = true
	blessed_particles_real.emitting = true
	coin_silver.visible = true
	coin_silver._set_coin_complete()
	coin_snap_zone.enabled = true
