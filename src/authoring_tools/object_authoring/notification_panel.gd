extends PanelContainer

func _ready():
	visible = false

func _on_timer_timeout():
	visible = false

func show_notification(text : String):
	$MarginContainer/Label.text = text
	visible = true
	$Timer.start()
