extends CharacterBody2D

signal health_depleted

var health = 100.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * 300
	move_and_slide()
	play_animation()
	swap_direction()
	
	const DAMAGE_RATE = 5.0
	var overlapping_enemies = %HurtBox.get_overlapping_bodies()
	
	if overlapping_enemies.size() > 0:
		health -= DAMAGE_RATE * overlapping_enemies * delta
		if health <= 0.0:
			health_depleted.emit()
	
func swap_direction():
	if velocity.x > 0:
		$HappyBoo.scale = Vector2(1,1)
	elif velocity.x < 0:
		$HappyBoo.scale = Vector2(-1,1)
		
func play_animation():
	if velocity.length() > 0.0:
		$HappyBoo.play_walk_animation()
	else:
		$HappyBoo.play_idle_animation()
