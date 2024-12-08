class_name EventObject
extends StaticBody2D

@onready var connections: Node2D = $Connections
@onready var line_edit: LineEdit = $LineEdit

@export var object_name: String

var selected: bool = false
var can_drag: bool = false

func _ready():
	line_edit.text_submitted.connect(_on_line_edit_text_submitted)
	line_edit.text_changed.connect(_on_line_edit_text_changed)
	
	line_edit.text = object_name

func _input_event(viewport, event, shape_idx):
	if event.is_action_pressed("mouse_left"):
		Events.teleport_node_drag_started.emit(self)
	elif event.is_action_pressed("mouse_right"):
		Events.teleport_node_selected.emit(self)
		
	elif event.is_action_released("mouse_left"):
		can_drag = false

func _process(delta):
	# Make number of lines equal the number of connections
	var difference = connections.get_children().size() - self.teleport_connections.size()
	if difference < 0:
		for i in range(abs(difference)):
			connections.add_child(Line2D.new())
	elif difference > 0:
		for i in range(abs(difference)):
			var node_to_remove = connections.get_child(0)
			connections.remove_child(node_to_remove)
			node_to_remove.queue_free()
	
	# Show indicator if selected
	$ColorRect.visible = selected
	
	# Drag
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and can_drag:
		self.position = get_global_mouse_position()

func _on_line_edit_text_changed(new_text: String):
	object_name = new_text

func _on_line_edit_text_submitted(new_text: String):
	line_edit.release_focus()
