extends StaticBody3D

@onready var pole_visible = $MainMesh/Pit/pole_bamboo_chicken_roastpit

var time : float
var progress_bool : bool
@onready var progress_view = $"Progress View"
@onready var snap_zone = $SnapZone
@onready var animation_player = $AnimationPlayer
@onready var fire_wood = $MainMesh/Pit/FireWood

var c1 : bool
var c2 : bool

signal pole_inserted_inventory

func _ready():
	snap_zone.enabled = false
	pole_visible.visible = false
	animation_player.play("roast_spin")
	c1 = false
	c2 = false

func _physics_process(delta):
	if c1 and c2:
		if !Events.finished_events.has("ActionAfterChickenSkewer_Done"):
			snap_zone.enabled = true
	

func _on_associated_event_finished():
	pole_visible.visible = true
	progress_bool = true
	animation_player.play("roast_spin")
	
func _on_associated_event_finished_first_time():
	progress_view.visible = true
	progress_view.progress_complete_checkmark_only_anim()

func _on_snap_zone_has_picked_up(what):
	what.chicken_1.picked_up_object.queue_free()
	what.chicken_2.picked_up_object.queue_free()
	#snap_zone.picked_up_object.queue_free()
	pole_inserted_inventory.emit()
	_on_associated_event_finished_first_time()
	what.visible = false
	snap_zone.enabled = false
	pole_visible.visible = true
	
func _on_action_put_chicken_pole_2_tree_exiting():
	c2 = true

func _on_action_put_chicken_pole_1_tree_exiting():
	c1 = true
