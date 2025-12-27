extends Control

@onready var return_button: Button = $PanelContainer/MarginContainer/VBoxContainer/ReturnButton
@onready var end_label: Label = $PanelContainer/MarginContainer/VBoxContainer/EndLabel
@onready var score_label: Label = $PanelContainer/MarginContainer/VBoxContainer/ScoreLabel

func _ready() -> void:
	return_button.grab_focus()
	update_end_label()
	score_label.text = "Your score: " + str(GameManager.score)

func update_end_label():
	if GameManager.lives <= 0:
		end_label.text = "Game over"
	else:
		end_label.text = "Congratulations!"

func _on_return_button_pressed() -> void:
	GameManager.restart_game()
