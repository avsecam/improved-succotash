extends XRToolsInteractableArea

@onready var anim := $"../AnimationPlayer"
@onready var particles := $"../GPUParticles3D"
@onready var slot1 := $"../Slot"
@onready var slot2 := $"../Slot2" 
@onready var slot3 := $"../Slot3"
@onready var slot4 := $"../Slot4"
@onready var slot5 := $"../Slot5"
@onready var slot6 := $"../Slot6" 
@onready var leaves := $"../EarthSpirit_InventoryShelf/leaves"
@onready var branch := $"../EarthSpirit_InventoryShelf/Branch"
@onready var back := $"../EarthSpirit_InventoryShelf/Back"


var inventory_open := true
# Called when the node enters the scene tree for the first time.
func _ready():
	inventory_visible(inventory_open)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func inventory_visible(b : bool) -> void:
	if b:
		slot1.visible = true
		slot2.visible = true
		slot3.visible = true
		slot4.visible = true
		slot5.visible = true
		slot6.visible = true
		leaves.visible = true
		branch.visible = true
		back.visible = true
	else:
		slot1.visible = false
		slot2.visible = false
		slot3.visible = false
		slot4.visible = false
		slot5.visible = false
		slot6.visible = false
		leaves.visible = false
		branch.visible = false
		back.visible = false

func _on_pointer_event(event):
	if event.event_type == XRToolsPointerEvent.Type.PRESSED:
		if !particles.emitting:
			if inventory_open:
				anim.play("close_inventory")
				inventory_open = false
			else:
				anim.play("open_inventory")
				inventory_open = true
		else:
			print("ongoing inventory animation")
		
