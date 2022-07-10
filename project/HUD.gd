extends CanvasLayer

# start_game signals the button is clicked to Main node
signal start_game

func show_message(text):
	$Message.text = text
	$Message.show()
	$Message.Timer.start()


# show_game_over function called when the Player is defeated.
# This function shows "Game Over" text for 2s and get back to Title screen, and wait a while then shows "Start" button
func show_game_over():
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	yield($MessageTimer, "timeout")

	$Message.text = "Dodge the\nCreeps!"
	$Message.show()

	# Make a one-shot timer and wait for it to finish.
	yield(get_tree().create_timer(1), "timeout")
	$StartButton.show()


# update_score is called by Main when score changes
func update_score(score):
	$ScoreLabel.text = str(score)


func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")

func _on_MessageTimer_timeout():
	$Message.hide()
