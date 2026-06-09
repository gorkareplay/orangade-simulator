extends CharacterBody2D

var speed: float = 10000.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jump_speed: float = -500.0
var push_force: float = 60.0

func _physics_process(delta: float) -> void:
	var direction = Input.get_axis("left", "right") # getting the direction by converting the inputs
	
	velocity.x = direction * speed * delta 
	
	if not is_on_floor(): # applying gravity only if the body is not on the floor (there are reasons)
		velocity.y += gravity * delta
		
	if Input.is_action_just_pressed("jump") and is_on_floor(): # jumping function
		velocity.y = jump_speed
		
	move_and_slide() # moving the player based on velocity
	
	for i in get_slide_collision_count(): # making the character 2d interact with a rigid body
		var colider = get_slide_collision(i) # idk what this code does completelly, took it from "KidsCanCode"
		if colider.get_collider() is RigidBody2D:
			colider.get_collider().apply_central_impulse(-colider.get_normal() * push_force)
	
