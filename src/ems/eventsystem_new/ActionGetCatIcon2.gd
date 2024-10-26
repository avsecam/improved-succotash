extends Event

@onready var cat_icon := $"../../CubeCatOrange"
@onready var cat_icon_hitbox := $"../../CubeCatOrange/CollisionShape3D"

func _on_event_started():
	cat_icon.process_mode = Node.PROCESS_MODE_INHERIT
	cat_icon.visible = true
	cat_icon_hitbox.disabled = false


func _on_cube_cat_calico_picked_up(pickable):
	close_event()
