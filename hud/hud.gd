extends CanvasLayer

signal start_game

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func show_message(text: String):
	var message_label: Label = $MessageLabel
	message_label.text = text
	message_label.show()
	$MessageTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func update_score(score):
	$ScoreLabel.text = str(score)
	
func show_game_over():
	show_message("Game Over!")
	await $MessageTimer.timeout
	
	$MessageLabel.text = "Dodge the Crepes"
	$MessageLabel.show()
	
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()

func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()
	
func _on_message_timer_timeout():
	$MessageLabel.hide()
