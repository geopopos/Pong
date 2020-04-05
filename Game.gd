extends Node2D

export (PackedScene) var Brick 

export var max_score: int = 7
export var player1_score: int
export var player2_score: int
var winner
var ball
var screensize


func _ready():
	randomize()
	screensize = get_viewport_rect().size

func game_start():
	player1_score = 0
	player2_score = 0
	$HUD.update_score("Score1Label", player1_score)
	$HUD.update_score("Score2Label", player2_score)
	populate_bricks()
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
		player2_score += 1
		$HUD.update_score("Score2Label", player2_score)
	elif player_name == "Side 2":
		player1_score += 1
		$HUD.update_score("Score1Label", player1_score)
	print("Player 1: " + str(player1_score))
	print("Player 2: " + str(player2_score))
	if check_win():
		game_over()
	else:
		yield(get_tree().create_timer(1.0), "timeout")
		add_child(load("res://Ball/Ball.tscn").instance())
		$Ball.connect("scored", self, "_on_Ball_scored")

func check_win():
	if player1_score >= 7:
		winner = "Player 1"
		return true
	elif player2_score >= 7:
		winner = "Player 2"
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
