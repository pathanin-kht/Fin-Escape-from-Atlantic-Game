extends CharacterBody2D
class_name Player 
signal game_started

@export var gravity = 900.0
@export var jump_force: int = -300
@onready var animation_player = $AnimationPlayer
@onready var swim = $swim
@onready var hurt = $hurt
@onready var music = $music
@onready var effects = $Effects
@onready var hurt_timer = $hurtTimer
@onready var death = $death

var death_played = false
var max_speed = 400
var rotation_speed = 2
var is_started = false
var should_process_input = true

func _ready():  
	velocity = Vector2.ZERO
	animation_player.play("idle")
	music.play()
	
func _physics_process(delta):
	if Input.is_action_just_pressed("jump")&& should_process_input:
		if !is_started:
			game_started.emit()
			animation_player.play("swim")
			is_started = true
		jump()
		swim.play()    
	if !is_started:
		return
	velocity.y += gravity * delta
	velocity.y = min(velocity.y, max_speed)
	move_and_collide(velocity * delta)
	rotate_player()
	
func jump():
	velocity.y = jump_force
	rotation = deg_to_rad(-30)

func rotate_player():
	if velocity.y > 0 and rad_to_deg(rotation) < 90:
		rotation += rotation_speed * deg_to_rad(1)
	elif velocity.y < 0 and rad_to_deg(rotation) > -30:
		rotation -= rotation_speed * deg_to_rad(1)
		
func hurt_effects ():
	if not death_played:
		effects.play("hurtBlink")
		hurt_timer.start()
		await hurt_timer.timeout
		effects.play("RESET")
		death_played = true
		
func kill():
	if not death_played:
		death.play()
		death_played = true
	should_process_input = false
	
func stop():
	animation_player.stop()
	gravity = 0
	velocity = Vector2.ZERO


	
	
