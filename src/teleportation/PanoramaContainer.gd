extends Node3D
@onready var circle_anim_player = $"../../XRPlayer/XROrigin3D/XRCamera3D/Circle/CircleAnimPlayer"

@onready var circleanimplayer := get_tree().get_root().get_node("Demo/XRPlayer/XROrigin3D/XRCamera3D/Circle/CircleAnimPlayer")
@onready var blessed_particles := get_tree().get_root().get_node("Demo/XRPlayer/XROrigin3D/XRCamera3D/Circle/BlessedParticles")
var new_level_name : String
var special_state_save : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("player_teleport_requested_trigger", _on_player_teleport_requested)
	
	# res://src/areas/<area_name>.tscn
	#var start_scene = preload("res://src/areas/Tut1.jpg.tscn").instantiate()
	#add_child(start_scene)

func _on_player_teleport_requested(new_level_filepath: String, special_state: bool):
	if special_state:
		circleanimplayer.play("circle_fade_in_special")
		special_state_save = special_state
		blessed_particles.emitting = true
	else:
		circleanimplayer.play("circle_fade_in")
		special_state_save = false
	
	new_level_name = str("res://src/areas/" + new_level_filepath + ".tscn")

func _on_circle_anim_player_animation_finished(anim_name):
	if special_state_save:
		if anim_name == "circle_fade_in_special":
			AudioHandler.play_sfx("UI_Tele_Confirm", null)
			get_child(0).queue_free()
			var new_level: Panorama = load(new_level_name).instantiate()
			self.rotation.y = new_level.base_rotation
			add_child(new_level)
			circleanimplayer.play("circle_fade_out_special")
	else:
		if anim_name == "circle_fade_in":
			AudioHandler.play_sfx("UI_Inventory_Toggle", null)
			get_child(0).queue_free()
			var new_level: Panorama = load(new_level_name).instantiate()
			self.rotation.y = new_level.base_rotation
			add_child(new_level)
			circleanimplayer.play("circle_fade_out")

func on_demand_play_fade_in():
	circleanimplayer.play("circle_fade_in_credits")
	
func on_demand_play_fade_out():
	circleanimplayer.play("circle_fade_out")

