extends XRToolsPickable


@onready var main_calico := $MainMesh/Cube_CalicoCat
@onready var main_orange := $MainMesh/Cube_OrangeCat
@onready var main_spotted := $MainMesh/Cube_SpottedCat

@onready var inv_calico := $InventoryItemComp/ReplacementMesh/Cube_CalicoCat
@onready var inv_orange := $InventoryItemComp/ReplacementMesh/Cube_OrangeCat
@onready var inv_spotted := $InventoryItemComp/ReplacementMesh/Cube_SpottedCat 

@export_enum("CALICO", "ORANGE", "SPOTTED") var type := "CALICO"


func _ready():
	if type == "CALICO":
		is_calico()
	elif type == "ORANGE":
		is_orange()
	elif type == "SPOTTED":
		is_spotted()


func is_calico() -> void:
	main_calico.visible = true
	inv_calico.visible = true
	main_orange.visible = false
	inv_orange.visible = false
	main_spotted.visible = false
	inv_spotted.visible = false


func is_orange() -> void:
	main_calico.visible = false
	inv_calico.visible = false
	main_orange.visible = true
	inv_orange.visible = true
	main_spotted.visible = false
	inv_spotted.visible = false


func is_spotted() -> void:
	main_calico.visible = false
	inv_calico.visible = false
	main_orange.visible = false
	inv_orange.visible = false
	main_spotted.visible = true
	inv_spotted.visible = true
