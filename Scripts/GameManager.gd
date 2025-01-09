extends Node2D

@onready var player = $"../Player" as Player
@onready var obstacle_spawner = $"../ObstacleSpawner" as ObstacleSpawner
@onready var ground = $"../Ground" as Ground
@onready var fade = $"../Fade" as Fade
@onready var ui = $"../UI" as UI
@onready var item = $"../Item" as Item
@onready var speed_item = $"../SpeedItem" as SpeedItem
@onready var bomb = $"../Bomb" as Bomb
@onready var gui = $"../GUI" as Gui
@onready var timer = $"../Timer" as Timeset
@onready var speed_timer = $"../SpeedTimer"
@onready var time_item = $"../SpeedTimer/TimeItem"
@onready var itemlable = $"../Itemtime/Itemlable"
@onready var bomblable = $"../Bomblable/Bomblable"


var points = 0
var is_game_over = false
var groundspeed = -150
var obstaclespped = -150
var seconds = 2
var ItemSpeed = -150
const SAVEFILE = "user://savefile.save"
var highscore = 0

func _ready():
	load_score()
	player.game_started.connect(on_game_started)
	ground.player_crashed.connect(end_game)
	obstacle_spawner.player_crashed.connect(end_game)
	obstacle_spawner.point_scored.connect(on_point_scored)
	item.point_scored.connect(on_point_scored_2) 
	speed_item.point_scored.connect(on_point_scored_3)
	bomb.point_scored.connect(on_point_scored_4)

func on_game_started():
	obstacle_spawner.start_spawning_obstacles()
	item.start_spawning_item() 
	speed_item.start_spawning_item()
	bomb.start_spawning_item()
	ui.on_game() 
	timer.on_game()
	gui.on_game()
	

func end_game():
	if points > highscore:
		highscore = points
		save_score()
	if fade != null:
		fade.play()
	ground.stop()
	player.hurt_effects()
	player.kill()
	obstacle_spawner.stop()
	item.stop()
	speed_item.stop()	
	bomb.stop()
	ui.on_game_over(highscore)
	timer.on_game_over()
	gui.stop()
	stop_lable()
	is_game_over = true 
	
func on_point_scored():
	points += 1
	ui.update_points(points)
	
func on_point_scored_2():
	points += 3
	ui.update_points(points)
	itemlable.visible = true
	$"../Itemtime".start(0.8)

func on_point_scored_3():
	obstacle_spawner.obstacle_speed -= 20
	ground.speed -= 20
	player.effects.play("Collect_speed")
	print("Current obstacle_spawner speed: ", obstacle_spawner.obstacle_speed,ground.speed) 
	time_item.visible = true
	$"../SpeedTimer".start(2)
	
func on_point_scored_4():
	player.hurt_effects()
	player.hurt.play()
	points -= 2
	ui.update_points(points)
	bomblable.visible = true
	$"../Bomblable".start(0.8)
func reset_speed():
	if not is_game_over:
		obstacle_spawner.obstacle_speed = obstaclespped
		ground.speed = groundspeed
		time_item.visible = false
	print("Current obstacle_spawner speed: ", ground.speed)
	
func hide_label():
	itemlable.visible = false
	bomblable.visible = false

func stop_lable():
	if not is_game_over:
		itemlable.visible = false
		bomblable.visible = false
		time_item.visible = false

func save_score():
	var file = FileAccess.open(SAVEFILE, FileAccess.WRITE_READ)
	file.store_32(highscore)
	
func load_score():
	var file = FileAccess.open(SAVEFILE, FileAccess.READ)
	if FileAccess.file_exists(SAVEFILE):
		highscore = file.get_32()
