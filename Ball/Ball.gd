extends KinematicBody2D

export var speed = 250
var velocity: Vector2
var direction = Vector2()
var rand_dir = [-1, 1]
var middle: Vector2
var bounce_coefficient = 1.0

signal scored(player_name)

func _init():
	direction.x = rand_dir[((randi()%2)-1)-1]
	direction.y = rand_dir[((randi()%2)-1)-1]

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

		if collision.get_collider_shape().get_name() == "Side 1" || collision.get_collider_shape().get_name() == "Side 2":
			emit_signal("scored", collision.get_collider_shape().get_name())
			queue_free()