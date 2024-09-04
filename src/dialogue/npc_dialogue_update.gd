extends RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.update_npc_line.connect(_on_update_npc_line)

func _on_update_npc_line(line):
	self.set_text("[center]"+line+"[/center]")
	print("Set text: "+line)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Events.update_npc_line.connect(_on_update_npc_line)
	pass
