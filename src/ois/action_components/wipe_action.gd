extends ReceiverObj

var interacting_inital_pos
var delta_dist_prev = 0
var total_delta_dist = 0
var buffer = 0.005
var past_progress = 0
@onready var mesh = $MeshInstance3D2
var default_material : Material
const white_hover = preload("res://src/ois/xx_demo_objects/white.tres")
const normal_hover = preload("res://src/ois/xx_demo_objects/normal.tres")

#func _ready():
	# Initialize materials
	#default_material = mesh.material_override
	

func initialize_action_vars():
	interacting_inital_pos = interacting_object.position
	past_progress = total_progress
	
	delta_dist_prev = 0
	total_delta_dist = 0

func _process(_delta):
	var interacting_current_pos = interacting_object.position
	
	var delta_dist = interacting_inital_pos.distance_to(interacting_current_pos)
	#print(str(interacting_inital_pos) + " - " + str(interacting_current_pos) + " = " + str(delta_dist))
	var current_progress = total_delta_dist + delta_dist
		
	if(delta_dist < (delta_dist_prev-buffer)):
		total_delta_dist += delta_dist
		interacting_inital_pos = interacting_object.position
	
	delta_dist_prev = delta_dist
	
	total_progress = past_progress + (current_progress * rate);
	print(total_progress)
	
	super(_delta)

# Handle pointer events
func pointer_event(event : XRToolsPointerEvent) -> void:
	if event.event_type == XRToolsPointerEvent.Type.ENTERED:
		# When the pointer enters, set the hover material
		print("hovering at cat")
		#mesh.material_override = hover_material

	elif event.event_type == XRToolsPointerEvent.Type.EXITED:
		# When the pointer exits, revert to the default material
		print("no longer hovering at cat")
		mesh.material_override = null

	elif event.event_type == XRToolsPointerEvent.Type.PRESSED:
		# You can still handle pressing if needed
		print("pointing at cat")
		mesh.material_override = white_hover
