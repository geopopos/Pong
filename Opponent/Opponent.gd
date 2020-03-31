extends KinematicBody2D


export var speed = 200
var screensize

func _ready():
	screensize = get_viewport_rect().size


func _process(delta):
	var velocity = Vector2()
	if get_parent().has_node("Ball"):
		var ball = get_parent().get_node("Ball")
		if ball.position.y > (position.y - 16):
			velocity.y += 1
		elif ball.position.y < (position.y + 16):
			velocity.y -= 1
		if velocity.length() > 0:
			velocity *= speed
		position += velocity * delta
		position.y = clamp(position.y, 0, screensize.y)

