extends RigidBody2D

var direction: Vector2 = Vector2.ZERO
var speed: int = 200
func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	direction = Input.get_vector("left", "right", "up", "down")
	linear_velocity = direction * speed
	if Input.is_action_just_pressed("space"):
		print("jump")
