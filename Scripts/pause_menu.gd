extends Control

@onready var pause_menu = $MarginContainer
@onready var v_box_container = $MarginContainer/VBoxContainer
@onready var resume = $MarginContainer/VBoxContainer/Resume

func open_pause_menu():
	get_tree().paused = true
	pause_menu.show()
	resume.grab_focus()

func close_pause_menu():
	get_tree().paused = false
	hide()
	emit_signal("resume")

func _on_quit_pressed():
	get_tree().quit()

func _on_resume_pressed():
	close_pause_menu()

func _input(event):
	if (event.is_action_pressed("ui_cancel") or event.is_action_pressed("pause")) and visible:
		open_pause_menu() 
	else:
		close_pause_menu()
