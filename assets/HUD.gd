extends CanvasLayer

signal start_game

func _ready():
	pass


func show_message(msg):
	$Message.text = msg
	$Message.show()
	$MessageTimer.start()


func show_game_over():
	show_message('Game Over')
	yield($MessageTimer, 'timeout')
	$Message.text = 'Sample Game'
	$Message.show()
	# Create one-shot timer and wait for it (delay)
	yield(get_tree().create_timer(1), 'timeout')
	$StartButton.show()


func update_score(score):
	$ScoreLabel.text = String(score)


func _on_MessageTimer_timeout():
	$Message.hide()


func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal('start_game')
