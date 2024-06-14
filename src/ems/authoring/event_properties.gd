extends Node

var conditions:Array = []
var state
@onready var initialize_event_sound = $initialize_event_sound
@onready var ongoing_event_sound = $ongoing_event_sound
@onready var ongoing_delay_timer = $ongoing_delay_timer

func set_state(s):
	state = s

func _process(delta):
	if state != "finished":
		if check_event_prerequisites():
			initialize_event()
	if state == "ongoing":
		ongoing_event_sound.play()
	
func check_event_prerequisites() -> bool:
	for event in conditions:
		if event.state != "finished":
			return false
	return true

func initialize_event():
	var conditions_complete = check_event_prerequisites()
	if conditions_complete:
		set_state("initialized")
		initialize_event_sound.play()

func _on_initialize_event_sound_finished():
	set_state("ongoing")

func _on_ongoing_event_sound_finished():
	ongoing_delay_timer.start()

func _on_ongoing_delay_timer_timeout():
	ongoing_event_sound.play()
