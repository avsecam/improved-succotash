extends Node


@export var bgm_locations : Dictionary = {}

@export var dialogue_locations : Dictionary = {}

@onready var bgm_player := $BGMPlayer
@onready var dialogue_player := $DialoguePlayer


func _ready():
	for file in DirAccess.get_files_at("res://src/assets/audio/music/"):
		if(file.get_extension() != "import"):
			bgm_locations[file.get_basename()] = load("res://src/assets/audio/music/" + file)
	
	for file in DirAccess.get_files_at("res://src/assets/audio/tutorial/"):
		if(file.get_extension() != "import"):
			dialogue_locations[file.get_basename()] = load("res://src/assets/audio/tutorial/" + file)
	
	for file in DirAccess.get_files_at("res://src/assets/audio/a1/"):
		if(file.get_extension() != "import"):
			dialogue_locations[file.get_basename()] = load("res://src/assets/audio/a1/" + file)
	
	print (dialogue_locations)

func play_bgm(bgm_key):
	bgm_player.stream = bgm_locations[bgm_key]
	bgm_player.play()

func play_dialogue(dialogue_key, dialogue_source):
	#dialogue_player = dialogue_source
	#dialogue_player.stream = dialogue_locations[dialogue_key]
	#dialogue_player.play()
	dialogue_source.stream = dialogue_locations[dialogue_key]
	dialogue_source.play()
	await dialogue_source.finished
	dialogue_player.emit_signal("finished")


func _on_bgm_player_finished():
	bgm_player.playing = true
