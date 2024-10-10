extends Event

@onready var cat_hitbox := $"../../Cat/CollisionShape3D"
@onready var cat := $"../../Cat"

func _on_event_started():
	cat.action_completed.connect(_on_cat_action_ended)
	cat_hitbox.disabled = false
	await get_tree().create_timer(loop_interval).timeout
	play_event_audio()
	
func _on_cat_pet_event_done():
	close_event()


func _on_cat_action_ended(wannrequirement, total_progress):
	close_event()
