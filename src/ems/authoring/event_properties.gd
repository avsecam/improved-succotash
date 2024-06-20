extends Node

@onready var initialze_audio_player = $initialize_audio
@onready var ongoing_audio_player = $ongoing_audio

@onready var object = get_parent()
@export var initialize_audio:AudioStreamPlayer3D = initialze_audio_player
@export var ongoing_audio:AudioStreamPlayer3D = ongoing_audio_player
@onready var timer = $wait_timer
@export var timer_time = 3

func _ready():
	if !Events.look_at_me:
		timer.start()

func _on_visible_on_screen_notifier_3d_screen_entered():
	Events.look_at_me = true

func initialize_event():
	initialze_audio_player.stream = initialize_audio
	initialze_audio_player.play()
	var length = initialze_audio_player.stream.get_length()
	timer.wait_time = length + timer_time
	
func _on_audio_stream_player_3d_finished():
	ongoing_audio_player.stream = ongoing_audio

func _on_timer_timeout():
	if !Events.look_at_me:
		var length = ongoing_audio_player.stream.get_length()
		timer.wait_time = length + 3
		ongoing_audio_player.play()
