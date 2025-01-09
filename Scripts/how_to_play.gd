extends Control

@onready var intro = $intro
@onready var animation_player = $AnimationPlayer
@onready var animation_player_2 = $AnimationPlayer2
@onready var animation_player_3 = $AnimationPlayer3
@onready var animation_player_4 = $AnimationPlayer4
@onready var button_sound = $ButtonSound

func _ready():
	intro.play()
	animation_player.play("ItemScore")
	animation_player_2.play("Stone")
	animation_player_3.play("ItemSpeed")
	animation_player_4.play("Bomb")
	
func _on_go_back_pressed():
	button_sound.play()
	await button_sound.finished
	get_tree().change_scene_to_file("res://Scene/main.tscn")
  
