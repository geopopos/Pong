extends KinematicBody2D

export var speed = 250
var velocity: Vector2
var direction = Vector2()
var rand_dir = [-1, 1]
var middle: Vector2
var bounce_coefficient = 1.0

func _init():
	randomize()
	direction.x = rand_dir[randi()%1]
	direction.y = rand_dir[randi()%1]

# Called when the node enters the scene tree for the first time.
func _ready():
	middle = Vector2(OS.window_size.x/2, OS.window_size.y/2)
	position = middle
	velocity = direction * speed
	
func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		var motion = collision.remainder.bounce(collision.normal)
		velocity = velocity.bounce(collision.normal)
		move_and_collide(motion)