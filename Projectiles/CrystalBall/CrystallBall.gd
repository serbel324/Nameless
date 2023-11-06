extends "res://Projectiles/Projectile.gd"

@export var direction : Vector2 = Vector2.ZERO
@export var SPEED : float = 100
@export var MAX_TTL : float = 3

var ttl : float


func move(delta : float):
	var velocity : Vector2 = direction.normalized() * SPEED * delta
	global_position += velocity


# Called when the node enters the scene tree for the first time.
func _ready():
	ttl = MAX_TTL


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	ttl -= delta
	if ttl <= 0:
		queue_free()
		return
	move(delta)
