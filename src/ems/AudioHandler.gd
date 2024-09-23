extends Node


@export var bgm_locations : Dictionary = {}
@export var sfx_locations : Dictionary = {}
@export var dialogue_locations : Dictionary = {}

@onready var bgm_player := $BGMPlayer
@onready var dialogue_player := $DialoguePlayer


func _ready():
	for key in Events.event_library:
		var audio_name = Events.event_library[key]["Event_Audio"]
		if Events.event_library[key]["Event_Category"] == "BGM":
			bgm_locations[audio_name] = load("res://src/assets/audio/music/" + audio_name + ".wav")
		else:
			if audio_name.contains("_ZT_"):
				dialogue_locations[audio_name] = load("res://src/assets/audio/tutorial/" + audio_name + ".ogg")
			if audio_name.contains("_A1_"):
				dialogue_locations[audio_name] = load("res://src/assets/audio/a1/" + audio_name + ".ogg")
	
	#for file in DirAccess.get_files_at("res://src/assets/audio/tutorial/"):
		#if(file.get_extension() != "import"):
			#dialogue_locations[file.get_basename()] = load("res://src/assets/audio/tutorial/" + file)
	#
	#for file in DirAccess.get_files_at("res://src/assets/audio/a1/"):
		#if(file.get_extension() != "import"):
			#dialogue_locations[file.get_basename()] = load("res://src/assets/audio/a1/" + file)
	#
	#for file in DirAccess.get_files_at("res://src/assets/audio/sfx/"):
		#if(file.get_extension() != "import"):
			#sfx_locations[file.get_basename()] = load("res://src/assets/audio/sfx/" + file)


func play_bgm(bgm_key):
	bgm_player.stream = bgm_locations[bgm_key]
	bgm_player.play()

func play_dialogue(dialogue_key, dialogue_source):
	dialogue_player = dialogue_source
	#dialogue_player.stream = dialogue_locations[dialogue_key]
	#dialogue_player.play()
	dialogue_source.stream = dialogue_locations[dialogue_key]
	dialogue_source.play()
	await dialogue_source.finished
	dialogue_player.emit_signal("finished")

func play_sfx(sfx_key, sfx_source):
	pass
func _on_bgm_player_finished():
	bgm_player.playing = true
