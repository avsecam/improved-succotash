extends Control
class_name ActionCompSettings

const export_property_usage_flag = 4102 #flag indicating exported variables

@onready var main_cont = $MarginContainer/Main

func _ready():
	var properties = get_property_list()
	for prop in properties:
		if prop.usage == export_property_usage_flag:
			print(prop)
			add_property_setting(prop, self)

func add_property_setting(prop, obj):
	var box_cont = BoxContainer.new()
	main_cont.add_child(box_cont)
	
	var prop_label = Label.new()
	prop_label.set_text(prop.name)
	box_cont.add_child(prop_label)
	
	match prop.type:
		1: #type bool
			var cb = CheckBox.new()
			cb.button_pressed = obj.get(prop.name)
			box_cont.add_child(cb)
			# add connection
		
		2: #type int
			var spin_box = SpinBox.new()
			spin_box.step = 1
			spin_box.value = obj.get(prop.name)
			box_cont.add_child(spin_box)
			# add connection
			
			var btn = Button.new()
			btn.set_text("✓")
			box_cont.add_child(btn)
			
		3: #type float
			var spin_box = SpinBox.new()
			spin_box.step = 0.01
			spin_box.value = obj.get(prop.name)
			box_cont.add_child(spin_box)
			# add connection
			
			var btn = Button.new()
			btn.set_text("✓")
			box_cont.add_child(btn)
			
		24: #type object
			print("obj")
	
