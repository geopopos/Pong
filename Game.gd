extends Node2D

export (PackedScene) var Brick 

export var max_hearts: int = 3 
export var player1_hearts: int
export var player2_hearts: int
var winner
var ball
var screensize


func _ready():
	randomize()
	screensize = get_viewport_rect().size

func game_start():
	player1_hearts = 3
	player2_hearts = 3
	$HUD.update_health("player", player1_hearts)
	$HUD.update_health("player2", player2_hearts)
	populate_bricks()
	$BGMusic.play()
	$HUD.show_message("Get Ready")
	yield(get_tree().create_timer(3.0), "timeout")
	add_child(load("res://Ball/Ball.tscn").instance())
	$Ball.connect("scored", self, "_on_Ball_scored")	

func game_over():
	$HUD.show_game_over(winner)

func _process(delta):
	pass


func _on_Ball_scored(player_name):
	if player_name == "Side 1":
		player1_hearts -= 1
		$HUD.update_health("player1", player1_hearts)
	elif player_name == "Side 2":
		player2_hearts -= 1
		$HUD.update_health("player2", player2_hearts)
	print("Player 1: " + str(player1_hearts))
	print("Player 2: " + str(player2_hearts))
	if check_win():
		game_over()
	else:
		yield(get_tree().create_timer(1.0), "timeout")
		add_child(load("res://Ball/Ball.tscn").instance())
		$Ball.connect("scored", self, "_on_Ball_scored")

func check_win():
	if player1_hearts <= 0:
		winner = "Player 2"
		return true
	elif player2_hearts <= 0:
		winner = "Player 1"
		return true
	return false

func populate_bricks():
	var brick_pos = Vector2(48, 16)
	for i in range(screensize.y/(40)):
		var brick = Brick.instance()
		add_child(brick)
		brick.position = brick_pos
		brick_pos.y +=40 

	brick_pos = Vector2(800, 16)
	for i in range(screensize.y/(40)):
		var brick = Brick.instance()
		add_child(brick)
		brick.position = brick_pos
		brick_pos.y +=40 
