extends CanvasLayer
class_name UI

@onready var points_lable = $MarginContainer/PointsLable
@onready var startmenu = $MarginContainer/Startmenu
@onready var game_over_box = $MarginContainer/GameOverBox
@onready var button_sound = $ButtonSound
@onready var high_score_lable = $MarginContainer/GameOverBox/highScore

func _ready():
	points_lable.text = "%d" % 0
	startmenu.visible = true
	points_lable.visible = false
	
func on_game():
	points_lable.visible = true
	startmenu.visible = false
	
func update_points(points: int):
	points_lable.text = "%d" % points

func on_game_over(highscore):
	game_over_box.visible = true
	high_score_lable.text = "%d" %highscore
	
func _on_button_pressed():
	button_sound.play()
	await button_sound.finished
	get_tree().reload_current_scene()

func _on_quite_pressed():
	button_sound.play()
	await button_sound.finished
	get_tree().quit()

func _on_how_to_play_pressed():
	button_sound.play()
	await button_sound.finished
	get_tree().change_scene_to_file("res://Scene/how_to_play.tscn")

func _on_options_pressed():
	button_sound.play()
	await button_sound.finished
	get_tree().change_scene_to_file("res://Scene/options.tscn")


