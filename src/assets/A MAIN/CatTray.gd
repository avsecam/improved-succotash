extends Node3D

signal cat_tray_updated()
@onready var cats = $Cats

@export var inventory_array = []
@export var inventory_size : int
var start_inv_array = []

@onready var snap1_zone = $Slot/SnapZone
@onready var snap3_zone = $Slot3/SnapZone
@onready var snap2_zone = $Slot2/SnapZone
@onready var slot = $Slot
@onready var slot_3 = $Slot3
@onready var slot_2 = $Slot2

@onready var cube_cat_orange = $Cats/CubeCatOrange
@onready var cube_cat_spotted = $Cats/CubeCatSpotted
@onready var cube_cat_calico = $Cats/CubeCatCalico

func _ready():
	start_inv_array = get_tree().get_nodes_in_group("cat_tray_inventory")
	inventory_size = start_inv_array.size()
	load_cat_tray()
	cats.visible = true

func load_cat_tray():
	for slot in Events.cat_tray_content:
		if Events.cat_tray_content[slot] != null:
			var item = load(Events.cat_tray_content[slot]).instantiate()
			get_node(slot).get_node("Inventory Content").add_child(item)
			get_node(slot).get_node("SnapZone").pick_up_object(item)

func update_cat_tray():
	for slot in get_children():
		if slot.is_in_group("cat_tray_inventory"):
			if slot.get_node("Inventory Content").get_child_count() != 0:
				Events.cat_tray_content[slot.name] = slot.get_node("Inventory Content").get_child(0).get_scene_file_path()
			else:
				Events.cat_tray_content[slot.name]

func check_contents():
	inventory_array.clear()
	print("ICat Tray CLEAR:" + str(inventory_array.size()))
	for i in start_inv_array:
		if i.get_node("Inventory Content").get_child_count() != 0:
			inventory_array.append(i.get_node("Inventory Content").get_child(0))
		else:
			var object = null
			inventory_array.append(object)
	print("Inventory system item count:" + str(inventory_array.size()))
	for i in inventory_array:
		if i != null:
			print("Cat Tray Slot: "+i.name)
		else:
			print("No object in Slot")

func _on_snap_zone_body_entered(body):
	emit_signal("cat_tray_updated")
	check_contents()


func _on_dialogue_finish_cat_icons_placement_tree_exiting():
	cats.visible = true
	#snap1_zone.enabled = false
	#snap3_zone.enabled = false
	#snap2_zone.enabled = false
	#slot.visible = false
	#slot_3.visible = false
	#slot_2.visible = false
	
func _on_act_place_cat_orange():
	cube_cat_orange.visible = true
	#snap1_zone.enabled = false
	#slot.visible = false
	
func _on_act_place_cat_spotted():
	cube_cat_spotted.visible = true
	#snap2_zone.enabled = false
	#slot_2.visible = false
	
func _on_act_place_cat_calico():
	cube_cat_calico.visible = true
	#snap3_zone.enabled = false
	#slot_3.visible = false
	
