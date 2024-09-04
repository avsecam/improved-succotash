extends Node


@export var bgm_locations : Dictionary = {
	"01 - Outside (Tutorial), Waterfall Area (B-2), On Boat (C-3) v1 Full Loopable" : preload("res://src/assets/audio/01 - Outside (Tutorial), Waterfall Area (B-2), On Boat (C-3) v1 Full Loopable.wav"),
	"02 - Maintenance Workshop (A-1, C-4) v1 Full Loopable" : preload("res://src/assets/audio/02 - Maintenance Workshop (A-1, C-4) v1 Full Loopable.wav")
}

@export var dialogue_locations : Dictionary = {
	"VE_VO_ZT_MRBLSPRT_01_HelloMe" : preload("res://src/assets/audio/tutorial/VE_VO_ZT_MRBLSPRT_01_HelloMe.ogg"),
	"VE_VO_ZT_MRBLSPRT_02_HeyHere" : preload("res://src/assets/audio/tutorial/VE_VO_ZT_MRBLSPRT_02_HeyHere.ogg"),
	"VE_VO_ZT_MRBLSPRT_03_TheGateIsLocked" : preload("res://src/assets/audio/tutorial/VE_VO_ZT_MRBLSPRT_03_TheGateIsLocked.ogg"),
	"VE_VO_ZT_MRBLSPRT_04_GoKey" : preload("res://src/assets/audio/tutorial/VE_VO_ZT_MRBLSPRT_04_GoKey.ogg")
}

@onready var bgm_player := $BGMPlayer
@onready var dialogue_player := $DialoguePlayer

func play_bgm(bgm_key):
	bgm_player.stream = bgm_locations[bgm_key]
	bgm_player.play()

func play_dialogue(dialogue_key, dialogue_source):
	dialogue_player = dialogue_source
	dialogue_player.stream = dialogue_locations[dialogue_key]
	dialogue_player.play()


func _on_bgm_player_finished():
	bgm_player.playing = true
