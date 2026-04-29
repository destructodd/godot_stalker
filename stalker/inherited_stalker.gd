extends CharacterBody2D

var move_choice = [true, false]
var screen_size
var speed = (randi_range(10,200))
var direction = Vector2.ZERO
var last_dir = 'down'
var player = CharacterBody2D

func _ready() -> void:
	screen_size = get_viewport_rect().size
	$AnimatedSprite2D.speed_scale = (speed/20)

func _process(delta):
	animation()
	velocity = direction * speed
	move_and_slide()

func _on_timer_timeout():
	$Timer.wait_time = (randi_range(0,2))
	$Timer.start() 
	if move_choice.pick_random():
		player = get_tree().get_first_node_in_group("player")
		direction = (player.global_position - position).normalized()

	else: 
		direction = Vector2.ZERO
		
func animation():
	if velocity.length() > 0.1:
		$AnimatedSprite2D.play()
		if abs(velocity.y) > abs(velocity.x):
			if velocity.y < 0: 
				$AnimatedSprite2D.animation = 'up'
				last_dir = 'up' 
			else: 
				$AnimatedSprite2D.animation = 'down'
				last_dir = 'down' 
		else:
			$AnimatedSprite2D.animation = 'left'
			last_dir = 'left' 
			$AnimatedSprite2D.flip_h = velocity.x > 0
	else:
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.animation = last_dir		
