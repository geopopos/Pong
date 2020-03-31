extends Node2D

export var max_score: int = 7
export var player1_score: int
export var player2_score: int
var winner
var ball


func _ready():
	randomize()
	player1_score = 0
	player2_score = 0
	add_child(load("res://Ball/Ball.tscn").instance())
	$Ball.connect("scored", self, "_on_Ball_scored")


func _process(delta):
	pass


func _on_Ball_scored(player_name):
	if player_name == "Side 1":
		player2_score += 1
	elif player_name == "Side 2":
		player1_score += 1
	print("Player 1: " + str(player1_score))
	print("Player 2: " + str(player2_score))
	yield(get_tree().create_timer(1.0), "timeout")
	if check_win():
		print (winner + " Won!")

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
