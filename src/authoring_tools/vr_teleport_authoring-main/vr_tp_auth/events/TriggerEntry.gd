class_name TriggerEntry
extends HBoxContainer

var trigger_name: String

func _ready():
	($StateButton as Button).pressed.connect(_on_StateButton_pressed)
	($DeleteButton as Button).pressed.connect(_on_DeleteButton_pressed)

func _process(_delta):
	if EventFlags.exists(self.trigger_name):
		if EventFlags.data[self.trigger_name]:
			$StateButton.text = "TRUE"
		else:
			$StateButton.text = "FALSE"
	else:
		$StateButton.text = "INV"

func set_trigger_name(new_name: String):
	trigger_name = new_name
	$Label.text = new_name

func _on_StateButton_pressed():
	Events.trigger_toggle_requested.emit(self.trigger_name)

func _on_DeleteButton_pressed():
	Events.trigger_delete_requested.emit(self.trigger_name)
