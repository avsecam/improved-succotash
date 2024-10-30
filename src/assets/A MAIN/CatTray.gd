extends Node3D

signal cat_tray_updated()

@export var inventory_array = []
@export var inventory_size : int
var start_inv_array = []


func _ready():
	start_inv_array = get_tree().get_nodes_in_group("cat_tray_inventory")
	inventory_size = start_inv_array.size()
	load_cat_tray()

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
