extends CharacterBody2D

@export var move_speed: float = 100
@export var jump_force: float = -250
@export_range(0.0, 1.0) var friction = 0.1
@export_range(0.0 , 1.0) var acceleration = 0.25

@onready var anim_player: AnimationPlayer = $AnimationPlayer

var grav: float = 980
var move: Vector2

func _ready() -> void:
	move = Vector2.ZERO

func _physics_process(delta: float) -> void:
	if velocity.y < 0:
		velocity.y += grav * delta
	else: 
		velocity.y += (grav*1.5) * delta
	if move.x != 0:
		if move.x < 0: $Sprite2D.flip_h = true
		else: $Sprite2D.flip_h = false
		velocity.x = lerp(velocity.x, move.x * move_speed, acceleration)
	else:
		velocity.x = lerp(move.x, 0.0, friction)
	
	if Input.is_action_just_pressed('Jump') and is_on_floor():
		velocity.y = jump_force
	
	move_and_slide()

func _input(event: InputEvent) -> void:
	move = Input.get_vector("Left", "Right", "blank", "blank")
	
