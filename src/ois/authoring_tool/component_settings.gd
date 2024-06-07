extends Control
class_name ComponentSettings

const export_property_usage_flag = 4102 #flag indicating exported variables

var component
@onready var comp_label = $MarginContainer/Main/Name
@onready var main_cont = $MarginContainer/Main

func set_component(component, component_name):
	print(comp_label)
	comp_label.text = component_name
	self.component = component
	var properties = component.get_property_list()
	#print(properties)
	
	# creates gui for exported properties
	for prop in properties:
		if prop.usage == export_property_usage_flag:
			print(prop)
			add_property_setting(prop, component)

# add gui for property depending on its type
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
			cb.toggled.connect(func(x): obj.set(prop.name, x))
		
		2: #type int
			var spin_box = SpinBox.new()
			spin_box.step = 1
			spin_box.value = obj.get(prop.name)
			box_cont.add_child(spin_box)
			
			var btn = Button.new()
			btn.set_text("✓")
			box_cont.add_child(btn)
			btn.pressed.connect(func(): obj.set(prop.name, spin_box.value))
			
		3: #type float
			var spin_box = SpinBox.new()
			spin_box.step = 0.01
			spin_box.value = obj.get(prop.name)
			box_cont.add_child(spin_box)
			# add connection
			
			var btn = Button.new()
			btn.set_text("✓")
			box_cont.add_child(btn)
			btn.pressed.connect(func(): obj.set(prop.name, spin_box.value))
		
		4: #type string
			var line_edit = LineEdit.new()
			line_edit.text = obj.get(prop.name)
			box_cont.add_child(line_edit)
			
			var btn = Button.new()
			btn.set_text("✓")
			box_cont.add_child(btn)
			btn.pressed.connect(func(): obj.set(prop.name, line_edit.text))
			
		24: #type object
			print("obj")
