extends Panorama

@onready var next_tele = $Teleporters/Img2024032114013000113PureShot_jpg

func _on_cat_cat_event_done():
	next_tele.enabled = true
	next_tele.visible = true
