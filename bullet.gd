extends Area2D

var direction: Vector2 = Vector2(1, 0)  #
const BULLET_SPEED = 400  #

# 
func set_direction(new_direction: Vector2) -> void:
	direction = new_direction

# 
func _ready():
	add_to_group("bullets")
	
	connect("body_entered", Callable(self, "_on_body_entered"))

func _process(delta: float) -> void:
	position += direction * BULLET_SPEED * delta

# 
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("enemy"):  # 
		queue_free()  # 
		
		# 
		if body.has_method("play_bomb_animation"):
			body.play_bomb_animation()  #
