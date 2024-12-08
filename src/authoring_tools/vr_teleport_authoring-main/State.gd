extends Node

enum ActiveAuthoring {
	Teleport, Event, Demo
}

var active_authoring = ActiveAuthoring.Teleport

func _ready():
	Events.switch_requested.connect(_on_switch_requested)
	Events.demo_requested.connect(_on_demo_requested)
	Events.demo_exit_requested.connect(_on_demo_exit_requested)

func _on_switch_requested():
	if active_authoring == ActiveAuthoring.Teleport:
		active_authoring = ActiveAuthoring.Event
	else:
		active_authoring = ActiveAuthoring.Teleport

func _on_demo_requested(_a):
	active_authoring = ActiveAuthoring.Demo

func _on_demo_exit_requested():
	active_authoring = ActiveAuthoring.Teleport
