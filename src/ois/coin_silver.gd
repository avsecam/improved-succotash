extends XRToolsPickable
@onready var animation_player = $AnimationPlayer

func _set_coin_complete():
	animation_player.play("coin_cooling")

func _on_action_coin_in_frame_tree_exiting():
	self.queue_free()
