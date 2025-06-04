extends Area2D

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer




func _on_body_entered(body: CharacterBody2D) -> void:
	print("+fruit")
	animation_player.play("pickup")
