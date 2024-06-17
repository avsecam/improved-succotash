extends Node

@onready var audio_stream_player = $"../../MarbleSpirit_Normal/AudioStreamPlayer3D"
@onready var marble_spirit_normal = $"../../MarbleSpirit_Normal"
const initialize = preload("res://src/assets/audio/tutorial/VE_VO_ZT_MRBLSPRT_01_HelloMe.ogg")
const ongoing = preload("res://src/assets/audio/tutorial/VE_VO_ZT_MRBLSPRT_02_HeyHere.ogg")
@onready var timer = $"../../MarbleSpirit_Normal/Timer"

func _ready():
	if !Events.look_at_me:
		timer.start()
		initialize_event()

func _on_visible_on_screen_notifier_3d_screen_entered():
	Events.look_at_me = true

func initialize_event():
	audio_stream_player.stream = initialize
	var length = audio_stream_player.stream.get_length()
	timer.wait_time = length + 3
	

func _on_audio_stream_player_3d_finished():
	audio_stream_player.stream = ongoing


func _on_timer_timeout():
	if !Events.look_at_me:
		var length = audio_stream_player.stream.get_length()
		timer.wait_time = length + 3
		audio_stream_player.play()
