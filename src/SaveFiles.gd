extends CenterContainer

@onready var main_menu := get_parent()
@onready var confirmation_panel := $"../ConfirmationPanel"
@onready var confirmation_panel_label := $"../ConfirmationPanel/VBoxContainer/Label"

@onready var save_file_1 := $VBoxContainer/SaveFile
@onready var save_file_2 := $VBoxContainer/SaveFile2
@onready var save_file_3 := $VBoxContainer/SaveFile3

var is_new_game : bool = true
var is_save_game : bool = false
var in_game : bool = false

var currently_selected_slot : int = 0

func _ready():
	SaveSystem.set_saveslot_info(save_file_1)
	SaveSystem.set_saveslot_info(save_file_2)
	SaveSystem.set_saveslot_info(save_file_3)
	is_save_game = false


func update_saveslot_info() -> void:
	SaveSystem.set_saveslot_info(save_file_1)
	SaveSystem.set_saveslot_info(save_file_2)
	SaveSystem.set_saveslot_info(save_file_3)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func open_confirmation_panel() -> void:
	confirmation_panel.visible = true
	save_file_1.disabled = true
	save_file_2.disabled = true
	save_file_3.disabled = true


func close_confirmation_panel() -> void:
	confirmation_panel.visible = false
	save_file_1.disabled = false
	save_file_2.disabled = false
	save_file_3.disabled = false

func _on_save_file_pressed():
	if is_new_game:
		if save_file_1.has_savedata:
			confirmation_panel_label.set_text("Overwrite Save?")
		else:
			confirmation_panel_label.set_text("Start New Game?")
	elif is_save_game:
		if save_file_1.has_savedata:
			confirmation_panel_label.set_text("Overwrite Save?")
		else:
			confirmation_panel_label.set_text("Save Game?")
	else:
		confirmation_panel_label.set_text("Load Save?")
	
	currently_selected_slot = save_file_1.slot_number
	open_confirmation_panel()


func _on_save_file_2_pressed():
	if is_new_game:
		if save_file_2.has_savedata:
			confirmation_panel_label.set_text("Overwrite Save?")
		else:
			confirmation_panel_label.set_text("Start New Game?")
	elif is_save_game:
		if save_file_2.has_savedata:
			confirmation_panel_label.set_text("Overwrite Save?")
		else:
			confirmation_panel_label.set_text("Save Game?")
	else:
		confirmation_panel_label.set_text("Load Save?")
	
	currently_selected_slot = save_file_2.slot_number
	open_confirmation_panel()


func _on_save_file_3_pressed():
	if is_new_game:
		if save_file_3.has_savedata:
			confirmation_panel_label.set_text("Overwrite Save?")
		else:
			confirmation_panel_label.set_text("Start New Game?")
	elif is_save_game:
		if save_file_3.has_savedata:
			confirmation_panel_label.set_text("Overwrite Save?")
		else:
			confirmation_panel_label.set_text("Save Game?")
	else:
		confirmation_panel_label.set_text("Load Save?")
	
	currently_selected_slot = save_file_3.slot_number
	open_confirmation_panel()


func _on_back_button_pressed():
	close_confirmation_panel()


func _on_confirm_button_pressed():
	main_menu.close_main_menu()
	if is_new_game:
		SaveSystem.new_game(currently_selected_slot)
		is_new_game = false
		in_game = true
	elif is_save_game:
		SaveSystem.save_game(currently_selected_slot)
		update_saveslot_info()
		in_game = true
	else:
		SaveSystem.load_game(currently_selected_slot, in_game)
		in_game = true
	close_confirmation_panel()
