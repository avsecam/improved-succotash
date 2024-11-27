extends XRToolsPickable

@onready var melted_iron = $MainMesh/MeltedIron
@onready var molten_crucible = $MainMesh/MoltenCrucible
@onready var normal_crucible = $MainMesh/NormalCrucible

@onready var blow_particles = $MainMesh/MeltedIron/BlowParticles
@onready var iron_ingot = $MainMesh/Iron_ingot
@onready var crucible_snap_zone = $CrucibleSnapZone
@onready var progress_view = $"Progress View"


@onready var molten_iron_receiver = $MoltenIronReceiver
@export var timer_duration = 10
var timer_duration_x

var ingot_inside : bool
var enough_heat : bool
var in_forge : bool
var ingot_melted : bool

signal ingot_is_melted
signal ingot_in_crucible

func _ready():
	super()
	blow_particles.emitting = false
	iron_ingot.visible = false
	melted_iron.visible = false
	progress_view.visible = false
	enough_heat = false
	timer_duration_x = timer_duration

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timer_duration_x <= 0:
		if !ingot_melted:
			progress_view.progress_complete_anim()
			ingot_is_melted.emit()
			ingot_melted = true
			melted_iron.visible = true
			iron_ingot.visible = false
			normal_crucible.visible = false
			molten_crucible.visible = true
		
	if ingot_melted and !in_forge:
		# max rotation is up to 1800deg
		for x in range(-1,1):
			#print(str((360*x)+90) + "deg to " + str((360*x)+270) + "deg")
			if ((360*x) + 90) <= self.rotation_degrees.z && self.rotation_degrees.z <= ((360*x) + 270):
				blow_particles.emitting = true
				molten_iron_receiver.set_monitoring(true)
			elif ((360*x) - 90) <= self.rotation_degrees.z && self.rotation_degrees.z <= ((360*x)+ 90):
				blow_particles.emitting = false
				molten_iron_receiver.set_monitoring(false)
		

func _physics_process(delta):
	if progress_view.visible and enough_heat and ingot_inside:
		if timer_duration_x > 0:
			timer_duration_x -= delta
			progress_view.change_progress_value((timer_duration - timer_duration_x)/timer_duration*100)


func _on_crucible_snap_zone_has_picked_up(what):
	crucible_snap_zone.enabled = false
	what.visible = false
	what.disable_collision()
	iron_ingot.visible = true
	ingot_inside = true
	ingot_in_crucible.emit()
	
func _on_bellows_crucible_in_forge():
	in_forge = true
	progress_view.visible = true

func _on_bellows_enough_heat_in_forge():
	if in_forge:
		enough_heat = true

func _on_bellows_not_enough_heat_in_forge():
	if in_forge:
		enough_heat = false

func _on_bellows_crucible_removed():
	in_forge = false
	progress_view.visible = false

func _on_picked_up(pickable):
	if _grab_driver.primary.pickup and ingot_melted:
		await get_tree().create_timer(0.2).timeout
		drop()

func _on_molten_iron_receiver_area_entered(area):
	print("AWAWWAWAAWAWAAWAWWAAWAWA" + area.name)


func _on_coin_mold_coin_complete_signal():
	melted_iron.visible = false


func _on_action_put_ingot_in_crucible_event_ended():
	crucible_snap_zone.enabled = false
	iron_ingot.visible = true
	ingot_inside = true

func _on_action_ingot_finished_melt_event_ended():
	ingot_melted = true
	melted_iron.visible = true
	iron_ingot.visible = false
	normal_crucible.visible = false
	molten_crucible.visible = true
	ingot_is_melted.emit()


func _on_action_coin_complete_tree_exiting():
	melted_iron.visible = false
