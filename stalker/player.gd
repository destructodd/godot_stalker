extends CharacterBody2D

var speed: int = 200
var last_dir = 'down'

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.speed_scale = (speed/20)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity = Input.get_vector("left","right","up","down")
	animation()
	velocity = velocity * speed
	move_and_slide()
	
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
	
	
	#position += velocity * speed * delta
	

#func _on_area_entered(area: Area2D) -> void:
	#position += -velocity * 20
