extends Area2D

# 
@onready var pickup_sound: AudioStreamPlayer2D = $AudioStreamPlayer2D

# 
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):  # 
		print("Player collided with fruit!")
		
		#ick up
		if pickup_sound:
			pickup_sound.stop()  # 
			pickup_sound.play()  #

		# 
		await pickup_sound.finished  #ا

		# ا
		queue_free()
