extends ReceiverObj

var interacting_inital_pos
var delta_dist_prev = 0
var total_delta_dist = 0
var buffer = 0.005
var past_progress = 0
@onready var mesh = $MeshInstance3D2
var default_material : Material
const white_hover = preload("res://src/ois/xx_demo_objects/white.tres")
const pet_the_cat_start = preload("res://src/assets/audio/tutorial/VE_VO_ZT_MRBLSPRT_11_HeyIt.ogg")
const pet_the_cat_ongoing = preload("res://src/assets/audio/tutorial/VE_VO_ZT_MRBLSPRT_12_DontCat.ogg")
const cat_asks_favor = preload("res://src/assets/audio/tutorial/VE_VO_ZT_MRBLSPRT_13_TheAsk.ogg")
const start_quest = preload("res://src/assets/audio/tutorial/VE_VO_ZT_MRBLSPRT_14_WhatAdventure.ogg")
var cat_petted = false
var event_done = false
@onready var audio_stream_player = $AudioStreamPlayer3D
@onready var timer = $Timer

func _ready():
	if !cat_petted:
		timer.start()
		initialize_event()
		print("start")

#func initialize_action_vars():
	#interacting_inital_pos = interacting_object.position
	#past_progress = total_progress
	#
	#delta_dist_prev = 0
	#total_delta_dist = 0

#func _process(_delta):
	#var interacting_current_pos = interacting_object.position
	#
	#var delta_dist = interacting_inital_pos.distance_to(interacting_current_pos)
	##print(str(interacting_inital_pos) + " - " + str(interacting_current_pos) + " = " + str(delta_dist))
	#var current_progress = total_delta_dist + delta_dist
		#
	#if(delta_dist < (delta_dist_prev-buffer)):
		#total_delta_dist += delta_dist
		#interacting_inital_pos = interacting_object.position
	#
	#delta_dist_prev = delta_dist
	#
	#total_progress = past_progress + (current_progress * rate);
	#print(total_progress)
	#
	#super(_delta)

# Handle pointer events
func pointer_event(event : XRToolsPointerEvent) -> void:
	if event.event_type == XRToolsPointerEvent.Type.ENTERED:
		print("hovering at cat")
		mesh.material_override = white_hover

	elif event.event_type == XRToolsPointerEvent.Type.EXITED:
		# When the pointer exits, no more material
		print("no longer hovering at cat")
		mesh.material_override = null

	elif event.event_type == XRToolsPointerEvent.Type.PRESSED:
		# You can still handle pressing if needed
		print("pointing at cat")
		cat_petted = true
		
func initialize_event():
	audio_stream_player.stream = pet_the_cat_start
	var length = audio_stream_player.stream.get_length()
	timer.wait_time = length + 3
	audio_stream_player.play()
	
func _on_timer_timeout():
	if !cat_petted:
		audio_stream_player.stream = pet_the_cat_ongoing
		var length = audio_stream_player.stream.get_length()
		timer.wait_time = length + 3
		audio_stream_player.play()
		
	if cat_petted and !event_done:
		audio_stream_player.stream = cat_asks_favor
		var length = audio_stream_player.stream.get_length()
		timer.wait_time = length + 1
		audio_stream_player.play()
		
		audio_stream_player.stream = start_quest
		length = audio_stream_player.stream.get_length()
		timer.wait_time = length + 1
		audio_stream_player.play()
		event_done = true
		
	if event_done:
		pass
