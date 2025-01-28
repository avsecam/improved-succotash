extends Node


@export var bgm_locations : Dictionary = {}
@export var dialogue_locations : Dictionary = {}

@export var sfx_locations : Dictionary = {
	"Char_MrblSprt" : preload("res://src/assets/audio/sfx/VE_SFX_UI_MrblSprt.ogg"),
	"Char_Cat" : preload("res://src/assets/audio/sfx/VE_SFX_UI_Cat.ogg"),
	"Char_Cat_Meow1" : preload("res://src/assets/audio/sfx/VE_SFX_UI_Cat_Meow.ogg"),
	"Char_Cat_Meow2" : preload("res://src/assets/audio/sfx/VE_SFX_UI_Cat_Meow_Var_01.ogg"),
	"Char_Cat_Meow3" : preload("res://src/assets/audio/sfx/VE_SFX_UI_Cat_Meow_Var_02.ogg"),
	"Char_Cat_Meow4" : preload("res://src/assets/audio/sfx/VE_SFX_UI_Cat_Meow_Var_03.ogg"),
	"UI_Confirm" : preload("res://src/assets/audio/sfx/VE_SFX_UI_Confirm.ogg"),
	"UI_Fail" : preload("res://src/assets/audio/sfx/VE_SFX_UI_Fail.ogg"),
	"UI_Return" : preload("res://src/assets/audio/sfx/VE_SFX_UI_Return.ogg"),
	"UI_Success" : preload("res://src/assets/audio/sfx/VE_SFX_UI_Success.ogg"),
	"UI_TaskPending" : preload("res://src/assets/audio/sfx/VE_SFX_UI_TaskPending.ogg"),
	"UI_TaskWrong" : preload("res://src/assets/audio/sfx/VE_SFX_UI_TaskWrong.ogg"),
	"UI_QuestComplete" : preload("res://src/assets/audio/sfx/VE_SFX_UI_QuestComplete.ogg"),
	"UI_Tele_Hover" : preload("res://src/assets/audio/sfx/VE_SFX_UI_Teleport_Hover.ogg"),
	"UI_Tele_Confirm" : preload("res://src/assets/audio/sfx/VE_SFX_UI_Teleport_Confirm.ogg"),
	"UI_Inventory_Toggle" : preload("res://src/assets/audio/sfx/VE_SFX_UI_Inventory_Poof_Short.ogg"),
	"Tut_Gate_Open" : preload("res://src/assets/audio/sfx/VE_SFX_UI_Tutorial_MetalGateOpen.ogg"),
	"A_Purify" : preload("res://src/assets/audio/sfx/VE_SFX_UI_Purify.ogg"),
	"A_Padlock_Turn1" : preload("res://src/assets/audio/sfx/VE_SFX_UI_Padlock_Turn_Var_01.ogg"),
	"A_Padlock_Turn2" : preload("res://src/assets/audio/sfx/VE_SFX_UI_Padlock_Turn_Var_02.ogg"),
	"A_Padlock_Open" : preload("res://src/assets/audio/sfx/VE_SFX_UI_Padlock_Open.ogg"),
	"A_WoodBox_Open" : preload("res://src/assets/audio/sfx/VE_SFX_UI_WoodBoxOpen.ogg"),
	"A_CrystalShatter" : preload("res://src/assets/audio/sfx/VE_SFX_UI_A_CrystalShatter.ogg"),
	"C_Pistol_Gunshot" : preload("res://src/assets/C1/163456__lemudcrab__pistol-shot.wav"),
	"C_ShotGunshot" : preload("res://src/assets/C1/473846__matrixxx__shotgun-shot-03.wav"),
	"C_Howitzer": preload("res://src/assets/C1/685279__logicogonist__m777-howitzer-1.wav")
}

@onready var bgm_player := $BGMPlayer
@onready var dialogue_player := $DialoguePlayer
@onready var sfx_player := $SFXPlayer

