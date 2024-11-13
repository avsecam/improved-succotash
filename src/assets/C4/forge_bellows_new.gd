extends Node3D

@onready var interactable_slider = $SliderOrigin2/InteractableSlider
@onready var fuelle = $Fuelle2
@export var keyval = 0

func _physics_process(delta):
	
	var slider_position = interactable_slider.slider_position
	var slider_limit_max = interactable_slider.slider_limit_max
	
	keyval = (1*(slider_position/slider_limit_max))
	print("sliderkeyval value: "+ str(keyval))
	fuelle.set("blend_shapes/FuellePush",keyval)
