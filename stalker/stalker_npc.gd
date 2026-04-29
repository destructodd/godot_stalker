extends CharacterBody2D

var move_choice = [true, false]
var screen_size
var speed = 100
var player = Area2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	$AnimatedSprite2D.speed_scale = (speed/20)
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if velocity.length() > 0.1:
		$AnimatedSprite2D.play()
	
		if abs(velocity.y) > abs(velocity.x):
			if velocity.y < 0: $AnimatedSprite2D.animation = 'up'
			else: $AnimatedSprite2D.animation = 'down'

		else:
			$AnimatedSprite2D.animation = 'left'
			$AnimatedSprite2D.flip_h = velocity.x > 0
	
	else:
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.animation = 'down'
		
	velocity = velocity * speed
	move_and_slide()
		

func _on_timer_timeout():
	$Timer.wait_time = (randi_range(0,2))
	$Timer.start() 
	if move_choice.pick_random():
		player = get_tree().get_first_node_in_group("player")
		velocity = (player.global_position - position).normalized()

	else: 
		velocity = Vector2.ZERO

func _on_area_entered(area: Area2D):
	velocity = -velocity

	
	
	 
