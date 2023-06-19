extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var Wall = preload("res://wall.tscn") 


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = JUMP_VELOCITY

	move_and_slide()

func WallReset():
	var wallInstance = Wall.instantiate()
	wallInstance.position = Vector2(500, randi_range(-100, -300))
	get_parent().call_deferred("add_child", wallInstance)

func _on_resetter_body_entered(body):
	if body.name == "Walls":
		body.queue_free()
		WallReset()
