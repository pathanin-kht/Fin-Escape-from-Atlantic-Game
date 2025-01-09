extends Node2D

class_name Bombpair

var speed = 0
@onready var animation_player = $AnimationPlayer

signal player_entered
signal point_scored

func set_speed(new_speed):
	speed = new_speed

func _process(delta):
	position.x += speed * delta
	animation_player.play("idle")
	
func _on_bomb_2d_body_entered(body):
	point_scored.emit()
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
