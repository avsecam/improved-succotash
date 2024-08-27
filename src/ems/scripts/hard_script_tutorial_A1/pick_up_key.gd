extends Node

@onready var audio_stream_player = $"../../MarbleSpirit_Normal/AudioStreamPlayer3D"
@onready var timer = $"../../MarbleSpirit_Normal/Timer"
const initialize = preload("res://src/assets/audio/tutorial/VE_VO_ZT_MRBLSPRT_03_TheGateIsLocked.ogg")
const ongoing = preload("res://src/assets/audio/tutorial/VE_VO_ZT_MRBLSPRT_04_GoKey.ogg")
@onready var xrcamera = $"../../MarbleSpirit_Normal/Timer"

var npc1 = "Marble Spirit"
var line0 = "The gate up ahead is locked, you'll need this to open it!"
var line1 = "Go on! Pick up the key!"

func _ready():
	
	if !Events.pick_up_key:
		timer.start()
		initialize_event()
		await Engine.get_main_loop().process_frame
		Events.update_npc_name.emit(npc1)
		Events.update_npc_line.emit(line0)
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
	Events.update_npc_line.emit(line1)
	Events.update_npc_name.emit(npc1)
