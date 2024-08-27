extends Node

@onready var audio_stream_player = $"../../MarbleSpirit_Normal/AudioStreamPlayer3D"
@onready var marble_spirit_normal = $"../../MarbleSpirit_Normal"
const initialize = preload("res://src/assets/audio/tutorial/VE_VO_ZT_MRBLSPRT_01_HelloMe.ogg")
const ongoing = preload("res://src/assets/audio/tutorial/VE_VO_ZT_MRBLSPRT_02_HeyHere.ogg")
@onready var timer = $"../../MarbleSpirit_Normal/Timer"
@onready var next = $"../../Teleporters/Tut2_jpg"

var line1 = "Hello! Are you a visitor? Can you see me?"
var npc1 = "Marble NPC"

func _ready():
	if !Events.look_at_me:
		timer.start()
		initialize_event()
		Events.update_npc_line.emit(line1)
		Events.update_npc_name.emit(npc1)
		

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
