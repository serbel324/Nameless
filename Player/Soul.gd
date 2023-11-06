extends CharacterBody2D

enum State {
	IDLE,
	MOVE,
	# ACTING,
	# DEAD,
} 

var state : State = State.IDLE
var movement_direction : Vector2 = Vector2.ZERO

@export var MOVE_SPEED : float = 30.0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func process_input():
	movement_direction = Vector2(
		float(Input.is_action_pressed("move_right")) - float(Input.is_action_pressed("move_left")),
		float(Input.is_action_pressed("move_up")) - float(Input.is_action_pressed("move_down"))
	)
	
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
	velocity = movement_direction.normalized() * MOVE_SPEED * delta * 1000
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

