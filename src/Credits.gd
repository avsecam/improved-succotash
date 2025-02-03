extends CenterContainer

signal update_line()

#@onready var credits := $VBoxContainer/RichTextLabel
@onready var animation_player = $AnimationPlayer

var is_scrolling = false
var line = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
	

func start_credits() -> void:
	animation_player.play("credits_play")






