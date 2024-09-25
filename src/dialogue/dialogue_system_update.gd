extends CenterContainer

@onready var npc_name_field := $MarginContainer/VBoxContainer/NPCName
@onready var dialogue_field := $MarginContainer/VBoxContainer/Dialogue

@export var is_open : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("update_dialogue_box", _update_dialogue)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _update_dialogue(npc_name : String, dialogue : String) -> void:
	npc_name_field.set_text("[center][b][i]" + npc_name)
	dialogue_field.set_text("[center]"+dialogue+"[/center]")


func _open_dialogue_box() -> void:
	if !is_open:
		pass


func _close_dialogue_box() -> void:
	if is_open:
		pass
