extends XRToolsInteractableArea
@onready var howitzer_round = $"../../howitzer_round"
@onready var round_slot = $"../Howitzer_Round_slot"
signal loaded_howitzer
signal fire_howitzer
@onready var dark_crystal = $"../../DistortionCrystal10/MainMesh/Dark_Crystal"
var loaded = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body == howitzer_round:
		howitzer_round.queue_free()
		round_slot.visible = true
		loaded_howitzer.emit()
		loaded = true


func _on_pointer_event(event):
	if event.event_type == XRToolsPointerEvent.Type.PRESSED and loaded:
		AudioHandler.play_sfx("C_Howitzer", null)
		fire_howitzer.emit()
