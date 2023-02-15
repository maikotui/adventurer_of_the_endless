extends CharacterBody2D


@export
var move_speed:float = 50

@onready
var anim_tree = get_node("AnimationTree")
@onready
var state_machine: AnimationNodeStateMachinePlayback = anim_tree["parameters/playback"]


func _ready():
	$AnimatedSprite2D.play()


func _physics_process(_delta):
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_dir.normalized() * move_speed
	if velocity.length() > 0:
		anim_tree.set("parameters/Idle/blend_position", input_dir)
		anim_tree.set("parameters/Running/blend_position", input_dir)
		state_machine.travel("Running")
	else:
		state_machine.travel("Idle")
	
	move_and_slide()
	
