extends Camera2D

@export var move_speed: float = 10
@export var zoom_speed: float = 0.05

@onready var authoring: TeleportAuthor = %TeleportAuthor

func _ready():
	Events.teleport_node_enter_requested.connect(_on_teleport_node_enter_requested)
	Events.teleport_node_exit_requested.connect(_on_teleport_node_exit_requested)
	
	Events.demo_requested.connect(_on_demo_requested)
	Events.demo_exit_requested.connect(_on_demo_exit_requested)

func _process(delta):
	if authoring.in_edit_node_mode or StateAuth.active_authoring == StateAuth.ActiveAuthoring.Demo:
		return
	
	if Input.is_action_pressed("ui_left"):
		self.position.x -= move_speed
	if Input.is_action_pressed("ui_right"):
		self.position.x += move_speed
	if Input.is_action_pressed("ui_up"):
		self.position.y -= move_speed
	if Input.is_action_pressed("ui_down"):
		self.position.y += move_speed
	
	if Input.is_action_just_pressed("mouse_scroll_down"):
		self.zoom = Vector2(self.zoom.x - zoom_speed, self.zoom.y - zoom_speed)
	if Input.is_action_just_pressed("mouse_scroll_up"):
		self.zoom = Vector2(self.zoom.x + zoom_speed, self.zoom.y + zoom_speed)

func _on_teleport_node_enter_requested(_a):
	self.visible = false

func _on_teleport_node_exit_requested(_a):
	self.visible = true

func _on_demo_requested(_a):
	self.visible = false

func _on_demo_exit_requested():
	self.visible = true
