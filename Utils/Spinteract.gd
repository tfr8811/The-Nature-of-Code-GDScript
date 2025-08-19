extends Node

var spun = false
@export var object: Node3D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Click"):
		spun = true
	if spun:
		object.position.y += delta * 10
		object.rotate_z(delta)

func spin():
	spun = true
	Globals.spun += 1;
