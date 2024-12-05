extends Control

@onready var animation_player = $AnimationPlayer

func _ready():
	await get_tree().create_timer(2).timeout
	animation_player.play("PlayCredits")
