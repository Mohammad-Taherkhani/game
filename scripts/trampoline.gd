extends Area2D

@onready var trampoline = $trampoline  # 

func _ready():
	#
	if trampoline == null:
		print("Trampoline node is not found!")
		return  # 

	# 
	self.connect("body_entered", Callable(self, "_on_trampoline_entered"))
	self.connect("body_exited", Callable(self, "_on_trampoline_exited"))
  
	trampoline.add_to_group("trampoline")  # 
  
func _on_trampoline_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		print("Player entered the Trampoline area")
		area.set_jump_power(true)  # 

func _on_trampoline_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		print("Player exited the Trampoline area")
		area.set_jump_power(false)  # 
