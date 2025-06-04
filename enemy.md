extends CharacterBody2D

# 
func _ready():
	add_to_group("enemy")

#
func play_bomb_animation():
	var animated_sprite = $AnimatedSprite2D  # 
	var bomb_sound = $bomb_sound  # 

	if animated_sprite and bomb_sound:
		animated_sprite.play("bomb")  # 
		bomb_sound.play()  # 
		# 
		animated_sprite.connect("animation_finished", Callable(self, "_on_bomb_animation_finished"))

# 
func _on_bomb_animation_finished():
	queue_free()  # حذف دشمن از صحنه
