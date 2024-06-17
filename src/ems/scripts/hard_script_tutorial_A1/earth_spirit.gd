extends Node

@onready var audio_stream_player = $"../../MarbleSpirit_Normal/AudioStreamPlayer3D"
@onready var timer = $"../../MarbleSpirit_Normal/Timer"
const initialize = preload("res://src/assets/audio/tutorial/VE_VO_ZT_MRBLSPRT_05_YoureYou.ogg")
const ongoing = preload("res://src/assets/audio/tutorial/VE_VO_ZT_MRBLSPRT_06_SinceYou.ogg")
@onready var next = $"../../Teleporters/Tut3_jpg"

func _on_key_pick_up():
	#make a signal when key is picked up
	pass

func start_event():
	if !Events.earth_spirit:
		timer.start()
		initialize_event()
	else:
		#make the key disappear
		pass

func initialize_event():
	audio_stream_player.stream = initialize
	var length = audio_stream_player.stream.get_length()
	timer.wait_time = length + 3

func _on_timer_timeout():
	if !Events.earth_spirit and Events.pick_up_key:
		var length = audio_stream_player.stream.get_length()
		timer.wait_time = length + 3
		audio_stream_player.play()

func _on_key_in_inventory():
	#Make a signal that the key is in inventory
	Events.earth_spirit = true


func _on_audio_stream_player_3d_finished():
	if !Events.earth_spirit and Events.pick_up_key:
		audio_stream_player.stream = ongoing
