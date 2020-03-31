extends CanvasLayer

signal start_game

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()

func show_game_over(winner):
	show_message("Game Over!\n" + winner + " Won!")
	yield($MessageTimer, "timeout")
	$MessageLabel.text = "Pong\nUltimate"
	$MessageLabel.show()
	yield(get_tree().create_timer(1), 'timeout')
	$StartButton.show()


func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")

func update_score(label, score):
	print(score)
	var score_label = get_node(label)
	print(score_label.get_name())
	score_label.text = str(score)

func _on_MessageTimer_timeout():
	$MessageLabel.hide()
