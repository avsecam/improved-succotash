extends Node

const bgm_1 = preload("res://src/ems/BGM/01 - Outside (Tutorial), Waterfall Area (B-2), On Boat (C-3) v1 Full Loopable.wav")
const bgm_2 = preload("res://src/ems/BGM/02 - Maintenance Workshop (A-1, C-4) v1 Full Loopable.wav")
var outside = false

@onready var current_bgm: AudioStream = bgm_1
@onready var audio_player: AudioStreamPlayer = $"."

func _ready():
	pass

func _process(delta):
	if is_player_outside() and current_bgm != bgm_1:
		play_bgm(bgm_1)
	elif not is_player_outside() and current_bgm != bgm_2:
		play_bgm(bgm_2)

func play_bgm(bgm: AudioStream):
	if current_bgm != bgm:
		current_bgm = bgm
		audio_player.stream = bgm
		audio_player.play()

func change_location():
	outside = false

func is_player_outside() -> bool:
	return outside

func _on_finished():
	print("done")
	audio_player.playing = true
