extends Node3D

# A NodePath to the Editor_Viewport node.
@export var path_to_editor_viewport: NodePath
# A variable to hold the Editor_Viewport node.
var editor_viewport;

# Initialize UI variables
var x_coord
var y_coord
var z_coord
var apply_button

# A variable to hold the currently active axis.
# NOTE: we are making this a exported variable so we can check its value from the remote debugger.
@export_enum ("ALL", "X", "Y", "Z", "NONE") var active_gizmo_axis: String

# The speed the translate gizmo moves the selected object at.
# You may need to tweak this based on the sensitivity of your mouse and/or how fast you want
# the gizmo to translate the object.
# NOTE: Translate -> Translation -> Movement on the X, Y, and/or Z axes.
const TRANSLATE_SPEED = 0.05;

# A variable to store whether the left mouse button is down or not.
var left_button_down = false;


func _ready():
	# Get the Editor_Viewport node using path_to_editor_viewport and assign it to editor_viewport.
	editor_viewport = get_node(path_to_editor_viewport);
	x_coord = editor_viewport.get_node("../Editor_UI/MarginContainer2/Manual_Value_Input/VBoxContainer/X_edit/X_coord")
	y_coord = editor_viewport.get_node("../Editor_UI/MarginContainer2/Manual_Value_Input/VBoxContainer/Y_edit/Y_coord")
	z_coord = editor_viewport.get_node("../Editor_UI/MarginContainer2/Manual_Value_Input/VBoxContainer/Z_edit/Z_coord")
	# Make the gizmo disabled by default.
	update(false);
	
	# Set the default gizmo axis to NONE.
	active_gizmo_axis = "NONE";


func _input(event):
	# If the active gizmo axis is NOT set to NONE...
	if (active_gizmo_axis != "NONE"):
		
		# If the input event is a InputEventMouseButton event (a mouse button was pressed/held/released)...
		if (event is InputEventMouseButton):
			# If the mouse button is the left mouse button...
			if (event.button_index ==  MOUSE_BUTTON_LEFT):
				# Set left_button_down to the result of the is_pressed() function in the input event.
				# Unlike the pressed variable, is_pressed will return true if the button is pressed AND when the button is held.
				left_button_down = event.is_pressed();
		
		# If the event is a InputEventMouseMotion event (the mouse was moved).
		elif (event is InputEventMouseMotion):
			# If the left mouse button is pressed or held down...
			if (left_button_down == true):
				# If there is a selected object...
				if (editor_viewport.selected_physics_object != null):
					# Store the position the selected object is in right now in a new variable called prior_position.
					var prior_position = editor_viewport.selected_physics_object.global_transform.origin
					# Make a new variable called current_position and assign it to prior_position.
					var current_position = prior_position;
					
					# Assign the relative position of the mouse (event.relative) multiplied by TRANSLATE_SPEED to a variable called mouse_delta.
					var mouse_delta = event.relative * TRANSLATE_SPEED;
					
					# Add the gizmo camera's relative Y axis multiplied by mouse_delta on the negative Y axis. This will move the gizmo
					# up/down relative to the gizmo camera.
					current_position += editor_viewport.gizmo_camera.global_transform.basis.y * -mouse_delta.y;
					# Likewise, add the gizmo camera's relative X axis multiplied by mouse_delta on the X axis. This will move the gizmo
					# right/left relative to the gizmo camera.
					current_position += editor_viewport.gizmo_camera.global_transform.basis.x * mouse_delta.x;
					
					# If the active gizmo axis is the X axis...
					if (active_gizmo_axis == "X"):
						# Then reset current_position on the Y and Z axis to the position stored in prior_position.
						current_position.y = prior_position.y;
						current_position.z = prior_position.z;
					# If the active gizmo axis is the Y axis...
					elif (active_gizmo_axis == "Y"):
						# Then reset current_position on the X and Z axis to the position stored in prior_position.
						current_position.x = prior_position.x;
						current_position.z = prior_position.z;
					# If the active gizmo axis is the Z axis...
					elif (active_gizmo_axis == "Z"):
						# Then reset current_position on the X and Y axis to the position stored in prior_position.
						current_position.x = prior_position.x;
						current_position.y = prior_position.y;
						
					x_coord.set_value(current_position.x)
					y_coord.set_value(current_position.y)
					z_coord.set_value(current_position.z)
					
					# Set the selected object's position to current_position.
					editor_viewport.selected_physics_object.global_transform.origin = current_position;


func update(is_active):
	# Go through all of the children of the translate gizmo.
	for child in get_children():
		# We are going to assume that all of the children of the translate node have Editor_Gizmo_Collider assigned to them.
		# If the gizmo needs to be active...
		if (is_active == true):
			# Tell the gizmo collider to become active.
			child.activate();
		
		# If the does NOT need to be active...
		else:
			# Tell the gizmo collider to become deactive.
			child.deactivate();
	
	# Based on is_active, change the visiblity of the translate gizmo.
	visible = is_active;


func axis_set(new_axis):
	# Set active_gizmo_axis to the passed in axis, new_axis.
	active_gizmo_axis = new_axis;



