extends Control

@onready var animation_player = $AnimationPlayer
@onready var panorama_container = get_tree().get_root().get_node("/root/XRPlayer/XROrigin3D/PanoramaContainer")
@onready var main_menu_ui = get_tree().get_root().get_node("/root/MainMenu/Viewport2Din3D/Viewport/MainMenuUI")

func _ready():
	await get_tree().create_timer(2).timeout
	animation_player.play("PlayCredits")
	await get_tree().create_timer(5).timeout
	panorama_container.on_demand_play_fade_in()
	await get_tree().create_timer(1).timeout
	main_menu_ui.open_main_menu() 
	
	
