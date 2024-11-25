extends Node3D


@onready var interactable_slider = $SliderOrigin/InteractableSlider
@onready var fuelle = $kk_modified_forge_bellow/Fuelle

@onready var blow_particles = $BlowParticles
@onready var smoke = $Smoke

@onready var ember_particles = preload("res://src/assets/C4/blow_particles.tscn")
@onready var flame_heat_view = $FlameHeatView
@onready var bar_shade = $"FlameHeatView/Viewport2Din3D/Viewport/Progress Circle2/ProgressCircleComponent"


@onready var crucible_mid_air_collider = $StaticBody3D/CrucibleMidAirCollider
@onready var forge_snap_zone_collider = $ForgeSnapZone/CollisionShape3D
@onready var forge_snap_zone = $ForgeSnapZone

signal crucible_in_forge
signal crucible_removed
signal enough_heat_in_forge
signal not_enough_heat_in_forge

var keyval : float
var keyval_check : bool
var smoke_check : bool
var heat_level : float

func _ready():
	heat_level = 0
	flame_heat_view.visible = false
	

func _physics_process(delta):
	var slider_position = interactable_slider.slider_position
	var slider_limit_max = interactable_slider.slider_limit_max
	
	keyval = 1-(1*(slider_position/slider_limit_max))	
	fuelle.set("blend_shapes/FuellePush",keyval)
	
	if heat_level > 0:
		flame_heat_view.visible = true
	else: 
		flame_heat_view.visible = false
	
	if keyval >= 0.5:
		if !smoke_check:
			smoke.restart()
			
			var ember = ember_particles.instantiate()
			add_child(ember)
			#ember.position = Vector3(0.35,-0.05,0)
			
			if (heat_level + 10) < 100:
				heat_level += 10
			else:
				heat_level = 100
			
			smoke.emitting = true
		smoke_check = true
	
	if keyval < 0.5:
		smoke_check = false
		
	if heat_level >= 70:
		bar_shade.set("tint_progress", Color8(0,255,215))
		enough_heat_in_forge.emit()
	else:
		bar_shade.set("tint_progress", Color8(255,170,160))
		not_enough_heat_in_forge.emit()
	
	if heat_level > 0:
		heat_level -= 0.06
	
	flame_heat_view.change_progress_value(heat_level)
	

func _on_forge_snap_zone_has_picked_up(what):
	crucible_in_forge.emit()

func _on_forge_snap_zone_has_dropped():
	crucible_removed.emit()

func _on_small_crucible_ingot_is_melted():
	forge_snap_zone.drop_object()
	forge_snap_zone_collider.disabled = true
	crucible_mid_air_collider.disabled = false
