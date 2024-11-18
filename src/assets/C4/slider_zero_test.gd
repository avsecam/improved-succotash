extends Node3D


@onready var interactable_slider = $SliderOrigin/InteractableSlider
@onready var fuelle = $kk_modified_forge_bellow/Fuelle

@onready var blow_particles = $BlowParticles
@onready var smoke = $Smoke

@onready var ember_particles = preload("res://src/assets/C4/blow_particles.tscn")
@onready var flame_heat_view = $FlameHeatView
@onready var bar_shade = $"FlameHeatView/Viewport2Din3D/Viewport/Progress Circle2/ProgressCircleComponent"


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
			add_child(ember_particles.instantiate())
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
	else:
		bar_shade.set("tint_progress", Color8(255,170,160))
	
	if heat_level > 0:
		heat_level -= 0.06
	
	flame_heat_view.change_progress_value(heat_level)
	
