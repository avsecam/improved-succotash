extends Control


@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.player_teleport_requested_trigger.connect(_on_player_teleport_requested_trigger)
	Events.player_rotate_requested.connect(_on_player_rotate_requested)

func _blink():
	animation_player.play_backwards("fade")

func _on_player_teleport_requested_trigger(_a):
	_blink()

func _on_player_rotate_requested():
	_blink()
