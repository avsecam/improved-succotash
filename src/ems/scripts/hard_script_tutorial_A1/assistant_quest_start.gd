extends Node

@onready var audio_stream_player = $"../../MarbleSpirit_Normal/AudioStreamPlayer3D"
const initialize = preload("res://src/assets/audio/a1/VE_VO_A1_ASST_01_HeyUp.ogg")
const ongoing = preload("res://src/assets/audio/a1/VE_VO_A1_MRBLSPRT_01_ComeWindows.ogg")
@onready var timer = $"../../MarbleSpirit_Normal/Timer"

func _ready():
	if !Events.quest_start:
		initialize_event()

func initialize_event():
	audio_stream_player.stream = initialize
	await get_tree().create_timer(1).timeout
	audio_stream_player.play()
	
func _on_audio_stream_player_3d_finished():
	if audio_stream_player.stream != ongoing:
		audio_stream_player.stream = ongoing
	await get_tree().create_timer(3).timeout
	audio_stream_player.play()
