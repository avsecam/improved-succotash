extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.update_npc_name.connect(_on_update_npc_name)

func _on_update_npc_name(npcx):
	self.set_text("[center][b][i]"+npcx)
	print("Set NPC: "+npcx)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Events.update_npc_line.connect(_on_update_npc_name)
	pass
