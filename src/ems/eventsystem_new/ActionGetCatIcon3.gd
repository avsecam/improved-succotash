extends Event

@onready var cat_icon := $"../../CubeCatSpotted"
@onready var cat_icon_hitbox := $"../../CubeCatSpotted/CollisionShape3D"
@onready var cat_effector = $"../../CubeCatSpotted/CatEffector"

func _on_event_started():
	cat_icon.process_mode = Node.PROCESS_MODE_INHERIT
	cat_icon.visible = true
	cat_effector.cat_icon_appear()
	cat_icon_hitbox.disabled = false


func _on_cube_cat_spotted_picked_up(pickable):
	close_event()
