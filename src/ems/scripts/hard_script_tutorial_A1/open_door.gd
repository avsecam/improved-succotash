extends Node

@onready var audio_stream_player = $"../../MarbleSpirit_Normal/AudioStreamPlayer3D"
@onready var timer = $"../../MarbleSpirit_Normal/Timer"
const initialize = preload("res://src/assets/audio/tutorial/VE_VO_ZT_MRBLSPRT_08_TheresIt.ogg")
const ongoing = preload("res://src/assets/audio/tutorial/VE_VO_ZT_MRBLSPRT_09_ItsIt.ogg")
const done = preload("res://src/assets/audio/tutorial/VE_VO_ZT_MRBLSPRT_10_GreatGo.ogg")
@onready var pet_cat = $"../pet_cat"

func _ready():
	if !Events.open_gate:
		timer.start()
		initialize_event()
		#make the key disappear (not needed anymore)
	else:
		pass
		
func initialize_event():
	audio_stream_player.stream = initialize
	var length = audio_stream_player.stream.get_length()
	timer.wait_time = length + 3

func _on_timer_timeout():
	if !Events.open_gate:
		var length = audio_stream_player.stream.get_length()
		timer.wait_time = length + 3
		audio_stream_player.play()

func _on_gate_open():
	audio_stream_player.stream = done
	audio_stream_player.play()
	Events.open_gate = true

func _on_audio_stream_player_3d_finished():
	if !Events.open_gate:
		audio_stream_player.stream = ongoing
