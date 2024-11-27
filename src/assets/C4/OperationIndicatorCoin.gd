extends MeshInstance3D
@onready var coinmesh = $COINMESH
@onready var coin_sz = $CoinSZ
@onready var coin_finish_fr_ame = $CoinFinishFrAME

var boolredundance : bool

signal coin_in_frame

func _ready():
	coin_sz.enabled = false
	coin_finish_fr_ame.visible = false

func _on_action_coin_complete_tree_exiting():
	if !boolredundance:
		self.visible = true
		coin_sz.enabled = true

func _on_coin_sz_has_picked_up(what):
	coin_sz.enabled = false
	coinmesh.visible = false
	coin_in_frame.emit()

func _on_action_coin_in_frame_tree_exiting():
	coin_sz.enabled = false
	coinmesh.visible = false
	coin_finish_fr_ame.visible = true
