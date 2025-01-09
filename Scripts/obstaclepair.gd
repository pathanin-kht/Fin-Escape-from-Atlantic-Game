extends Node2D

class_name Obstaclepair

var speed = 0

signal player_entered
signal point_scored

func set_speed(new_speed):
	speed = new_speed
	
func _process(delta):
	position.x += speed * delta

func _on_body_entered(body):
	player_entered.emit()

func _on_scored_body_entered(body):
	point_scored.emit()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
