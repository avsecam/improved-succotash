extends CenterContainer

@onready var tutorial_ui := get_tree().get_root().get_node("/root/Demo/TutorialUI/Viewport2Din3D/Viewport/TutorialScreen")
@onready var main_menu := get_parent()
@onready var navigation := $VBoxContainer/Navigation
@onready var grabbing := $VBoxContainer/Grabbing
@onready var inventory := $VBoxContainer/Inventory
@onready var wipe_action := $VBoxContainer/WipeAction
@onready var twist_action := $VBoxContainer/TwistAction
@onready var strike_action := $VBoxContainer/StrikeAction
@onready var menu := $VBoxContainer/Menu

# Called when the node enters the scene tree for the first time.
func _ready():
	navigation.visible = false
	grabbing.visible = false
	inventory.visible = false
	wipe_action.visible = false
	twist_action.visible = false
	strike_action.visible = false
	menu.visible = false


func check_tutorial_availability() -> void:
	if Events.finished_events.has("TutorialNavigation_Done"):
		navigation.visible = true
	if Events.finished_events.has("TutorialGrabbing_Done"):
		grabbing.visible = true
	if Events.finished_events.has("TutorialInventory_Done"):
		inventory.visible = true
	if Events.finished_events.has("TutorialWipe_Done"):
		wipe_action.visible = true
	if Events.finished_events.has("TutorialTwist_Done"):
		twist_action.visible = true
	if Events.finished_events.has("TutorialStrike_Done"):
		strike_action.visible = true
	if Events.finished_events.has("TutorialMenu_Done"):
		menu.visible = true


func _on_navigation_pressed():
	main_menu.close_main_menu()
	tutorial_ui.start_tutorial(Events.event_library["TutorialNavigation"]["Event_Text"]["tutorial_pages"])


func _on_grabbing_pressed():
	main_menu.close_main_menu()
	tutorial_ui.start_tutorial(Events.event_library["TutorialGrabbing"]["Event_Text"]["tutorial_pages"])


func _on_inventory_pressed():
	main_menu.close_main_menu()
	tutorial_ui.start_tutorial(Events.event_library["TutorialInventory"]["Event_Text"]["tutorial_pages"])


func _on_wipe_action_pressed():
	main_menu.close_main_menu()
	tutorial_ui.start_tutorial(Events.event_library["TutorialWipe"]["Event_Text"]["tutorial_pages"])


func _on_twist_action_pressed():
	main_menu.close_main_menu()
	tutorial_ui.start_tutorial(Events.event_library["TutorialTwist"]["Event_Text"]["tutorial_pages"])


func _on_strike_action_pressed():
	main_menu.close_main_menu()
	tutorial_ui.start_tutorial(Events.event_library["TutorialStrike"]["Event_Text"]["tutorial_pages"])


func _on_menu_pressed():
	main_menu.close_main_menu()
	tutorial_ui.start_tutorial(Events.event_library["TutorialMenu"]["Event_Text"]["tutorial_pages"])
