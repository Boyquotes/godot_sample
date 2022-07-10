extends Area2D
signal hit

# How fast the player will move (pixels/sec)
# export keyworld will make this variable modifiable in the Godot App.
export var speed = 400 

# Size of the game window
var screen_size 

func _ready():
	screen_size = get_viewport_rect().size
	hide()

func _process(delta):
	# velocity is Player's movement vector (First, <0, 0> vector used)
	var velocity = Vector2.ZERO

	if Input.is_action_pressed('move_right'):
		velocity.x += 1
	if Input.is_action_pressed('move_left'):
		velocity.x -= 1
	if Input.is_action_pressed('move_up'):
		velocity.y -= 1
	if Input.is_action_pressed('move_down'):
		velocity.y += 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

	# if the velocity has +- x property
	if velocity.x != 0:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = (velocity.x < 0)

	# else if the velocity hase +- y property
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = (velocity.y > 0)



func _on_Player_body_entered(body):
	# Player disappears after being hit.
	hide()
	emit_signal("hit")
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)

# function start is called for initializing Player in new game
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
