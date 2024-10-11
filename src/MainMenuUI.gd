extends Control

@onready var main := $Main
@onready var save_load := $SaveLoad
@onready var new_game_load := $NewGameLoad
@onready var credits := $Credits
@onready var save_files := $SaveFiles
@onready var confirmation_panel := $ConfirmationPanel

@onready var main_menu_hitbox := get_parent().get_parent().get_node("StaticBody3D/CollisionShape3D")

# Called when the node enters the scene tree for the first time.
func _ready():
	open_main_menu()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func close_main_menu() -> void:
	visible = false
	main_menu_hitbox.disabled = true
	get_tree().paused = false


func open_main_menu() -> void:
	visible = true
	main_menu_hitbox.disabled = false
	get_tree().paused = true

func go_to_main() -> void:
	main.visible = true
	save_load.visible = false
	new_game_load.visible = false
	credits.visible = false
	save_files.visible = false
	confirmation_panel.visible = false

func go_to_save_load() -> void:
	main.visible = false
	save_load.visible = true
	new_game_load.visible = false
	credits.visible = false
	save_files.visible = false
	confirmation_panel.visible = false

func go_to_new_game_load() -> void:
	main.visible = false
	save_load.visible = false
	new_game_load.visible = true
	credits.visible = false
	save_files.visible = false
	confirmation_panel.visible = false

func go_to_credits() -> void:
	main.visible = false
	save_load.visible = false
	new_game_load.visible = false
	credits.visible = true
	save_files.visible = false
	confirmation_panel.visible = false

func go_to_save_files(is_new_game: bool, is_save_game: bool) -> void:
	save_files.is_new_game = is_new_game
	save_files.is_save_game = is_save_game
	main.visible = false
	save_load.visible = false
	new_game_load.visible = false
	credits.visible = false
	save_files.visible = true
	confirmation_panel.visible = false


func _on_start_game_pressed():
	go_to_new_game_load()


func _on_credits_pressed():
	go_to_credits()


func _on_new_game_pressed():
	go_to_save_files(true, false)


func _on_load_game_pressed():
	go_to_save_files(false, false)


func _on_back_pressed():
	go_to_main()



func _on_save_game_pressed():
	go_to_save_files(false, true)


func _on_in_game_load_game_pressed():
	go_to_save_files(false, false)
