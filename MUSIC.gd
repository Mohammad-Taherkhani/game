extends Node

var main_music = load("res://assets/1629286884_I2gE8.mp3")

func _ready() -> void:
	pass 


func play_music():
	$main_music.play()
	



func play_die():
	$die.play()





#extends Node

#var main_music = load("res://assets/1629286884_I2gE8.mp3")

#func _ready() -> void:



#func play_music():
	#$MUSIC.stream = main_music
	#$MUSIC.play



#func play_die():
	$die.play()