func _ready():
	for key in Events.event_library:
		var audio_name = Events.event_library[key]["Event_Audio"]
		if Events.event_library[key]["Event_Category"] == "BGM":
			bgm_locations[audio_name] = load("res://src/assets/audio/music/" + audio_name + ".wav")
		else:
			if audio_name.contains("_ZT_"):
				dialogue_locations[audio_name] = load("res://src/assets/audio/tutorial/" + audio_name + ".ogg")
			if audio_name.contains("_A_MAIN_"):
				dialogue_locations[audio_name] = load("res://src/assets/audio/a/" + audio_name + ".ogg")
			if audio_name.contains("_A1_"):
				dialogue_locations[audio_name] = load("res://src/assets/audio/a1/" + audio_name + ".ogg")
			if audio_name.contains("_A2_"):
				dialogue_locations[audio_name] = load("res://src/assets/audio/a2/" + audio_name + ".ogg")
			if audio_name.contains("_A3_"):
				dialogue_locations[audio_name] = load("res://src/assets/audio/a3/" + audio_name + ".ogg")
			if audio_name.contains("_A4_"):
				dialogue_locations[audio_name] = load("res://src/assets/audio/a4/" + audio_name + ".ogg")
			if audio_name.contains("_B1_"):
				dialogue_locations[audio_name] = load("res://src/assets/audio/b1/" + audio_name + ".ogg")
			if audio_name.contains("_B2_"):
				dialogue_locations[audio_name] = load("res://src/assets/audio/b2/" + audio_name + ".ogg")
			if audio_name.contains("_B3_"):
				dialogue_locations[audio_name] = load("res://src/assets/audio/b3/" + audio_name + ".ogg")
			if audio_name.contains("_B4_"):
				dialogue_locations[audio_name] = load("res://src/assets/audio/b4/" + audio_name + ".ogg")
			if audio_name.contains("_C0_"):
				dialogue_locations[audio_name] = load("res://src/assets/audio/c0/" + audio_name + ".ogg")
			if audio_name.contains("_C1_"):
				dialogue_locations[audio_name] = load("res://src/assets/audio/c1/" + audio_name + ".ogg")
			if audio_name.contains("_C2_"):
				dialogue_locations[audio_name] = load("res://src/assets/audio/c2/" + audio_name + ".ogg")
			if audio_name.contains("_C3_"):
				dialogue_locations[audio_name] = load("res://src/assets/audio/c3/" + audio_name + ".ogg")
			if audio_name.contains("_C4_"):
				dialogue_locations[audio_name] = load("res://src/assets/audio/c4/" + audio_name + ".ogg")
			if audio_name.contains("_C5_"):
				dialogue_locations[audio_name] = load("res://src/assets/audio/c5/" + audio_name + ".ogg")
			if audio_name.contains("_ZF_"):
				dialogue_locations[audio_name] = load("res://src/assets/audio/zf/" + audio_name + ".ogg")
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


func play_bgm(bgm_key, loop_interval):
	bgm_player.stream = bgm_locations[bgm_key]
	bgm_player.stream.set_loop_begin(loop_interval)
	bgm_player.stream.set_loop_end(bgm_player.stream.get_length() * bgm_player.stream.get_mix_rate())
	bgm_player.stream.set_loop_mode(1)
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
	if !sfx_source == null:
		if !sfx_source.playing or !sfx_source.stream == sfx_locations[sfx_key]:
			print("playing sfx")
			sfx_source.stream = sfx_locations[sfx_key]
			sfx_source.play()
			await sfx_source.finished
			sfx_player.emit_signal("finished")
		else:
			return
	else:
		if !sfx_player.playing or !sfx_player.stream == sfx_locations[sfx_key]:
			print("playing sfx")
			sfx_player.stream = sfx_locations[sfx_key]
			sfx_player.play()
			await sfx_player.finished
			sfx_player.emit_signal("finished")
		else:
			return


func _on_bgm_player_finished():
	bgm_player.playing = true
