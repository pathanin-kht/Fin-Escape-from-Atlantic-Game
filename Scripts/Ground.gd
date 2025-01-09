extends Node2D

class_name Ground

signal player_crashed

var speed = -150

@onready var sprite1 = $Ground1/Sprite
@onready var sprite2 = $Ground2/Sprite2

func _ready():
	sprite2.global_position.x = sprite1.global_position.x + sprite1.texture.get_width()

func _process(delta):
	sprite1.global_position.x += speed * delta
	sprite2.global_position.x += speed * delta
	
	if sprite1.global_position.x < -sprite1.texture.get_width():
		sprite1.global_position.x = sprite2.global_position.x + sprite2.texture.get_width()

	if sprite2.global_position.x < -sprite2.texture.get_width():
		sprite2.global_position.x = sprite1.global_position.x + sprite1.texture.get_width()

func _on_body_entered(body):
	player_crashed.emit()
	stop()
	(body as Player).stop()
	
func stop():
	speed = 0
