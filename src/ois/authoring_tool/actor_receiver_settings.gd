extends Resource
class_name ActorReceiverSettings

@export var receiver_groups : Array[String]

func add_receiver_group(receiver_group : String):
	if !receiver_groups.has(receiver_group):
		receiver_groups.append(receiver_group)

func check_group_exists(receiver_group : String):
	return receiver_groups.has(receiver_group)

func save():
	ResourceSaver.save(self, self.resource_path)

# TODO: Make tool script to update settings according to created objects
# TODO: Consider keeping track of which objects are in what group
