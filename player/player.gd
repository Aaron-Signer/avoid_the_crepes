extends Area2D

signal hit

@export var speed: int = 300
var screen_size # Size of the game window.

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	screen_size = get_viewport_rect().size
	position=Vector2(screen_size.x / 2, screen_size.y/2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	rotate_player()

	
	var velocity = Vector2.ZERO
	if Input.is_key_pressed(KEY_W):
		velocity += Vector2.UP
		
	if Input.is_key_pressed(KEY_D):
		velocity += Vector2.RIGHT
		
	if Input.is_key_pressed(KEY_S):
		velocity += Vector2.DOWN

	if Input.is_key_pressed(KEY_A):
		velocity += Vector2.LEFT
		
	if velocity.length() > 0:
		rotate_player_2(velocity.normalized())
		position += velocity.normalized()*speed*delta
		position = position.clamp(Vector2.ZERO, screen_size)
		$AnimatedSprite2D.play("walk")
	else:
		rotate_player_2(Vector2.UP)
		$AnimatedSprite2D.stop()
	

func _input(event):
	pass


func rotate_player():
	var mouse_pos_vector2 = get_viewport().get_mouse_position()
	var a = Vector2(mouse_pos_vector2.x, mouse_pos_vector2.y)
#	print("mouse raw: " + str(mouse_pos_vector2.angle()))
#
#	print("player pos: " + str(position) + ", Mouse Position: " + str(mouse_pos_vector2) +  ", mouse to player: " + str(position.angle_to(mouse_pos_vector2)))
#	print("2 player pos: " + str(position) + ", Mouse Position: " + str(mouse_pos_vector2) +  ", mouse to player: " + str((mouse_pos_vector2 - position).angle()))
#	print("rotation: " + str(rotation))
#		var rotation_angle_rad = position.angle_to(mouse_pos_vector2)
	var rotation_angle_rad = (mouse_pos_vector2 - position).angle()

#		print(rotation_angle_rad)
	rotate(rotation_angle_rad - rotation + PI/2)
	
func rotate_player_2(velocity):
	rotate(velocity.angle() - rotation + PI/2)

func start(pos):
	position = pos
	show()
	var colis = $CollisionShape2D
	colis.disabled = false

func _on_body_entered(body):
	hide() # Player disappears after being hit.
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)
