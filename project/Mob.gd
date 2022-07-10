extends RigidBody2D

func _ready():
	$AnimatedSprite.playing = true

	# Get arrays of all three animation name
	# mon_types will be ["walk", "swim", "fly"]
	var mob_types = $AnimatedSprite.frames.get_animation_names()
	# Ramdomly choose betweeen this mob_type list
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]

# If the Mob is off-screen, delete(free) itself.
# Related node is VisibilityNotifier2D's signal
func _on_Visibility_viewport_exited():
	queue_free()
