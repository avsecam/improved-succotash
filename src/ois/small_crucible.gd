extends XRToolsPickable

@onready var melted_iron = $MainMesh/MeltedIron
@onready var blow_particles = $MainMesh/MeltedIron/BlowParticles

func _ready():
	super()
	blow_particles.emitting = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if melted_iron.visible:
		print("Crucible Z angle:" + str(self.rotation_degrees.z))
		# max rotation is up to 1800deg
		for x in range(-2,2):
			#print(str((360*x)+90) + "deg to " + str((360*x)+270) + "deg")
			if ((360*x) + 90) <= self.rotation_degrees.z && self.rotation_degrees.z <= ((360*x) + 270):
				blow_particles.emitting = true
				print("PARTICLES FALLING")
			elif ((360*x) - 90) <= self.rotation_degrees.z && self.rotation_degrees.z <= ((360*x)+ 90):
				blow_particles.emitting = false
				print("NO PARTICLES")
		
	
