extends Node2D
class_name ObstacleSpawner
signal player_crashed
signal point_scored

var obstacle_pair_scene = preload("res://Scene/obstaclepair.tscn")

@export var obstacle_speed = -150
@onready var spawn_timer = $SpawnTimer
@onready var score = $Score

func _ready():
	spawn_timer.start()
	
func start_spawning_obstacles():
	spawn_timer.timeout.connect(spawn_obstacle)
	
func spawn_obstacle() :
	var obstacle = obstacle_pair_scene.instantiate() as Obstaclepair
	add_child(obstacle)
	
	var viewport_rect = get_viewport().get_camera_2d().get_viewport_rect()
	obstacle.position.x = viewport_rect.end.x
	
	var half_height = viewport_rect.size.y / 2
	obstacle.position.y = randf_range(viewport_rect.size.y * 0.15 - half_height, viewport_rect.size.y * 0.65 - half_height)
	
	obstacle.player_entered.connect(on_player_entered)
	obstacle.point_scored.connect(on_point_scored)
	obstacle.set_speed(obstacle_speed)
	
func on_player_entered():
		player_crashed.emit()
		stop()
	
func stop():
	spawn_timer.stop()
	for obstacle in get_children().filter(func (child): return child is Obstaclepair):
		(obstacle as Obstaclepair).speed = 0
		
func on_point_scored():
	score.play()
	point_scored.emit()
