extends CanvasLayer

class_name Gui

@onready var pause_menu = $PauseMenu
@onready var pause_button = $PauseButton
@onready var button_sound = $PauseMenu/ButtonSound

func _ready():
	set_process(false)
	pause_button.visible = false
	pass

func _process(delta):
	if Input.is_action_just_pressed("pause"):
			get_tree().paused = true
			pause_menu.visible = true
		
func _on_resume_pressed():
	button_sound.play()
	await button_sound.finished
	pause_menu.visible = false
	get_tree().paused = false
	
func _on_quit_pressed():
	button_sound.play()
	await button_sound.finished
	get_tree().quit()

func _on_pause_button_pressed():
	button_sound.play()
	await button_sound.finished
	get_tree().paused = true
	pause_menu.visible = true

func _on_back_to_main_pressed():
	button_sound.play()
	await button_sound.finished
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scene/main.tscn")
	
func stop():
	set_process(false)
	pause_button.visible = false
	
func on_game():
	set_process(true)
	pause_button.visible = true
	
	

