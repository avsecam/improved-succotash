extends Node

@onready var initialize_audio = $initialize_audio
@onready var ongoing_audio = $ongoing_audio
@onready var wait_timer = $wait_timer

@export var conditions = []
var state = "not_started"

func _ready():
	if conditions.size() == 0:
		state = "initalize"
		
func _process(delta):
	if state == "initialize":
		initialize_audio.play()
		wait_timer.start()
		state = "ongoing"
	if state == "ongoing":
		do_ongoing()
		
func do_ongoing():
	wait_timer.start()
	
func _on_wait_timer_timeout():
	ongoing_audio.play()
