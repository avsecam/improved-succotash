extends Area3D

@onready var can_see = $VisibleOnScreenNotifier3D
@onready var voice_prompt_timer = $VoicePromptTimer
@onready var look_here = $"Look Here"
# Voices
@onready var see_me = $"See Me"
var alreadySeen = false

# Called when the node enters the scene tree for the first time.
func _ready():
	voice_prompt_timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (can_see.is_on_screen() && alreadySeen):
		alreadySeen = true
		
func _on_voice_prompt_timer_timeout():
	if (!alreadySeen):
		see_me.play()
	

func _on_see_me_finished():
	await get_tree().create_timer(1).timeout
	print("already seen:" + str(alreadySeen))
	if (!can_see.is_on_screen()):
		look_here.play()

