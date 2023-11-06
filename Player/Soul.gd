extends CharacterBody2D


enum State {
	IDLE,
	MOVE,
	# ACTING,
	# DEAD,
}

@export var missile_scene: PackedScene = preload(
		"res://Projectiles/CrystalBall/CrystalBall.tscn")
@export var MOVE_SPEED : float = 30.0

var state : State = State.IDLE
var movement_direction : Vector2 = Vector2.ZERO

const Projectile = preload("res://Projectiles/Projectile.gd")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func cast_missile():
	if not is_able_to_cast():
		return
	var instance = missile_scene.instantiate() as Projectile
	instance.global_position = global_position
	instance.direction = Vector2(1, 0)
	print(instance.global_position)
	print(global_position)
	get_node("/root").add_child(instance)


func is_able_to_cast():
	return state == State.IDLE or state == State.MOVE


func process_input():
	movement_direction = Input.get_vector("move_left", "move_right",
			"move_down", "move_up")
	if Input.is_action_just_pressed("cast_missile"):
		cast_missile()


func state_common(_delta : float):
	process_input()


func state_idle(delta : float):
	if not is_zero_approx(movement_direction.length()):
		state = State.MOVE
		state_move(delta)
		return
	else:
		pass


func move(delta : float):
	velocity = movement_direction.normalized() * MOVE_SPEED
	move_and_slide()


func state_move(delta : float):
	if is_zero_approx(movement_direction.length()):
		state = State.IDLE
		state_idle(delta)
		return
	else:
		move(delta)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	state_common(delta);
	match state:
		State.MOVE:
			state_move(delta)
		State.IDLE:
			state_idle(delta)
