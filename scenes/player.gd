extends Node3D

const TRAVEL_TIME := 0.3

# Get references to the front and back ray nodes on ready. Godot 4.
@onready var front_ray = $FrontRay
@onready var back_ray = $BackRay

# Additional raycasts for left and right collisions might be necessary
@onready var left_ray = $LeftRay
@onready var right_ray = $RightRay

# Headbob animation
@onready var animation = $Animation

var tween

func _physics_process(_delta):
    if tween is Tween:
        if tween.is_running():
            return

    # Forward and backward
    if Input.is_action_just_pressed("forward") and not front_ray.is_colliding():
        var local_forward = transform.basis.z.normalized() # Local forward direction
        tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
        tween.tween_property(self, "transform", transform.translated( - local_forward * 2), TRAVEL_TIME)
        animation.play("headbob")

    if Input.is_action_just_pressed("backward") and not back_ray.is_colliding():
        var local_backward = transform.basis.z.normalized() # Local backward direction
        tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
        tween.tween_property(self, "transform", transform.translated(local_backward * 2), TRAVEL_TIME)
        animation.play("headbob")

    # Left and right strafing
    if Input.is_action_just_pressed("strafe_left") and not left_ray.is_colliding():
        var local_left = transform.basis.x.normalized() # Local left direction
        tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
        tween.tween_property(self, "transform", transform.translated( - local_left * 2), TRAVEL_TIME)
        animation.play("headbob")

    if Input.is_action_just_pressed("strafe_right") and not right_ray.is_colliding():
        var local_right = transform.basis.x.normalized() # Local right direction
        tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
        tween.tween_property(self, "transform", transform.translated(local_right * 2), TRAVEL_TIME)
        animation.play("headbob")

    # Rotations
    if Input.is_action_just_pressed("left"):
        tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
        tween.tween_property(self, "transform:basis", transform.basis.rotated(Vector3.UP, PI / 2), TRAVEL_TIME)

    if Input.is_action_just_pressed("right"):
        tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
        tween.tween_property(self, "transform:basis", transform.basis.rotated(Vector3.UP, -PI / 2), TRAVEL_TIME)
