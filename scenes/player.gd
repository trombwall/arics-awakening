extends Node3D

const TRAVEL_TIME := 0.3

# Get references to the front and back ray nodes on ready. Godot 4.
@onready var front_ray = $FrontRay
@onready var back_ray = $BackRay

var tween

func _physics_process(_delta):
	if tween is Tween:
		if tween.is_running():
			return

	if Input.is_action_just_pressed("forward") and not front_ray.is_colliding():
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "transform", transform.translated(Vector3.FORWARD * 2), TRAVEL_TIME)
	if Input.is_action_just_pressed("backward") and not back_ray.is_colliding():
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "transform", transform.translated(Vector3.BACK * 2), TRAVEL_TIME)
	if Input.is_action_just_pressed("left"):
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "transform:basis", transform.basis.rotated(Vector3.UP, PI / 2), TRAVEL_TIME)
	if Input.is_action_just_pressed("right"):
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "transform:basis", transform.basis.rotated(Vector3.UP, -PI / 2), TRAVEL_TIME)
