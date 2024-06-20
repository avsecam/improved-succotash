extends Node

@onready var audio_stream_player = $"../../MarbleSpirit_Normal/AudioStreamPlayer3D"
@onready var marble_spirit_normal = $"../../MarbleSpirit_Normal"
@export var initialize_audio:AudioStreamOggVorbis
@export var ongoing_audio:AudioStreamOggVorbis
@onready var timer = $"../../MarbleSpirit_Normal/Timer"
@onready var next = $"../../Teleporters/Tut2_jpg"
@export var timer_time = 3

func _ready():
	if !Events.look_at_me:
		timer.start()
		#initialize_event()

func _on_visible_on_screen_notifier_3d_screen_entered():
	Events.look_at_me = true

func initialize_event():
	#audio_stream_player.stream = initialize
	var length = audio_stream_player.stream.get_length()
	timer.wait_time = length + timer_time
	
func _on_audio_stream_player_3d_finished():
	#audio_stream_player.stream = ongoing
	pass

func _on_timer_timeout():
	if !Events.look_at_me:
		var length = audio_stream_player.stream.get_length()
		timer.wait_time = length + 3
		audio_stream_player.play()
