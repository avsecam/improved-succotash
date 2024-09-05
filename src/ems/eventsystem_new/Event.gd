extends Node
class_name Event

signal event_started()
signal event_ended()

signal event_audio_done()

var event_name : String
var event_category : String
var oneshot : bool
var event_prerequisites : Array
var event_completion_flags : Array
var event_audio : String
@export var event_audio_source : AudioStreamPlayer3D
var loop_audio : bool
var loop_interval : float


var prerequisites_done : bool = true
var is_ongoing : bool = false


func _ready() -> void:
	initialize_event()
	
	if event_category == "BGM":
		if event_name == Events.current_bgm:
			queue_free()
			return
	elif oneshot:
		if (event_name + "_Done") in Events.finished_events:
			queue_free()
			return
	
	event_started.connect(_on_event_started)
	event_ended.connect(get_parent()._on_event_ended)
	
	get_tree().process_frame.connect(start_event, CONNECT_ONE_SHOT)
	


func initialize_event() -> void:
	event_name = self.name
	if Events.event_library.has(event_name):
		event_category = Events.event_library[event_name]["Event_Category"]
		oneshot = Events.event_library[event_name]["Oneshot"]
		event_prerequisites = Events.event_library[event_name]["Event_Prerequisites"]
		event_completion_flags = Events.event_library[event_name]["Event_Completion_Flags"]
		event_audio = Events.event_library[event_name]["Event_Audio"]
		loop_audio = Events.event_library[event_name]["Loop_Audio"]
		loop_interval = Events.event_library[event_name]["Loop_Interval"]
	else:
		print("Event " + event_name + " Not Found")


func start_event() -> void:
	prerequisites_done = true
	for flag in event_prerequisites:
		if flag not in Events.finished_events:
			prerequisites_done = false
			
	if not prerequisites_done:
		print("Event " + str(event_name) + " not Started")
	else:
		print("Event " + str(event_name) + " Started")
		is_ongoing = true
		emit_signal("event_started")


func close_event() -> void:
	for flag in event_completion_flags:
		Events.finished_events.append(flag)
	queue_free()
	print(Events.finished_events)
	await tree_exited
	emit_signal("event_ended")


func play_event_audio():
	if event_category == "BGM":
		Events.current_bgm = event_name
		AudioHandler.play_bgm(event_audio)
		await AudioHandler.bgm_player.finished
	else:
		AudioHandler.play_dialogue(event_audio, event_audio_source)
		await AudioHandler.dialogue_player.finished
		emit_signal("event_audio_done")
	
	if loop_audio:
		await get_tree().create_timer(loop_interval).timeout
		play_event_audio()


func _on_event_started():
	pass