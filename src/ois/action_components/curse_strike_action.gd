extends "res://src/ois/action_components/strike_action.gd"

@onready var cursed_particles = $CursedParticles
signal purify_hint_event_end

func _on_associated_event_finished():
	print("AJSDKLASDJALDKSJDSLKDLSAJKKLJADJKLDASKJLDASKLJADSKLJASDJLKDSAJKLSADJKLASDKJLSAD")
	queue_free()


func _on_action_clean_dirt_from_hint_tree_exiting():
	cursed_particles.visible = true

func _on_feedback_cursed_floor_purified():
	purify_hint_event_end.emit()
