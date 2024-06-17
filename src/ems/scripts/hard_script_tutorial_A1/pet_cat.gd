extends Node

@onready var audio_stream_player = $"../../MarbleSpirit_Normal/AudioStreamPlayer3D"
@onready var timer = $"../../MarbleSpirit_Normal/Timer"
const initialize = preload("res://src/assets/audio/tutorial/VE_VO_ZT_MRBLSPRT_11_HeyIt.ogg")
const ongoing = preload("res://src/assets/audio/tutorial/VE_VO_ZT_MRBLSPRT_12_DontCat.ogg")

func _on_gate_open():
	#make a signal when gate is open
	pass

func start_event():
	if !Events.pet_cat and Events.open_gate:
		timer.start()
		initialize_event()
	else:
		#do something
		pass

func initialize_event():
	audio_stream_player.stream = initialize
	var length = audio_stream_player.stream.get_length()
	timer.wait_time = length + 3

func _on_timer_timeout():
	if !Events.pet_cat and Events.open_gate:
		var length = audio_stream_player.stream.get_length()
		timer.wait_time = length + 3
		audio_stream_player.play()

func _on_cat_petted():
	#Make a signal when the cat was petted
	Events.pet_cat = true


func _on_audio_stream_player_3d_finished():
	if !Events.pet_cat and Events.open_gate:
		audio_stream_player.stream = ongoing
