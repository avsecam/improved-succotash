extends RigidBody3D

@onready var audio_stream_player = $"../MarbleSpirit_Normal/AudioStreamPlayer3D"
@onready var marble_spirit_normal = $"../MarbleSpirit_Normal"
const initialize = preload("res://src/assets/audio/a1/VE_VO_A1_MRBLSPRT_02_WhatsHere.ogg")
const ongoing = preload("res://src/assets/audio/a1/VE_VO_A1_MRBLSPRT_06_TheBack.ogg")
@onready var timer = $"../MarbleSpirit_Normal/Timer"

func _ready():
	if !Events.fire_spirit_help:
		timer.start()
		initialize_event()

func initialize_event():
	audio_stream_player.stream = initialize
	var length = audio_stream_player.stream.get_length()
	timer.wait_time = length + 3
	
func _on_audio_stream_player_3d_finished():
	audio_stream_player.stream = ongoing

func _on_timer_timeout():
	if !Events.fire_spirit_help and audio_stream_player.stream == ongoing:
		var length = audio_stream_player.stream.get_length()
		timer.wait_time = length + 3
		audio_stream_player.play()

func _on_visible_on_screen_notifier_3d_screen_entered():
	Events.fire_spirit_help = true
	print("look at fire spirit")
