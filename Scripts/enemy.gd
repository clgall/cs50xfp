extends "res://Scripts/platform.gd"

var direction = Vector2.RIGHT
var velocity = Vector2.ZERO
@export var speed = 100

#get screen size for screen bouncing (maybe there's a better way and i'm just dumb)
@onready var screen_size = get_viewport_rect().size
#get sprite
@onready var anim = $anim as AnimatedSprite2D

func _physics_process(delta):
	anim.play("fly")
	movement(delta)

func movement(delta):
	velocity = direction * speed
	position += velocity * delta
	
	if position.x >= screen_size.x:
		direction *= -1
		anim.flip_h = !anim.flip_h
	elif position.x <= 0:
		direction *= -1
		anim.flip_h = !anim.flip_h

func response():
	emit_signal("delete_object", self)

func _on_hurtbox_body_entered(body):
	if body.is_in_group("player") and body.has_method("die"):
		body.die()
