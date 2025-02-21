extends XRToolsPickable




func _on_dialogue_i_remember_this_thing_tree_exiting():
	if is_instance_valid(self):
		self.queue_free()
