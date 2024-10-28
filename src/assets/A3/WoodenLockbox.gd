extends StaticBody3D

@onready var anim := $Wooden_Lockbox/AnimationPlayer


func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_combination_lock_interface_lock_solved():
	anim.play("open_lockbox")
