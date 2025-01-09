extends Node2D

class_name Bomb

signal player_entered
signal point_scored

@export var items_speed = -150
var item_pair_scene = preload("res://Scene/bombpair.tscn")
@onready var spawn_timer = $SpawnTimer
@onready var bomb_sound = $BombSound

var obstacle_pair_scene = preload("res://Scene/obstaclepair.tscn")

@export var item_spawn_interval_min = 10.0
@export var item_spawn_interval_max = 12.0

func _ready():
	spawn_timer.start()

func start_spawning_item():
	spawn_timer.timeout.connect(spawn_item)
	set_item_spawn_timer()

func set_item_spawn_timer():
	var random_interval = randf_range(item_spawn_interval_min, item_spawn_interval_max)
	spawn_timer.wait_time = random_interval
	spawn_timer.start()

func spawn_item():
	var viewport_rect = get_viewport().get_camera_2d().get_viewport_rect()
	var half_height = viewport_rect.size.y / 2
	var min_x = viewport_rect.end.x + 300 
	var max_x = min_x + 600  

	var item_pair = item_pair_scene.instantiate() as Bombpair

	var overlap = true
	while overlap:
		item_pair.position.x = randf_range(min_x, max_x)
		item_pair.position.y = randf_range(viewport_rect.size.y * 0.15 - half_height, viewport_rect.size.y * 0.65 - half_height)
		overlap = check_overlap(item_pair)

	add_child(item_pair)
	
	item_pair.point_scored.connect(on_point_scored_4)
	item_pair.set_speed(items_speed)

func check_overlap(item_pair):
	var viewport_rect = get_viewport().get_camera_2d().get_viewport_rect()
	for obstacle in get_tree().get_nodes_in_group("obstacles"):
		if item_pair.position.distance_to(obstacle.position) < 100:
			return true
	return false
	
func stop():
	spawn_timer.stop()
	for item in get_children().filter(func (child): return child is Bombpair):
		(item as Bombpair).speed = 0
		
func on_point_scored_4():
	bomb_sound.play()
	point_scored.emit()
