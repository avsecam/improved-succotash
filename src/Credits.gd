extends CenterContainer

signal update_line()

@onready var credits := $VBoxContainer/RichTextLabel

var is_scrolling = false
var line = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	credits.set_scroll_follow(false)
	line = 0
	

func start_credits() -> void:
	credits.set_scroll_follow(true)
	credits.scroll_to_line(0)
	
	var line_count = credits.get_line_count()
	
	for i in line_count:
		await get_tree().create_timer(0.25).timeout
		credits.scroll_to_line(i)





