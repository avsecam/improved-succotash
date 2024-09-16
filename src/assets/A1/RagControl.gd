extends Node3D

@onready var clean_rag_mesh := $"../MainMesh/CleanRag"
@onready var oiled_rag_mesh := $"../MainMesh/Rag_Oiled"
@onready var clean_rag_inv_mesh := $"../InventoryItemComp/ReplacementMesh/MainMesh"
@onready var oiled_rag_inv_mesh := $"../InventoryItemComp/ReplacementMesh/Rag_Oiled"
@onready var state_manager := $"../StateManager"

@export var is_oiled = false

func _ready():
	if is_oiled:
		oiled_rag()
	else:
		clean_rag()


func clean_rag() -> void:
	clean_rag_mesh.visible = true
	clean_rag_inv_mesh.visible = true
	oiled_rag_mesh.visible = false
	oiled_rag_inv_mesh.visible = false
	state_manager.receiver_group = "clean_rag"

func oiled_rag() -> void:
	clean_rag_mesh.visible = false
	clean_rag_inv_mesh.visible = false
	oiled_rag_mesh.visible = true
	oiled_rag_inv_mesh.visible = true
	state_manager.receiver_group = "oiled_rag"


func _on_wax_receiver_action_completed(requirement, total_progress):
	if not Events.finished_events.has("ActionOiledRag_Done"):
		oiled_rag()
	else:
		print("I'm wasting rags")
