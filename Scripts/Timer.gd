extends CanvasLayer

class_name Timeset

@onready var panel = $Panel
@onready var timeset = $Timeset
@onready var minutes_lable = $Timeset/Panel/minutes_lable
@onready var seconds_lable = $Timeset/Panel/seconds_lable
@onready var msec_lable = $Timeset/Panel/msec_lable


var time: float = 0.0
var minutes: int = 0
var seconds: int = 0
var msec: int = 0
var is_game_running: bool = false

func _process(delta) -> void:
	if is_game_running:
		time += delta
		msec = fmod(time, 1) * 100
		seconds = fmod(time, 60)
		minutes = fmod(time, 3600) / 60
		$Timeset/Panel/minutes_lable.text = "%02d." % minutes
		$Timeset/Panel/seconds_lable.text = "%02d." % seconds
		$Timeset/Panel/msec_lable.text = "%03d" % msec
	
func _ready():
	$Timeset.visible = false

func on_game():
	is_game_running = true
	$Timeset.visible = true
	
func on_game_over():
	stop()
	
func stop() -> void:
	set_process(false)

func get_time_formatted() -> String:
	return "02d.%02d.%03d" % [minutes, seconds, msec]
	
	
