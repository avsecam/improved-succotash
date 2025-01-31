extends Control

@onready var animation_player = $AnimationPlayer
@onready var panorama_container = get_tree().get_root().get_node("/root/Demo/XRPlayer/XROrigin3D/PanoramaContainer")
@onready var main_menu_ui = get_tree().get_root().get_node("/root/Demo/MainMenu/Viewport2Din3D/Viewport/MainMenuUI")
@onready var bgmplayer = get_tree().get_root().get_node("/root/AudioHandler/BGMPlayer")
@onready var ending_bgm_play = $"../../../EndingBGMPlay"


@onready var marble_spirit_normal = $"../../../MarbleSpirit_Normal"
@onready var cat = $"../../../Cat"
@onready var blessed_particles = $"../../../BlessedParticles"
@onready var cat_2 = $"../../../Cat2"
@onready var viewport_2_din_3d = $"../.."

func _ready():
	bgmplayer.stop()
	ending_bgm_play.play()
	#animation_player.play("PlayCredits")
	await get_tree().create_timer(40).timeout
	#panorama_container.on_demand_play_fade_in()
	await get_tree().create_timer(1).timeout
	
	marble_spirit_normal.visible = false
	cat.visible = false
	blessed_particles.visible = false
	viewport_2_din_3d.visible = false
	cat_2.visible = false
	
	main_menu_ui.open_main_menu_nonpaused()
	
	
