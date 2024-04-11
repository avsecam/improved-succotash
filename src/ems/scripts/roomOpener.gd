extends RigidBody3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

var roomOpen = false


#func _on_color_lock_toggled(switch):
	#if switch == true and roomOpen == false:
		#roomOpen = true
		#$AnimationPlayer.play("Open")
	#if switch == false and roomOpen == true:
		#roomOpen = false
		#$AnimationPlayer.play("Close")

var lock0 = false
var lock1 = false
var lock2 = false

func _on_color_lock_toggled(switch):
	if switch == true and lock0 == false:
		lock0 = true
	if switch == false and lock0 == true:
		lock0 = false
	checkLocks()

func _on_color_lock_2_toggled(switch):
	if switch == true and lock1 == false:
		lock1 = true
	if switch == false and lock1 == true:
		lock1 = false
	checkLocks()

func _on_color_lock_3_toggled(switch):
	if switch == true and lock2 == false:
		lock2 = true
	if switch == false and lock2 == true:
		lock2 = false
	checkLocks()

func checkLocks():
	var check = lock0 == true and lock1 == true and lock2 == true
	if check == true and roomOpen == false:
		roomOpen = true
		$AnimationPlayer.play("Open")
	if check == false and roomOpen == true:
		roomOpen = false
		$AnimationPlayer.play("Close")
