extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 160.0
var JUMP_VELOCITY = -350.0  
const  JUMP_VELOCITY_TRAMPOLINE = -800.0  
const SHOOT_COOLDOWN = 0.5


@onready var bullet_scene = preload("res://scenes/bullet.tscn") 

var shoot_timer = 0.0
var fruit_counter: int = 0  

@onready var label: Label = $"../CanvasLayer/label"  
@onready var trampoline: Node = $"../trampoline"   

var is_on_trampoline = false # 

func _ready():
	add_to_group("player")  # 

	# 
	if trampoline != null:
		trampoline.connect("body_entered", Callable(self, "_on_trampoline_entered"))
		trampoline.connect("body_exited", Callable(self, "_on_trampoline_exited"))
	else:
		print("Trampoline node not found")
	
	
	if label == null:
		print("Fruit label is not found!")
	else:
		print("Fruit label is found!")
	
	
func _physics_process(delta: float) -> void:
	# 
	if not is_on_floor():
		velocity += get_gravity() * delta

	
	if Input.is_action_just_pressed("JUMP") and is_on_floor():
		velocity.y = JUMP_VELOCITY if not is_on_trampoline else JUMP_VELOCITY_TRAMPOLINE

	# 
	var direction := Input.get_axis("MOVE_LEFT", "MOVE_RIGHT")
	
	# 
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

	#
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("default")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")

	# 
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# 
	shoot_timer =shoot_timer - delta  # 
	if shoot_timer <= 0 and Input.is_action_just_pressed("shoot"):  # دکمه L برای شلیک
		_shoot()
		shoot_timer = SHOOT_COOLDOWN  # 

	move_and_slide()

# 
func _shoot():
	var bullet = bullet_scene.instantiate() 
	get_parent().add_child(bullet)  # 

	# 
	var offset = Vector2(10, -8)  # 
	
	if animated_sprite.flip_h:  # 
		offset.x = -10 # 
	
	bullet.position = position + offset  # 

	# 
	var bullet_direction = Vector2(1, 0)  # 
	if animated_sprite.flip_h:  # ا
		bullet_direction.x = -1  # 
	
	bullet.set_direction(bullet_direction)  # 

# 
func _on_trampoline_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("player"):  # 
		print("Player entered the trampoline area!")
		is_on_trampoline = true  # 
		# 
		JUMP_VELOCITY = JUMP_VELOCITY_TRAMPOLINE  # 

# 
func _on_trampoline_exited(body: CharacterBody2D) -> void:
	if body.is_in_group("player"):  
		print("Player exited the trampoline area!")
		is_on_trampoline = false  # 
		# 
		JUMP_VELOCITY = -350.0  # 
		print("Jump power restored to normal")
	
# 
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("fruit"):
		print("Fruit collected!")
		set_fruit(fruit_counter + 1)

# 
func set_fruit(new_fruit_count: int) -> void:
	fruit_counter = new_fruit_count
	print("Fruit count: " + str(fruit_counter))  # 
	if label != null:  # 
		label.text = " : "+ str(fruit_counter)
	else:
		print("Fruit label not found")
