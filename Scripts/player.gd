extends CharacterBody2D

#get player's sprite node 
@onready var anim = $anim as AnimatedSprite2D
#get screen size for screenwrapping (maybe there's a better way and i'm just dumb)
@onready var screen_size = get_viewport_rect().size

const SPEED = 200.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Decides if player can be controlled or not.
var alive = true

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if is_on_floor():
		var collider = get_last_slide_collision().get_collider()
		velocity.y = JUMP_VELOCITY * collider.jump_force
		if collider.has_method("response"):
			collider.response()
		$jump_fx.play()
	#handle sprite anims (maybe place this somewhere else in the future?)
	if velocity.y > 0:
		anim.play("fall")
	else:
		anim.play("idle")
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions. (consider replaced!)
	var direction = Input.get_axis("move_left", "move_right")
	if direction and alive:
		velocity.x = direction * SPEED
		anim.scale.x = -direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	position.x = wrapf(position.x, 0, screen_size.x)

func die():
	alive = false;
	anim.flip_v = true
	velocity = Vector2.ZERO
	set_collision_mask_value(2,0)
	set_collision_mask_value(3,0)
	
	


