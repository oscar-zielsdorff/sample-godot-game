extends RigidBody2D

export var min_speed = 150
export var max_speed = 250

func _ready():
	var mob_types = $AnimatedSprite.frames.get_animation_names()
	# { randi() % n } returns a number between 0 and n - 1
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
