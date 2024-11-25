extends XRToolsPickable
@onready var animation_player = $AnimationPlayer

func _set_coin_complete():
	animation_player.play("coin_cooling")
