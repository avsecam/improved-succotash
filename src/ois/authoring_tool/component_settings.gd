extends Control
class_name ComponentSettings

const export_property_usage_flag = 4102 #flag indicating exported variables

var component
@onready var comp_label = $MarginContainer/Main/BoxContainer/RenameStartCont/Name
@onready var main_cont = $MarginContainer/Main
@onready var btn_delete = $MarginContainer/Main/BoxContainer/BtnDelete

@onready var btn_rename = $MarginContainer/Main/BoxContainer/RenameInProgressCont/BtnRename
@onready var btn_rename_start = $MarginContainer/Main/BoxContainer/RenameStartCont/BtnStartRename
@onready var rename_in_progress_cont = $MarginContainer/Main/BoxContainer/RenameInProgressCont
@onready var rename_start_cont = $MarginContainer/Main/BoxContainer/RenameStartCont
@onready var new_name_input = $MarginContainer/Main/BoxContainer/RenameInProgressCont/EditNewName

func set_component(component, component_name, delete_function = null, rename_function = null):
	comp_label.text = component_name
	if component != null:
		self.component = component
		var properties = component.get_property_list()
		#print(properties)
		
		# creates gui for exported properties
		for prop in properties:
			if prop.usage == export_property_usage_flag:
				print(prop)
				add_property_setting(prop, component)
	
	# Connect delete and rename functions
	if delete_function == null:
		btn_delete.visible = false
	else:
		btn_delete.pressed.connect(delete_function)
	
	rename_in_progress_cont.visible = false
	if rename_function == null:
		btn_rename_start.visible = false
	else:
		btn_rename.pressed.connect(func():
			rename_function.call(new_name_input.text)
			rename_component_settings()
			)

func _on_btn_start_rename_pressed():
	rename_start_cont.visible = false
	rename_in_progress_cont.visible = true
	new_name_input.text = component.name

func rename_component_settings():
	comp_label.text = component.name
	rename_in_progress_cont.visible = false
	rename_start_cont.visible = true

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
		
		9: #type Vector3
			var spin_box_x = SpinBox.new()
			var spin_box_y = SpinBox.new()
			var spin_box_z = SpinBox.new()
			
			spin_box_x.value = obj.get(prop.name).x
			spin_box_y.value = obj.get(prop.name).y
			spin_box_z.value = obj.get(prop.name).z
			
			box_cont.add_child(spin_box_x)
			box_cont.add_child(spin_box_y)
			box_cont.add_child(spin_box_z)
			
			var btn = Button.new()
			btn.set_text("✓")
			box_cont.add_child(btn)
			btn.pressed.connect(func(): obj.set(prop.name, Vector3(spin_box_x.value, spin_box_y.value, spin_box_z.value))) 
		
		24: #type object
			print("obj")

