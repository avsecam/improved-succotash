extends Node

@onready var audio_stream_player = $"../../MarbleSpirit_Normal/AudioStreamPlayer3D"
@onready var timer = $"../../MarbleSpirit_Normal/Timer"
const initialize = preload("res://src/assets/audio/tutorial/VE_VO_ZT_MRBLSPRT_13_TheAsk.ogg")
const ongoing = preload("res://src/assets/audio/tutorial/VE_VO_ZT_MRBLSPRT_14_WhatAdventure.ogg")

func _on_gate_open():
	#make a signal when gate is open
	pass

func start_event():
	if !Events.get_picture and Events.pet_cat:
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
	if !Events.get_picture and Events.pet_cat:
		var length = audio_stream_player.stream.get_length()
		timer.wait_time = length + 3
		audio_stream_player.play()
		_on_get_picture()

func _on_get_picture():
	#Make a signal when the cat was petted
	Events.get_picture = true


func _on_audio_stream_player_3d_finished():
	if !Events.get_picture and Events.pet_cat:
		audio_stream_player.stream = ongoing
