extends Node

@onready var audio_stream_player = $"../../MarbleSpirit_Normal/AudioStreamPlayer3D"
@onready var timer = $"../../MarbleSpirit_Normal/Timer"
const initialize = preload("res://src/assets/audio/tutorial/VE_VO_ZT_MRBLSPRT_03_TheGateIsLocked.ogg")
const ongoing = preload("res://src/assets/audio/tutorial/VE_VO_ZT_MRBLSPRT_04_GoKey.ogg")


func _ready():
	if !Events.pick_up_key:
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
	if !Events.pick_up_key:
		var length = audio_stream_player.stream.get_length()
		timer.wait_time = length + 3
		audio_stream_player.play()

func _on_key_pick_up():
	#Make a signal that the key is picked up already
	Events.pick_up_key = true

func _on_audio_stream_player_3d_finished():
	audio_stream_player.stream = ongoing
