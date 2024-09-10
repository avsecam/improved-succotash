extends Node
class_name Quest

signal quest_started()
signal quest_ended()

var quest_name : String
var quest_description : Dictionary
var quest_completion_requirements : Array


func _ready():
	pass

func initialize_quest():
	print(name + "Started")
