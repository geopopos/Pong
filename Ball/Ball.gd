extends Area2D

export var speed = 250
var direction = Vector2()
var rand_dir = [-1, 1]

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	direction.x = rand_dir[randi()%1]
	direction.y = rand_dir[randi()%1]


func _process(delta):
	var velocity = direction * speed
	position += velocity * delta

# func _on_Ball_body_entered(body):
# 	print(body)
# 	$CollisionShape2D.set_deferred("disabled", true)

func _on_Ball_area_entered(area):
	print(area.name)
	if area.name == "Top" || area.name == "Bottom":
		print("FLIP")
		direction.y *= -1
	elif area.name == "Side 1" || area.name == "Side 2":
		print("FLIP X")
		direction.x *= -1
