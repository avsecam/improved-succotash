extends Event

@onready var cat_tray := $"../../CatTray"

func _on_event_started():
	cat_tray.cat_tray_updated.connect(_on_cat_tray_inventory_updated)

func _on_cat_tray_inventory_updated():
	for element in cat_tray.inventory_array:
		if element != null:
			if element.name == "CubeCatCalico":
				print("The Key is In the Inventory")
				close_event()
