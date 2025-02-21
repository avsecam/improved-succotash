extends XRToolsInteractableArea
@onready var howitzer_round = $"../../howitzer_round"
@onready var round_slot = $"../Howitzer_Round_slot"
signal loaded_howitzer
signal fire_howitzer
@onready var dark_crystal = $"../../DistortionCrystal10/MainMesh/Dark_Crystal"
var loaded = false
@onready var ambient_animation_player = $"../../ExplosionAmbientLight/AnimationPlayer"
@onready var progress_view = $"../Progress View"
@export var timer_duration := 0.5
var timer_duration_x
@onready var explosion_sound = $"../../ExplosionAmbientLight/ExplosionSound"
@onready var howitzer_shot = $"../../ExplosionAmbientLight/HowitzerShot"

@onready var explosion_particles_smoke = $"../../ExplosionParticlesSmoke"
@onready var blow_particles = $"../../BlowParticles"
@onready var explosion_ambient_light = $"../../ExplosionAmbientLight"
@onready var huge_crystal_distortion = $"../../DistortionCrystal10/MagicalDistortion/GPUParticles3D"
@onready var smoke = $"../../Smoke"
@onready var howitzer_boom = $"../../HowitzerBoom"

@onready var parent_node = self.get_parent().get_parent()

func _ready():
	timer_duration_x = timer_duration

func _on_body_entered(body):
	if body == howitzer_round:
		howitzer_round.queue_free()
		parent_node._on_release()
		round_slot.visible = true
		loaded_howitzer.emit()
		loaded = true
		
func _physics_process(delta):
	if progress_view.visible:
		timer_duration_x -= delta
		progress_view.change_progress_value((timer_duration - timer_duration_x)/timer_duration*100)
		

func _on_pointer_event(event):
	if event.event_type == XRToolsPointerEvent.Type.PRESSED and loaded:
		AudioHandler.play_sfx("C_Howitzer", null)
		howitzer_shot.play()
		round_slot.visible = false
		loaded = false
		progress_view.visible = true
		await get_tree().create_timer(0.5).timeout
		
		explosion_particles_smoke.visible = true
		blow_particles.visible = true
		explosion_ambient_light.visible = true
		smoke.visible = true
		howitzer_boom.visible = true
		
		progress_view.visible = false
		
		dark_crystal.anim.play("smash")
		ambient_animation_player.play("ExplosionLight")
		explosion_sound.play()
		huge_crystal_distortion.emitting = false
		AudioHandler.play_sfx("A_CrystalShatter", $"../AudioStreamPlayer3D")
		await dark_crystal.anim.animation_finished
		fire_howitzer.emit()
		dark_crystal.get_parent().get_parent().queue_free()
