extends Control

signal tutorial_page_changed(page_number : int)
signal tutorial_done()

@onready var tutorial_ui := get_parent().get_parent().get_parent()
@onready var game_world := get_tree().get_root().get_node("Demo/XRPlayer/XROrigin3D/PanoramaContainer")
@onready var shelf := get_tree().get_root().get_node("Demo/Shelf")
@onready var static_ui := get_tree().get_root().get_node("Demo/StaticUIContainer")
@onready var hitbox := get_parent().get_parent().get_node("StaticBody3D/CollisionShape3D")
@onready var tutorial_image := $TextureRect
@onready var next_only := $NextOnly
@onready var prev_next := $PrevNext
@onready var prev_done := $PrevDone

var page_array : Array = []

var current_page := 0

func _ready():
	tutorial_ui.visible = false
	current_page = 0
	await get_tree().create_timer(1).timeout
	hitbox.disabled = true


func start_tutorial(pages: Array) -> void:
	shelf.visible = false
	static_ui.visible = false
	tutorial_ui.visible = true
	hitbox.disabled = false
	current_page = 0
	page_array = pages
	change_page(current_page)
	print("tutorial started")

func change_page(idx : int) -> void:
	current_page = idx
	if current_page >= page_array.size() - 1:
		show_prev_done()
	elif current_page <= 0:
		show_next_only()
	else:
		show_prev_next()
	
	tutorial_image.texture = load("res://src/assets/Tutorials/" + page_array[current_page] + ".png")

func end_tutorial() -> void:
	shelf.visible = true
	static_ui.visible = true
	hitbox.disabled = true
	tutorial_ui.visible = false
	emit_signal("tutorial_done")


func show_next_only() -> void:
	next_only.visible = true
	prev_next.visible = false
	prev_done.visible = false


func show_prev_next() -> void:
	next_only.visible = false
	prev_next.visible = true
	prev_done.visible = false


func show_prev_done() -> void:
	next_only.visible = false
	prev_next.visible = false
	prev_done.visible = true


func _on_next_pressed():
	change_page(current_page + 1)


func _on_prev_pressed():
	change_page(current_page - 1)


func _on_done_pressed():
	end_tutorial()
