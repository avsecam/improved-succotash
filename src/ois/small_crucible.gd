extends XRToolsPickable

@onready var melted_iron = $MainMesh/MeltedIron
@onready var blow_particles = $MainMesh/MeltedIron/BlowParticles
@onready var iron_ingot = $MainMesh/Iron_ingot
@onready var crucible_snap_zone = $CrucibleSnapZone
@onready var progress_view = $"Progress View"
@export var timer_duration = 10
var timer_duration_x

var ingot_inside : bool
var enough_heat : bool
var in_forge : bool
var ingot_melted : bool

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
		progress_view.progress_complete_anim()
		ingot_melted = true
		melted_iron.visible = true
		
	if ingot_melted and !in_forge:
		# max rotation is up to 1800deg
		for x in range(-1,1):
			#print(str((360*x)+90) + "deg to " + str((360*x)+270) + "deg")
			if ((360*x) + 90) <= self.rotation_degrees.z && self.rotation_degrees.z <= ((360*x) + 270):
				blow_particles.emitting = true
			elif ((360*x) - 90) <= self.rotation_degrees.z && self.rotation_degrees.z <= ((360*x)+ 90):
				blow_particles.emitting = false
		

func _physics_process(delta):
	if progress_view.visible and enough_heat:
		if timer_duration_x > 0:
			timer_duration_x -= delta
			progress_view.change_progress_value((timer_duration - timer_duration_x)/timer_duration*100)


func _on_crucible_snap_zone_has_picked_up(what):
	crucible_snap_zone.enabled = false
	what.visible = false
	what.disable_collision()
	iron_ingot.visible = true
	ingot_inside = true
	
func _on_bellows_crucible_in_forge():
	in_forge = true

func _on_bellows_enough_heat_in_forge():
	if in_forge:
		enough_heat = true

func _on_bellows_not_enough_heat_in_forge():
	if in_forge:
		enough_heat = false

func _on_bellows_crucible_removed():
	in_forge = false
